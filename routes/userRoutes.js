const express = require("express")
const auth = require("../middleware/auth")
const fileVerify = require("../middleware/fileVerify")
const verifyJWT = require("../middleware/verifyJWT.js")

const router = express.Router()

//controllers 
const userC = require("../controllers/userC.js")
const reviewC = require("../controllers/reviewC")
const ticketC = require("../controllers/ticketC")

//middleware
const userCheck = require("../middleware/userCheck")

// Get account details
router.get("/profile", userC.profile)

//edit user details
router.put("/editUserInfo", userC.updateUser)

//get all products
router.get("/allProducts", userC.allProducts)

//view products category wise
router.get("/categoryWise", userC.categoryWise)

//view specific product
router.get("/viewProduct", userC.viewSpecificProduct)

//view my cart
router.get("/viewMyCart", userC.viewCart)

// add to cart
router.post("/addCart/:pID", userC.addCart)

// remove from cart
router.post("/removeCart/:pID",userC.removeCart)

//order
router.post("/order/:pID",userC.directOrder)

//cartOrder
router.post("/cartOrder",userC.cartOrder)

//view Order
router.get("/viewOrder",userC.viewOrder)



/// CRUD review

//add review
router.post("/createReview", userCheck.verifyReview, reviewC.addReview)

//read my review
router.get("/myReview", userCheck.verifyReview, reviewC.myReview)

//update review
router.get("/updateMyReview", userCheck.verifyReview, reviewC.updateReview)

//delete review
router.delete("/deleteReview", userCheck.verifyReview, reviewC.deleteReview)




//CRUD ticket without update

//add review
router.post("/createTicket", userCheck.verifyTicket , ticketC.addTicket)

//read my review
router.get("/myTicket", userCheck.verifyTicket , ticketC.myTicket)

//delete review
router.delete("/deleteTicket", userCheck.verifyTicket , ticketC.deleteTicket)

module.exports = router;

