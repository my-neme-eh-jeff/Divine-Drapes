const UserSchema = require("../models/userSchema");
const ProductSchema = require("../models/productSchema");
const OrderSchema = require("../models/orderSchema");

const bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");
const otpGenerator = require("otp-generator");
const { model } = require("mongoose");

let mailTransporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL,
    pass: process.env.PASSWORD,
  },
  port: 4,
});

//add products

const addProduct = async (req, res) => {
  try {
    const product = new ProductSchema(req.body);
    const savedProduct = await product.save();
    const email = req.user.email;

    // mailTransporter.sendMail({
    //   from: process.env.EMAIL,
    //   to: email,
    //   subject: "New product added",
    //   text:
    //     "A new product : (" +
    //     savedProduct.name +
    //     ") has been added on the website.",
    // });

    res.status(201).json({
      success: true,
      message: "New Product added",
      product: savedProduct,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

const allOrders = async (req, res) => {
  try {
    //"received", "shipping", "shipped", "delivered"
    const received = await OrderSchema.find({
      orderStatus: "received",
    }).populate("user product");
    const shipping = await OrderSchema.find({
      orderStatus: "shipping",
    }).populate("user product");
    const shipped = await OrderSchema.find({ orderStatus: "shipped" }).populate(
      "user product"
    );
    const delivered = await OrderSchema.find({
      orderStatus: "delivered",
    }).populate("user product");

    res.status(200).json({
      success: true,
      received: received,
      shipping: shipping,
      shipped: shipped,
      delivered: delivered,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

//update product
const updateProduct = async (req, res) => {
  try {
    const productID = req.body.id;

    await ProductSchema.findByIdAndUpdate(
      { _id: productID },
      { $set: req.body }
    );

    const product = await ProductSchema.findById({ _id: productID });

    res.json(200).status({
      success: true,
      message: "Product updated successfully",
      product: product,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

//delete a product

const deleteProduct = async (req, res) => {
  try {
    const { productID } = req.body;

    const product = await ProductSchema.findByIdAndDelete({ _id: productID });

    res.status(200).json({
      success: true,
      message: "Product deleted",
      data: product,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

// view a particular user

const viewUser = async (req, res) => {
  try {
    const { userID } = req.body;

    const user = await UserSchema.findById({_id : userID}).populate("product order review ticket")

    res.status(200).json({
      success : true,
      data : user
    })

  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

module.exports = {
  addProduct,
  allOrders,
  updateProduct,
  deleteProduct,
  viewUser
};
