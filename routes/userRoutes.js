const express = require("express")

const router = express.Router()
const multer=require('multer')
const upload=multer({dest:'uploads/'})
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
router.post("/order",userC.directOrder)

// view Order
router.get("/viewOrder",userC.viewOrder)

// router.post("/profilePic",upload.single('profile') ,userC.profilePic)


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
router.get("/myTicket", ticketC.myTicket)

//delete review
router.delete("/deleteTicket", userCheck.verifyTicket , ticketC.deleteTicket)

//get particular ticket
router.get("/particularTicket", ticketC.particularTicket)

module.exports = router;

