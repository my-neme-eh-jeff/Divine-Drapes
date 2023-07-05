const bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");
const otpGenerator = require("otp-generator");
const jwt = require("jsonwebtoken");
const UserSchema = require("../models/userSchema");
require("dotenv").config();

let mailTransporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL,
    pass: process.env.PASSWORD,
  },
  port: 587,
});

const createUser = async (req, res) => {
  try {
    console.log(req.body);
    let userData = new UserSchema(req.body);
    let savedUserData = await userData.save();
    let id = savedUserData._id;
    let userMail = savedUserData.email;

    let pass = await UserSchema.findById({ _id: id }, { password: 0 }); //to hide hashed pswd
    const roles = Object.values(savedUserData.roles).filter(Boolean)
    console.log(roles)

    const accessToken = jwt.sign(
      {
        UserInfo: {
          email: savedUserData.email,
          roles: roles,
        },
      },
      process.env.ACCESS_TOKEN_SECRET,
      { expiresIn: "1y" }
    )

    console.log(await bcrypt.compare(req.body.password, savedUserData.password))
    console.log(pass);
    res.status(201).json({
      success: true,
      token: accessToken
  });
    mailTransporter.sendMail({
      from: process.env.EMAIL,
      to: userMail,
      subject:
        "Thank you for creating an account with us " + savedUserData.fName,
      text: "We hope you have a good time using our app.",
    });

  } catch (error) {
    res.status(500).json({
      success: false,
      error: error.message,
    });
  }
};

const handleRefreshToken = async (req, res) => {
  const cookies = req.cookies;
  if (!cookies?.jwt) return res.sendStatus(401);
  const refreshToken = cookies.jwt;
  res.clearCookie("jwt", { httpOnly: true, sameSite: "None", secure: true });

  const foundUser = await UserSchema.findOne({ refreshToken }).exec();
  // Detected refresh token reuse!
  console.log(foundUser);
  if (!foundUser) {
    jwt.verify(
      refreshToken,
      process.env.REFRESH_TOKEN_SECRET,
      async (err, decoded) => {
        if (err) return res.sendStatus(403); //Forbidden
        console.log("attempted refresh token reuse!");
        const hackedUser = await UserSchema.findOne({
          email: decoded.email,
        }).exec();
        hackedUser.refreshToken = [];
        const result = await hackedUser.save();
        console.log(result);
      }
    );
    return res.sendStatus(403); //Forbidden
  }

  const newRefreshTokenArray = foundUser.refreshToken.filter(
    (rt) => rt !== refreshToken
  );

  // evaluate jwt
  jwt.verify(
    refreshToken,
    process.env.REFRESH_TOKEN_SECRET,
    async (err, decoded) => {
      console.log(decoded);
      if (err) {
        console.log("expired refresh token");
        foundUser.refreshToken = [...newRefreshTokenArray];
        const result = await foundUser.save();
        console.log(result);
      }
      if (err || foundUser.email !== decoded.email) return res.sendStatus(403);

      // Refresh token was still valid
      const roles = Object.values(foundUser.roles);
      const accessToken = jwt.sign(
        {
          UserInfo: {
            email: decoded.email,
            roles: roles,
          },
        },
        process.env.ACCESS_TOKEN_SECRET,
        { expiresIn: "1y" }     //1h
      );

      const newRefreshToken = jwt.sign(
        { email: foundUser.email },
        process.env.REFRESH_TOKEN_SECRET,
        { expiresIn: "1y" }      //30d
      );
      // Saving refreshToken with current user
      foundUser.refreshToken = [...newRefreshTokenArray, newRefreshToken];
      const result = await foundUser.save();

      // Creates Secure Cookie with refresh token
      res.cookie("jwt", newRefreshToken, {
        httpOnly: true,
        secure: true,
        sameSite: "None",
        maxAge: 24 * 60 * 60 * 1000,
      });

      res.json({ accessToken,success:true });
    }
  );
};

const handleLogout = async (req, res) => {
  // On client, also delete the accessToken

  const cookies = req.cookies;
  if (!cookies?.jwt) return res.sendStatus(204); //No content
  const refreshToken = cookies.jwt;

  // Is refreshToken in db?
  const foundUser = await User.findOne({ refreshToken }).exec();
  if (!foundUser) {
    res.clearCookie("jwt", { httpOnly: true, sameSite: "None", secure: true });
    return res.sendStatus(204);
  }

  // Delete refreshToken in db
  foundUser.refreshToken = foundUser.refreshToken.filter(
    (rt) => rt !== refreshToken
  );
  const result = await foundUser.save();
  console.log(result);

  res.clearCookie("jwt", { httpOnly: true, sameSite: "None", secure: true });
  res.sendStatus(204);
};

