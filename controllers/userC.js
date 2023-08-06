const bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");
const otpGenerator = require("otp-generator");
const auth = require("../middleware/auth");
const jwt = require("jsonwebtoken");
const Razorpay = require("razorpay")
require("dotenv").config();

//cloudinary
const imageUpload = require("../utils/imageUpload");
const fs = require("fs");
const deleteImage = require("../utils/imageDelete");

//Schema
const UserSchema = require("../models/userSchema");
const ProductSchema = require("../models/productSchema");
const OrderSchema = require("../models/orderSchema");
const { log } = require("console");

let mailTransporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL,
    pass: process.env.PASSWORD,
  },
  port: 587,
});

// Get account details
const profile = async (req, res) => {
  try {
    const { fName, lName, DOB, profilePic, pfp, email, number, isVerified, addressList } =
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
        profilePic,
        addressList,
        pfp,
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
  let email = req.user.email || req.body.email;

  const updates = Object.keys(req.body);
  const allowedUpdates = [
    "fName",
    "lName",
    "number",
    "password",
    "addressList",
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

//delete user
const deleteUser = async (req, res) => {
  try {
    const user = req.user;

    const deletedUser = await UserSchema.findByIdAndDelete({ _id: user._id });

    res.status(200).json({
      success: true,
      data: deletedUser,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      error: err.message,
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

    const isProductAlreadyInCart = User.cart.includes(productID)

    if(isProductAlreadyInCart){
      return res.status(400).json({
        success : false,
        message : "Product already exists in cart"
      })
    }

    await UserSchema.findByIdAndUpdate(
      { _id: User._id },
      { $push: { cart: productID } }
    );

    res.status(200).json({
      success: true,
      message : "Product added succesfully",
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

//remove from cart
// const removeCart = async (req, res) => {
//   try {
//     const User = req.user;
//     const productID = req.params.pID;

//     const product = await ProductSchema.findById({ productID }).populate(
//       "reviews"
//     );
//     await UserSchema.findByIdAndUpdate(
//       { _id: User._id },
//       { $pop: { cart: productID } }
//     );

//     res.status(200).json({
//       success: true,
//       data: product,
//     });
//   } catch (err) {
//     res.status(500).json({
//       success: false,
//       message: err.message,
//     });
//   }
// };
//remove from cart
const removeCart = async (req, res) => {
  try {
    var ct = 0;
    var i;
    const User = req.user;
    const productID = req.params.pID;
    const product = await ProductSchema.findById({ _id: productID });
    var filtered = User.cart.filter(function (value, index, arr) {
      return value != productID;
    });
    console.log(filtered);
    await UserSchema.findByIdAndUpdate(
      { _id: User._id },
      {
        cart: filtered,
      }
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
    console.log(user)
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
    const productID = req.body.pID;
    const Product = await ProductSchema.findById({ _id: productID }).populate(
      "reviews"
    );

    const remQuantity = await ProductSchema.findByIdAndUpdate(
      { _id: productID },
      { $inc: { quantity: -1 } }
    );
    if (remQuantity.quantity == 0) {
      mailTransporter.sendMail({
        from: process.env.EMAIL,
        to: process.env.EMAIL,
        subject: "Stock over for a product",
        text: `Dear Admin, a product on your website ${Product.name}, with the product id ${productID} , is out of stock. Kindly refill the items, untill then it will be shown as out of stock`,
      });
    }

    const order = new OrderSchema({
      user: user._id,
      product: productID,
      photo: {
        isCust: req.body.isCustPhoto,
      },
      text: {
        isCust: req.body.isCustText,
        text: req.body.text,
      },
      color: {
        isCust: req.body.isCustColor,
        color: req.body.color,
      },
      paymentStatus: req.body.paymentStatus,
      paymentType: req.body.paymentType,
    });

    await order.save();

    const User = await UserSchema.findByIdAndUpdate(
      { _id: user._id },
      { $push: { order: productID } }
    );

    mailTransporter.sendMail({
      from: process.env.EMAIL,
      to: user.email,
      subject: "Order succesfully placed.",
      text: `Your order for ${Product.name} with product ID ${productID} has been placed succesfully, and can be tracked on our app in the orders section.`,
    });

    res.status(200).json({
      success: true,
      data: order,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

const addImagesForOrder = async (req, res) => {
  try {
    const _id = req.body.id; 
    const order = await OrderSchema.findById(_id)      //orderID
    const files = req.files;
    const array = [];
    for (let image of files) {
      const img = await imageUpload.imageUpload(image, "Orders");
      array.push(img.url);
      fs.unlinkSync(image.path)
    }
    order.photo.picture = array;
    order.save();
    res.status(200).json({
      success : true,
      data : order
    })
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
}

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

//view single Order
const viewSingleOrder = async(req,res) => {
  try{
    const { orderID } = req.body
    const order = await OrderSchema.findById(orderID)
    if(!order){
      return res.status(404).json({
        success: false,
        message: "No order with this id",
      })
    }

    res.status(200).json({
      success : true,
      data : order
    })
  }catch(err){
    res.status(500).json({
      success: false,
      message: err.message,
    })
  }
}

const profilePic = async (req, res) => {
  try {
    if (req.user.profilePic) {
      await deleteImage(req.user.profilePic, "profilePictures");
    }
    if (req.file) {
      const profile = await imageUpload.imageUpload(
        req.file,
        "profilePictures"
      );

      await UserSchema.findByIdAndUpdate(req.user._id, {
        profilePic: profile.url,
      });
      fs.unlinkSync(req.file.path);
      res.status(200).json({ message: profile.url });
    }
  } catch (err) {
    res.status(400).json(err);
  }
};

//payment
const payment = async(req,res)=>{
  try{
    const orderID = req.body.orderID;
    const orderDetails = await OrderSchema.findById({_id: orderID});
    // console.log(orderDetails)
    if(orderDetails.paymentType != 'cod'){
        const product = await ProductSchema.findById({_id: orderDetails.product})
        var instance = new Razorpay({ key_id: process.env.key_id, key_secret: process.env.key_secret })
        let paymentOrder = await instance.orders.create({
          amount: product.cost.value*100,
          currency: product.cost.currency
          // receipt: "receipt#1"
    })
    res.status(200).json({
      success: true,
      data: paymentOrder,orderDetails
  })}else{
  res.status(200).json({
      success: true,
      message: "PaymentType: Cash On Delivery"
    })
  } 
  }catch(err){
    res.status(400).json({
      success: false,
      message: err.message
    })
  }
}

module.exports = {
  profile,
  updateUser,
  deleteUser,
  addCart,
  removeCart,
  viewCart,
  directOrder,
  viewOrder,
  profilePic,
  addImagesForOrder,
  viewSingleOrder,
  payment
};
