const mongoose = require("mongoose")
const Schema = mongoose.Schema

const orderSchema = new Schema({
    user : {
        type : mongoose.Types.ObjectId,
        ref : "user"
    },
    product : {
        type : mongoose.Types.ObjectId,
        ref : "product"
    },
    paymentStatus: {
        type: String,
        enum: ["pending", "completed", "cancelled", "refund"],
        required: true,
    },
    paymentType: {
        type: String,
        enum: ["cod", "card", "net banking", "UPI"],
        required: true,
    },
    orderStatus : {
        type : String,
        enum: ["received", "shipping", "shipped", "delivered"],
    }
})


const OrderSchema = mongoose.model("order", orderSchema)
module.exports = OrderSchema