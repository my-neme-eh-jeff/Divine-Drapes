const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const productSchema = new Schema(
  {
    name: {
      type: String,
      required: true,
    },
    description: {
      type: String,
    },
    category: {
      type: String,
      required: true,
    },
    quantity: {
      type: Number,
      required: true,
    },
    cost: {
      currency: {
        type: String,
        enum: ["USD", "INR", "EUR", "AUD"],
      },
      value: {
        type: Number,
      },
    },
    photo: {
      isCust: {
        type: Boolean,
        required: true,
      },
      //secure_url of images
      picture: [String],
    },
    text: {
      isCust: {
        type: Boolean,
        required: true,
      },
      text: {
        type: String,
      },
    },
    color: {
      isCust: {
        type: Boolean,
        required: true,
      },
      color: [
        {
          type: String,
        },
      ],
    },
    reviews: [
      {
        type: mongoose.Types.ObjectId,
        ref: "review",
      },
    ],
  },
  { timestamps: true }
);

const ProductSchema = mongoose.model("product", productSchema);
module.exports = ProductSchema;
