const userC = require("../controllers/userC.js");
const adminC = require("../controllers/adminC.js");
const express = require("express");
const auth = require("../middleware/auth");
const fileVerify = require("../middleware/fileVerify");
const multer=require('multer')
const upload=multer({dest:'uploads/'})

const router = express.Router();

// add product
router.post("/addProduct" ,adminC.addProduct);

//images for products
router.post("/addImages", upload.array('files'), adminC.addImagesForProduct )

//view all orders
router.get("/allOrders", adminC.allOrders);

//update a product
router.patch("/updateProduct", adminC.updateProduct)

//delete a product
router.delete("/deleteProduct", adminC.deleteProduct)

//find a particular user
router.delete("/viewUser", adminC.viewUser)

module.exports = router;
