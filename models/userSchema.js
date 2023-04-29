const mongoose = require("mongoose")
const Schema = mongoose.Schema
const validator = require("validator")
const bcrypt = require("bcryptjs")
const jwt = require("jsonwebtoken")
require('dotenv').config()

const userSchema = new Schema({
    role: {
        type: String,
        enum: ["user","admin"],
        default : "user"
    },
    fname: {
        type: String,
        required: true,
        validate(value){
            if(!validator.isAlpha(value)){
                throw new Error("First name is invalid!")
            }
        }
    },
    lname: {
        type: String,
        required: true,
        validate(value){
            if(!validator.isAlpha(value)){
                throw new Error("First name is invalid!")
            }
        }
    },
    DOB: {
        type: String,
        required: true
    },
    profilePic: {
        type: Buffer 
    },
    email: {
        type: String,
        unique: true,
        required: true,
        validate(value){
            if(!validator.isEmail(value)){
                throw new Error("Email is invalid!")
            }
        }
    },
    number: {
        type: Number,
        unique: true,
        required: true,
    },
    password: {
        type: String,
        required: true
    },
    OTP: {
        type: Number,
    },
    isVerified :{
        type: Boolean,
        default : false
    },
    cart : [{
        type : mongoose.Types.ObjectId,
        ref : "product"
    }],
    order : [{
        type : mongoose.Types.ObjectId,
        ref : "order"
    }]
}, {timestamps: true});

//hash the password
userSchema.pre("save", async function(next){
    try{
        const salt = await bcrypt.genSalt(10)
        const hashedPassword = await bcrypt.hash(this.password, salt)
        this.password = hashedPassword
        next()
    }catch(e){
        console.log(e)
    }
})

userSchema.methods.genAuthToken = async function(){
    const user = this

    const accessToken = jwt.sign({ _id: user._id.toString() } , process.env.SECRET_KEY, {
        expiresIn: "1y"
    })

    return accessToken
}

userSchema.methods.genRefToken = async function(){
    const user = this

    const refreshToken = jwt.sign({ _id: user._id.toString() } , process.env.REFRESH_TOKEN_SECRET, {
        expiresIn: "1y"
    })

    return refreshToken
}



const UserSchema = mongoose.model("user", userSchema);
module.exports = UserSchema;