const authC = require("../controllers/authC.js")
const express = require("express")
const auth = require("../middleware/auth")
const fileVerify = require("../middleware/fileVerify")

const router = express.Router()

//controller

const authC = require("../controllers/authC.js")

// Create user
router.post("/signup", authC.createUser)

//handle login
router.post("/logout", authC.loginUser)

//handle logout
router.post("/logout", authC.handleLogout)

//send otp for forgot password
router.post("/forgotPSWD", authC.forgotPSWD);

//verify OTP
router.post("/verifyOTP", authC.verifyOTP) //then hit edit user api details to reset password

//refresh token
router.post("/refreshToken", authC.handleRefreshToken)

module.exports = router