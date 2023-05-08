const UserSchema = require("../models/userSchema");
const ProductSchema = require("../models/productSchema");
const bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");
const otpGenerator = require("otp-generator");
const CartSchema = require("../models/cartSchema");
const OrderSchema = require("../models/orderSchema");
const auth = require("../middleware/auth");
const jwt = require("jsonwebtoken")

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

    const accessToken = await genAuthToken();
    res.status(201).json({
      success: true,
      data: pass,
      token: accessToken,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: error.message,
    });
  }
};

// Login
const loginUser = async (req, res) => {
  try {
    const email = req.body.email;
    const password = req.body.password;
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
      const token = jwt.sign({email:req.body.email},process.env.SECRETKEY,{expiresIn:'1d'});
      console.log(token)
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
    const list = await ProductSchema.find()

    res.status(200).json({
      success: true,
      data: list,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    })
  }
}

//view products category wise

const categoryWise = async (req,res) => {
    try {
        const category = req.params.category

        const list = await ProductSchema.find({ category : category})

        res.status(200).json({
            success: true,
            data: list,
        })
        
    }catch(err){
        res.status(500).json({
            success: false,
            message: err.message,
        })
    }
}
//add to cart
const addCart = async(req,res)=>{
  try{
    const User=req.user
    const {productName,quantity}=req.body
    const product = await  ProductSchema.findOne({name:productName})
    const cart = await UserSchema.findById({_id:User._id}).populate('cart')

  res.status(200).json({
    success: true,
  })
  }catch(err){
    res.status(500).json({
      success: false,
      message:err.message
    })
  }
}

//remove from cart
const removeCart = async(req,res)=>{
  try{

  }catch(err){
    res.status(500).json({
      success: false,
      message: err.message
    })
  }
}

module.exports = {
  createUser,
  loginUser,
  profile,
  updateUser,
  forgotPSWD,
  verifyOTP,
  allProducts,
  categoryWise,
  addCart,
  removeCart
};
