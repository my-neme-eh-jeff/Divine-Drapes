const mongoose = require("mongoose");
const Schema = mongoose.Schema;
require("dotenv").config();

const ticketSchema = new Schema({
    user: {
        type: mongoose.Types.ObjectId,
        ref: "user"
    },
    fname: {
        type: String,
    },
    message : {
        type: String,
    },
    sentiment: {
        type: Number
    },
    isResolved : {
        type : Boolean,
        default : false
    }
}, {timestamps: true});



const TicketSchema = mongoose.model("ticket", ticketSchema)
module.exports = TicketSchema