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

    mailTransporter.sendMail({
      from: process.env.EMAIL,
      to: email,
      subject: "New product added",
      text:
        "A new product : (" +
        savedProduct.name +
        ") has been added on the website.",
    });

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
    const received = await OrderSchema.find({ orderStatus: "received" }).populate("user product");
    const shipping = await OrderSchema.find({ orderStatus: "shipping" }).populate("user product");
    const shipped = await OrderSchema.find({ orderStatus: "shipped" }).populate("user product");
    const delivered = await OrderSchema.find({ orderStatus: "delivered" }).populate("user product");

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

module.exports = {
  addProduct,
  allOrders,
};
