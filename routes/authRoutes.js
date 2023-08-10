const express = require("express");
const fileVerify = require("../middleware/fileVerify");

const router = express.Router();

//controller
const authC = require("../controllers/authC.js");
const passport = require("passport");

// Create user
router.post("/signup", authC.createUser);

//handle login
router.post("/login", authC.handleLogin);

router.post("/applogin", authC.loginUser);

//handle logout
router.post("/logout", authC.handleLogout);

//send otp for forgot password
router.post("/forgotPSWD", authC.forgotPSWD);

//verify OTP
router.post("/verifyOTP", authC.verifyOTP); //then hit edit user api details to reset password

//refresh token
router.get("/refreshToken", authC.handleRefreshToken);

//oath stuff

router.get("/google", passport.authenticate("google", { scope: ["profile"] }));

const successRedirectURL =
  process.env.CLIENT_ENV === "production"
    ? "https://divinedrapesfeweb.netlify.app"
    : "http://localhost:3000";
    
router.get(
  "/google/callback",
  passport.authenticate("google", {
    successRedirect: successRedirectURL,
    failureRedirect: "/login/failed",
  })
);

router.get("/login/failed", authC.loginWithGoogleFailed);

router.get("/login/success", authC.loginWithGoogleSucess);

module.exports = router;
