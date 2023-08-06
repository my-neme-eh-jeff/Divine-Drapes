const ReviewSchema = require("../models/reviewSchema");
const UserSchema = require("../models/userSchema");
const TicketSchema = require("../models/ticketSchema")
const mongoose = require("mongoose")
const verifyReview = async (req, res, next) => {
  const { reviewID } = req.body;
  const user = req.user;
  const review = await ReviewSchema.findOne({ _id: reviewID });
  console.log(user);

  const userContainsReview = user.reviews.includes(reviewID)

  if (userContainsReview) {
    req.review = review;
    next();
  } else {
    res.status(401).json({
      success: false,
      message: "Unauthorized",
    });
  }
};


const verifyTicket = async (req, res, next) => {
  const { ticketId } = req.body;
  const user = req.user;
  const ticket = await TicketSchema.findOne({ _id: ticketId });

  const userContainsTicket = await UserSchema.findOne({
    _id: user._id,
    tickets: { $in: [mongoose.Types.ObjectId(ticketId)] }
  });
  if (userContainsTicket) {
    // console.log(user.tickets)
    // req.ticket = user.tickets;
    next();
  } else {
    res.status(401).json({
      success: false,
      message: "Unauthorized",
    });
  }
};

module.exports = {
    verifyReview,
    verifyTicket,
}
