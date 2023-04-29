const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const cartSchema = new Schema({
    user: { 
        type: mongoose.Types.ObjectId,
        ref: 'user',
        required: true
    },
    cartItems: [
        {
            product: { 
                type: mongoose.Types.ObjectId, 
                ref: 'product', 
                required: true 
            },
            quantity: { 
                type: Number, 
                default: 1 
            },
        }
    ]
}, { timestamps: true });


const CartSchema = mongoose.model("cart", cartSchema);
module.exports = CartSchema;