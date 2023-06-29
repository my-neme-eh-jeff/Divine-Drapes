const userC = require("../controllers/userC.js");
const adminC = require("../controllers/adminC.js");
const express = require("express");
const auth = require("../middleware/auth");
const fileVerify = require("../middleware/fileVerify");

const router = express.Router();

// add product
router.post("/addProduct", adminC.addProduct);

//view all orders
router.get("/allOrders", adminC.allOrders);

//update a product
router.patch("/updateProduct", adminC.updateProduct)

//delete a product
router.delete("/deleteProduct", adminC.deleteProduct)

//find a particular user
router.delete("/deleteProduct", adminC.viewUser)

module.exports = router;
