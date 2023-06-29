const ReviewSchema = require("../models/reviewSchema");
const UserSchema = require("../models/userSchema");
const TicketSchema = require("../models/ticketSchema")
const mongoose = require("mongoose")
const verifyReview = async (req, res, next) => {
  const { reviewId } = req.body;
  const user = req.user;
  const review = await ReviewSchema.findOne({ _id: reviewId });

  const userContainsReview = await UserSchema.findOne(
    { _id: user._id },
    { reviews: { $in: [mongoose.Types.ObjectId(reviewId)] } }
  );
  if (userContainsReview) {
    req.review = review;
    next();
  } else {
    res.status(401).json({
      success: true,
      message: "Unauthorized",
    });
  }
};


const verifyTicket = async (req, res, next) => {
  const { ticketId } = req.body.id;
  const user = req.user;
  const ticket = await TicketSchema.findOne({ _id: ticketId });

  const userContainsTicket = await UserSchema.findOne(
    { _id: user._id },
    { reviews: { $in: [mongoose.Types.ObjectId(ticketId)] } }
  );
  if (userContainsTicket) {
    // console.log(user.tickets)
    // req.ticket = user.tickets;
    next();
  } else {
    res.status(401).json({
      success: true,
      message: "Unauthorized",
    });
  }
};

module.exports = {
    verifyReview,
    verifyTicket,
}
