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
    photo : {
        isCust : {
            type : Boolean,
            required : true
        },
        picture : [{
            type : String
        }]
    },
    text : {
        isCust : {
            type : Boolean,
            required : true
        },
        text : {
            type : String
        }
    },
    color : {
        isCust : {
            type : Boolean,
            required : true
        },
        color : [{
            type : String
        }]
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
        default : "received"
    }
})


const OrderSchema = mongoose.model("order", orderSchema)
module.exports = OrderSchema