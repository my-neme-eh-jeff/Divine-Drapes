const bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");
const otpGenerator = require("otp-generator");
const auth = require("../middleware/auth");
const jwt = require("jsonwebtoken");

const UserSchema = require("../models/userSchema");
const ProductSchema = require("../models/productSchema");
const OrderSchema = require("../models/orderSchema");

// Get account details
const profile = async (req, res) => {
  try {
    const { fName, lName, DOB, profilePic, email, number, isVerified } =
      req.user;
    res.status(200).json({
      success: true,
      data: {
        fName,
        lName,
        DOB,
        profilePic,
        email,
        number,
        isVerified,
      },
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
      "order cart"
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

//add review
const addReview = async (req, res) => {
  try {
    const user = req.user;
    const { productID, review, star } = req.body

    const userPurchased = await UserSchema.findOne({ _id: user._id, order: { $in: [mongoose.Types.ObjectId(productID)] } });

    const reviewObj = {
      user : user._id,
      fName : user.fName,
      review,
      star,
      verifiedPurchase : userPurchased
    }

    await ProductSchema.findByIdAndUpdate({_id : productID}, {reviews : { $push : reviewObj}})
    const product = await ProductSchema.findByIdAndUpdate({_id : productID})

    const addReviewInUser = await UserSchema.findOne({ _id: user._id, reviews: { $push : review}})
    

    res.status(200).json({
      success: true,
      message: "Review added successfully",
      data : product
    })

  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

module.exports = {
  profile,
  updateUser,
  allProducts,
  categoryWise,
  addCart,
  removeCart,
  viewCart,
  directOrder,
  cartOrder,
  viewOrder,
  addReview,
};
