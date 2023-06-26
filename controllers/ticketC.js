const nodemailer = require("nodemailer");
const Sentiment = require("sentiment");

//models
const UserSchema = require("../models/userSchema");
const ProductSchema = require("../models/productSchema");
const OrderSchema = require("../models/orderSchema");
const ReviewSchema = require("../models/reviewSchema");
const TicketSchema = require("../models/ticketSchema");

//add ticket
const addTicket = async (req, res) => {
  try {
    const user = req.user;
    const { productID, message } = req.body;

    const sentiment = new Sentiment();
    const result = sentiment.analyze(message);
    sentiment = result.score;

    const ticketObj = {
      user: user._id,
      fName: user.fName,
      message,
      sentiment,
      verifiedPurchase: userPurchased,
    };

    const addToTicketSchema = new TicketSchema(ticketObj);
    const savedTicket = await addToTicketSchema.save();

    const addTicketInUser = await UserSchema.findOneAndUpdate(
      { _id: user._id },
      { tickets: { $push: savedTicket._id } }
    );

    res.status(200).json({
      success: true,
      message: "Ticket added successfully",
      data: savedTicket,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

// get my tickets
const myTicket = async (req, res) => {
  try {
    const user = req.user;
    const tickets = await UserSchema.find({ _id: user._id })
      .populate("tickets")
      .select("tickets");

    res.status(200).json({
      success: true,
      data: tickets,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

//delete ticket
const deleteTicket = async (req, res) => {
  try {
    const { ticketID } = req.body;
    const deleteTicket = await TicketSchema.findByIdAndDelete({
      _id: ticketID,
    });

    res.status(200).json({
      success: true,
      message: "Ticket deleted successfully",
      data: deleteTicket,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

module.exports = {
  addTicket,
  myTicket,
  deleteTicket,
};