const handleLogin = async (req, res) => {
  // const cookies = req.cookies;
  console.log(req.body)
  const email = req.body.email;
  const password = req.body.password;
  console.log(password)
  if (!email || !password)
    return res
      .status(400)
      .json({ message: "email and password are required." });
  const foundUser = await UserSchema.findOne({ email: email });
  console.log(foundUser)
  if (!foundUser) return res.sendStatus(401); //Unauthorized
  // evaluate password
  const match = await bcrypt.compare(password, foundUser.password);
  // const match = password === foundUser.password
  console.log(match)
  if (match) {
    console.log(foundUser);
    const roles = Object.values(foundUser.roles).filter(Boolean);
    // create JWTs
    const accessToken = jwt.sign(
      {
        UserInfo: {
          email: foundUser.email,
          roles: roles,
        },
      },
      process.env.ACCESS_TOKEN_SECRET,
      { expiresIn: "1y" }        //10m
    );
    const newRefreshToken = jwt.sign(
      { email: foundUser.email },
      process.env.REFRESH_TOKEN_SECRET,
      { expiresIn: "1y" }    //10d
    );

    let newRefreshTokenArray = !cookies?.jwt
      ? foundUser.refreshToken
      : foundUser.refreshToken.filter((rt) => rt !== cookies.jwt);

    if (cookies?.jwt) {
      /* 
            Scenario added here: 
                1) User logs in but never uses RT and does not logout 
                2) RT is stolen
                3) If 1 & 2, reuse detection is needed to clear all RTs when user logs in
            */

      const refreshToken = cookies.jwt;
      const foundToken = await UserSchema.findOne({ refreshToken }).exec();

      // Detected refresh token reuse!
      if (!foundToken) {
        console.log("attempted refresh token reuse at login!");
        // clear out ALL previous refresh tokens
        newRefreshTokenArray = [];
      }

      res.clearCookie("jwt", {
        httpOnly: true,
        sameSite: "None",
        secure: true,
      });
    }

    // Saving refreshToken with current user
    foundUser.refreshToken = [...newRefreshTokenArray, newRefreshToken];
    await foundUser.save();

    // Creates Secure Cookie with refresh token
    res.cookie("jwt", newRefreshToken, {
      httpOnly: true,
      secure: true,
      sameSite: "None",
      maxAge: 24 * 60 * 60 * 1000,
    });

    // Send authorization roles and access token to user
    res.json({ accessToken,success:true });
  } else {
    console.log('23912039qsidbdak')
    res.sendStatus(401);
  }
};

const forgotPSWD = async (req, res) => {
  try {
    const email = req.body.email;
    const user = await UserSchema.findOne({ email: email });

    if (!user) {
      res.status(404).json({
        success: false,
        message: "User not found",
      });
    }

    const otp = otpGenerator.generate(6, {
      lowerCaseAlphabets: false,
      upperCaseAlphabets: false,
      specialChars: false,
    });
    await UserSchema.findOneAndUpdate({ email: email }, { OTP: otp });

    mailTransporter.sendMail({
      from: process.env.EMAIL,
      to: user.email,
      subject: "Forgot Password",
      text: "Enter the following OTP to reset password " + otp,
    });

    res.status(200).cookie("email", email, { secure: true }).json({
      success: true,
      message: "OTP sent via mail",
      token: token,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

//enter otp for pswd reset
const verifyOTP = async (req, res) => {
  try {
    const otp = req.body.otp;
    const email = req.body.email;
    const user = await UserSchema.find({ email: email });

    if (req.user.OTP == otp) {
      await UserSchema.findOneAndUpdate(
        { email: email }, //req.user.email
        { $set: { OTP: null } }
      );

      const token = await user.genAuthToken();

      res.status(200).clearCookie("email").json({
        success: true,
        message: "OTP verified",
        token: token,
      });
    } else {
      res.status(400).json({
        success: true,
        message: "Wrong OTP entered",
      });
    }
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

const loginUser = async (req, res) => {
  try {
    const email = req.body.email;
    const password = req.body.password;
    console.log(req.body);
    const user = await UserSchema.findOne({ email: email });
    if (!user) {
      return res.status(400).json({
        error: "User does not exist",
      });
    }

    const withoutPswd = await UserSchema.findOne(
      { email: email },
      { password: 0 }
    );

    const roles = Object.values(user.roles).filter(Boolean);

    const isPassValid = await bcrypt.compare(password, user.password);
    if (isPassValid) {
      const token = jwt.sign(
        {
          UserInfo: {
            email: user.email,
            roles: roles,
          },
        },
        process.env.ACCESS_TOKEN_SECRET,
        {
          expiresIn: "1y",
        }
      );
      res.status(200).json({
        success: true,
        data: withoutPswd,
        token: token,
      });
    } else {
      res.status(400).json({
        success: false,
        error: "Wrong password",
      });
    }
  } catch (error) {
    res.status(500).json({
      success: false,
      error: error.message,
    });
  }
};

module.exports = {
  createUser,
  loginUser,
  handleRefreshToken,
  handleLogout,
  handleLogin,
  forgotPSWD,
  verifyOTP,
};
