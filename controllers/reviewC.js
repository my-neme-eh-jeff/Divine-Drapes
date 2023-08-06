//models
const UserSchema = require("../models/userSchema");
const ProductSchema = require("../models/productSchema");
const OrderSchema = require("../models/orderSchema");
const ReviewSchema = require("../models/reviewSchema");
const mongoose = require("mongoose")
require("dotenv").config();
//add review
const addReview = async (req, res) => {
  try {
    const user = req.user;
    const { productID, review, star } = req.body;

    const userPurchased = await UserSchema.findOne({
      _id: user._id,
      order: { $in: [mongoose.Types.ObjectId(productID)] },
    });

    const reviewObj = {
      user: user._id,
      fName: user.fName,
      review,
      star,
      verifiedPurchase: userPurchased,
    };
    console.log(reviewObj)

    const addToReviewSchema = new ReviewSchema(reviewObj);
    const savedReview = await addToReviewSchema.save();

    await ProductSchema.findByIdAndUpdate(
      { _id: productID },
      { $push: { reviews: (savedReview._id) } }
    );
    const product = await ProductSchema.findByIdAndUpdate({
      _id: productID,
    }).populate("reviews");

    const addReviewInUser = await UserSchema.findOneAndUpdate(
      { _id: user._id },
      { $push: { reviews: (savedReview._id) } }
    );

    res.status(200).json({
      success: true,
      message: "Review added successfully",
      data: product,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

// get my reviews
const myReview = async (req, res) => {
  try {
    const user = req.user;
    const reviews = await UserSchema.find({ _id: user._id })
      .populate("reviews")
      .select("reviews");

    res.status(200).json({
      success: true,
      data: reviews,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

//update my review
const updateReview = async (req, res) => {
  try {
    const { reviewID, review, star } = req.body;
    const reviewUpdate = await ReviewSchema.findByIdAndUpdate({ _id : reviewID}, {review : review, star : star})

    res.status(200).json({
        success : true,
        data : reviewUpdate
    })

  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

//delete review
const deleteReview = async (req,res) => {
    try{

        const { ticketID } = req.body
        const deleteReview = await ReviewSchema.findByIdAndDelete({_id : ticketID})

        res.status(200).json({
            success:true,
            message:"review deleted successfully",
            data : deleteReview
        })
    }catch(err){
        res.status(500).json({
            success: false,
            message: err.message,
          })
    }
}

module.exports = {
  addReview,
  myReview,
  updateReview,
  deleteReview
};
