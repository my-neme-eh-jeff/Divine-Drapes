const mongoose = require("mongoose");
const Schema = mongoose.Schema;
const validator = require("validator");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
require("dotenv").config();

const userSchema = new Schema(
  {
    roles: {
      User: {
        type: Number,
        default: 2001,
      },
      Editor: Number,
      Admin: Number,
    },
    fName: {
      type: String,
      required: true,
      validate(value) {
        if (!validator.isAlpha(value)) {
          throw new Error("First name is invalid!");
        }
      },
    },
    lName: {
      type: String,
      required: true,
      validate(value) {
        if (!validator.isAlpha(value)) {
          throw new Error("First name is invalid!");
        }
      },
    },
    DOB: {
      type: String,
      required: true,
    },
    profilePicPublicId: {
      type: String,
    },
    email: {
      type: String,
      unique: true,
      required: true,
      validate(value) {
        if (!validator.isEmail(value)) {
          throw new Error("Email is invalid!");
        }
      },
    },
    number: {
      type: Number,
      unique: true,
      required: true,
    },
    password: {
      type: String,
      required: true,
    },
    addressList: [
      {
        addressOf: {
          //home, office, relatives, etc
          type: String,
        },
        houseNumber: {
          type: String,
        },
        building : {
          type : String,
        },
        street:{
          type : String,
        },
        city : {
          type : String
        },
        state : {
          type : String
        },
        country : {
          type : String
        },
      },
    ],
    OTP: {
      type: Number,
    },
    isVerified: {
      type: Boolean,
      default: false,
    },
    cart: [
      {
        type: mongoose.Types.ObjectId,
        ref: "product",
      },
    ],
    order: [
      {
        type: mongoose.Types.ObjectId,
        ref: "order",
      },
    ],
    reviews : [
      {
        type: mongoose.Types.ObjectId,
        ref: "review",
      }
    ],
    tickets : [
      {
        type: mongoose.Types.ObjectId,
        ref: "ticket",
      }
    ],
    refreshToken: [String],
  },
  { timestamps: true }
);

//hash the password
// userSchema.pre("save", async function (next) {
//   try {
//     console.log(this.password)
//     const salt = await bcrypt.genSalt(10);
//     const hashedPassword = await bcrypt.hash(this.password, salt);
//     this.password = hashedPassword;
//     next();
//   } catch (e) {
//     console.log(e);
//   }
// });

const UserSchema = mongoose.model("user", userSchema);
module.exports = UserSchema;
