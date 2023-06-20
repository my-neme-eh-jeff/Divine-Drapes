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

// Login
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

    const isPassValid = await bcrypt.compare(password, user.password);
    if (isPassValid) {
      const token = jwt.sign({ email: req.body.email }, process.env.SECRETKEY, {
        expiresIn: "1d",
      });
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

// Get account details
const profile = async (req, res) => {
  try {
    res.status(200).json({
      success: true,
      data: req.user,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: error.message,
    });
  }
};

//edit user profile

const updateUser = async (req, res) => {
  // let uname = req.params.uname;
  let email = req.user.email;

  const updates = Object.keys(req.body);
  const allowedUpdates = [
    "fName",
    "lName",
    "number",
    "password",
    "addressList",
    "email",
    "DOB",
  ];
  const isValidOperation = updates.every((update) =>
    allowedUpdates.includes(update)
  );

  if (!isValidOperation) {
    return res.status(400).json({ message: "Invalid Updates!" });
  }

  let user = await UserSchema.findOne({ email: email });

  if (!user) {
    res.status(404).json({
      success: false,
      message: "User not found",
    });
  } else {
    try {
      if (req.body.email) {
        const alreadyExist = await UserSchema.findOne({
          email: req.body.email,
        });

        if (alreadyExist.length != 0) {
          res.status(400).json({
            success: false,
            message: "Email already exists",
          });
        }
      }

      await UserSchema.findOneAndUpdate({ email: email }, { $set: req.body });

      if (req.body.password) {
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(req.body.password, salt);
        let newPswd = await UserSchema.findOneAndUpdate(
          { email: email },
          { password: hashedPassword }
        );
      }

      res.status(201).json({
        success: true,
        data: req.body,
      });
    } catch (err) {
      res.status(500).json({
        success: false,
        message: err.message,
      });
    }
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

//view all products

const allProducts = async (req, res) => {
  try {
    const list = await ProductSchema.find();

    res.status(200).json({
      success: true,
      data: list,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

//view products category wise

const categoryWise = async (req, res) => {
  try {
    const category = req.params.category;

    const list = await ProductSchema.find({ category: category });

    res.status(200).json({
      success: true,
      data: list,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

//add to cart

const addCart = async (req, res) => {
  try {
    const User = req.user;
    // const {productName,quantity}=req.body
    // const product = await  ProductSchema.findOne({name:productName})
    // const cart = await UserSchema.findById({_id:User._id}).populate('cart')
    const productID = req.params.pID;
    const product = await ProductSchema.findById({ _id: productID });
    await UserSchema.findByIdAndUpdate(
      { _id: User._id },
      { $push: { cart: productID } }
    );

    res.status(200).json({
      success: true,
      data: product,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

//remove from cart
const removeCart = async (req, res) => {
  try {
    const User = req.user;
    const productID = req.params.pID;

    const product = await ProductSchema.findById({ productID });
    await UserSchema.findByIdAndUpdate(
      { _id: User._id },
      { $pop: { cart: productID } }
    );

    res.status(200).json({
      success: true,
      data: product,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

//view my cart

const viewCart = async (req, res) => {
  try {
    const user = req.user;
    const User = await UserSchema.findById({ _id: user._id }).populate(
      " order"
    );

    res.status(200).json({
      success: true,
      data: User.cart,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};
//place order
const directOrder = async (req, res) => {
  try {
    const user = req.user;
    const productID = req.params.pID;
    const Product = await ProductSchema.findById({ _id: productID });
    const User = await UserSchema.findByIdAndUpdate(
      { _id: user._id },
      { $push: { order: productID } }
    );
    res.status(200).json({
      success: true,
      data: Product,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};
//order from cart
const cartOrder = async (req, res) => {
  try {
    const user = req.user;
    const productID = user.cart;
    const product = await ProductSchema.findById({ _id: productID });
    const User = await UserSchema.findByIdAndUpdate(
      { _id: user._id },
      { $push: { order: productID } }
    );
    res.status(200).json({
      success: true,
      message: User,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};
//view Order
const viewOrder = async (req, res) => {
  try {
    const user = req.user;
    console.log(user);
    const User = await UserSchema.findById({ _id: user._id });
    console.log(User);
    res.status(200).json({
      success: true,
      data: User.order,
    });
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

  profile,
  updateUser,
  forgotPSWD,
  verifyOTP,
  allProducts,
  categoryWise,
  addCart,
  removeCart,
  viewCart,
  directOrder,
  cartOrder,
  viewOrder,
};
