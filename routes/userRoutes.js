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

//upload pfp
router.post("/profilePic",upload.single('file') ,userC.profilePic)



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

// add images for customization
router.post("/orderPicture", upload.array('files'), userC.addImagesForOrder)

// view Order
router.get("/viewOrder",userC.viewOrder)

// view single order
router.get("/singleOrder", userC.viewSingleOrder)


/// CRUD review

//add review
router.post("/createReview", reviewC.addReview)

//read my review
router.get("/myReview", reviewC.myReview)

//update review
router.patch("/updateReview", userCheck.verifyReview, reviewC.updateReview)

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

