const userC = require("../controllers/userC.js")
const express = require("express")
const auth = require("../middleware/auth")
const fileVerify = require("../middleware/fileVerify")

const router = express.Router()

// Create user
router.post("/signup", userC.createUser)

// Login user
router.post("/login", userC.loginUser)

// Get account details
router.get("/profile", auth.authToken, userC.profile)

//send otp for forgot password
router.post("/forgotPSWD", userC.forgotPSWD);

//verify OTP
router.post("/verifyOTP", auth.authToken, userC.verifyOTP) //then hit edit user api details to reset password

//edit user details
router.put("/editUserInfo", auth.authToken, userC.updateUser)

//get all products
router.get("/allProducts", auth.authToken, userC.allProducts)

//view products category wise
router.get("/categoryWise", auth.authToken, userC.categoryWise)

module.exports = router;

