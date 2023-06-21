const bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");
const otpGenerator = require("otp-generator");
const auth = require("../middleware/auth");
const jwt = require("jsonwebtoken");

const UserSchema = require("../models/userSchema");
const ProductSchema = require("../models/productSchema");
const OrderSchema = require("../models/orderSchema");

let mailTransporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL,
    pass: process.env.PASSWORD,
  },
  port: 4,
});

const createUser = async (req, res) => {
  try {
    let userData = new UserSchema(req.body);
    let savedUserData = await userData.save();
    let id = savedUserData._id;
    let userMail = savedUserData.email;

    mailTransporter.sendMail({
      from: process.env.EMAIL,
      to: userMail,
      subject:
        "Thank you for creating an account with us " + savedUserData.fName,
      text: "We hope you have a good time using our app.",
    });

    let pass = await UserSchema.findById({ _id: id }, { password: 0 }); //to hide hashed pswd

    const token = jwt.sign({ email: req.body.email }, process.env.SECRETKEY, {
      expiresIn: "1d",
    });
    res.status(201).json({
      success: true,
      data: pass,
      token: token,
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
  if (!foundUser) {
    jwt.verify(
      refreshToken,
      process.env.REFRESH_TOKEN_SECRET,
      async (err, decoded) => {
        if (err) return res.sendStatus(403); //Forbidden
        console.log("attempted refresh token reuse!");
        const hackedUser = await UserSchema.findOne({
          username: decoded.username,
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
      if (err) {
        console.log("expired refresh token");
        foundUser.refreshToken = [...newRefreshTokenArray];
        const result = await foundUser.save();
        console.log(result);
      }
      if (err || foundUser.username !== decoded.username)
        return res.sendStatus(403);

      // Refresh token was still valid
      const roles = Object.values(foundUser.roles);
      const accessToken = jwt.sign(
        {
          UserInfo: {
            username: decoded.username,
            roles: roles,
          },
        },
        process.env.ACCESS_TOKEN_SECRET,
        { expiresIn: "10s" }
      );

      const newRefreshToken = jwt.sign(
        { username: foundUser.username },
        process.env.REFRESH_TOKEN_SECRET,
        { expiresIn: "1d" }
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

      res.json({ roles, accessToken });
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
  const cookies = req.cookies;
  console.log(`cookie available at login: ${JSON.stringify(cookies)}`);

  const email = req.body.email;
  const password = req.body.password;
  if (!email || !password)
    return res
      .status(400)
      .json({ message: "Username and password are required." });
  const foundUser = await UserSchema.findOne({ email: email });

  if (!foundUser) return res.sendStatus(401); //Unauthorized
  // evaluate password
  const match = await bcrypt.compare(password, foundUser.password);
  if (match) {
    const roles = Object.values(foundUser.roles).filter(Boolean);
    // create JWTs
    const accessToken = jwt.sign(
      {
        UserInfo: {
          username: foundUser.username,
          roles: roles,
        },
      },
      process.env.ACCESS_TOKEN_SECRET,
      { expiresIn: "10m" }
    );
    const newRefreshToken = jwt.sign(
      { username: foundUser.username },
      process.env.REFRESH_TOKEN_SECRET,
      { expiresIn: "10d" }
    );

    // Changed to let keyword
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
      const foundToken = await User.findOne({ refreshToken }).exec();

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
    const result = await foundUser.save();
    console.log(result);
    console.log(roles);

    // Creates Secure Cookie with refresh token
    res.cookie("jwt", newRefreshToken, {
      httpOnly: true,
      secure: true,
      sameSite: "None",
      maxAge: 24 * 60 * 60 * 1000,
    });

    // Send authorization roles and access token to user
    res.json({ roles, accessToken, foundUser });
  } else {
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

    const token = await user.genAuthToken();

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
    const email = req.cookies.email;
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

module.exports = {
  createUser,
  // loginUser,
  handleRefreshToken,
  handleLogout,
  loginUser: handleLogin,
  forgotPSWD,
  verifyOTP,
};
