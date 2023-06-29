const express = require("express")

const router = express.Router()

//controllers 
const userC = require("../controllers/userC.js")
const reviewC = require("../controllers/reviewC")
const ticketC = require("../controllers/ticketC")

//middleware
const userCheck = require("../middleware/userCheck")



//user

// Get account details
router.get("/profile", userC.profile)

//edit user details
router.put("/editUserInfo", userC.updateUser)

//delete user
router.delete("/deleteUser", userC.deleteUser)



// cart

//view my cart
router.get("/viewMyCart", userC.viewCart)

// add to cart
router.post("/addCart/:pID", userC.addCart)

// delete from cart
router.delete("/removeCart/:pID",userC.removeCart)



//order

// place order
router.post("/order/:pID",userC.directOrder)

// view Order
router.get("/viewOrder",userC.viewOrder)



/// CRUD review

//add review
router.post("/createReview", reviewC.addReview)

//read my review
router.get("/myReview", userCheck.verifyReview, reviewC.myReview)

//update review
router.get("/updateMyReview", userCheck.verifyReview, reviewC.updateReview)

//delete review
router.delete("/deleteReview", userCheck.verifyReview, reviewC.deleteReview)




//CRUD ticket without update

//add review
router.post("/createTicket" , ticketC.addTicket)

//read my review
router.get("/myTicket", userCheck.verifyTicket , ticketC.myTicket)

//delete review
router.delete("/deleteTicket", userCheck.verifyTicket , ticketC.deleteTicket)

module.exports = router;

