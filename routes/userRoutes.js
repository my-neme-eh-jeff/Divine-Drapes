const userC = require("../controllers/userC.js")
const express = require("express")
const auth = require("../middleware/auth")
const fileVerify = require("../middleware/fileVerify")

const router = express.Router()


// Get account details
router.get("/profile", auth.authToken, userC.profile)

//edit user details
router.put("/editUserInfo", auth.authToken, userC.updateUser)

//get all products
router.get("/allProducts", auth.authToken, userC.allProducts)

//view products category wise
router.get("/categoryWise", auth.authToken, userC.categoryWise)

//view my cart
router.get("/viewMyCart", auth.authToken, userC.viewCart)

// add to cart
router.post("/addCart/:pID", auth.authToken, userC.addCart)

// remove from cart
router.post("/removeCart/:pID",auth.authToken,userC.removeCart)

//order
router.post("/order/:pID",auth.authToken,userC.directOrder)

//cartOrder
router.post("/cartOrder",auth.authToken,userC.cartOrder)

//view Order
router.get("/viewOrder",auth.authToken,userC.viewOrder)

module.exports = router;

