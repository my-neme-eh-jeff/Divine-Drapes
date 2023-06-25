const userC = require("../controllers/userC.js");
const adminC = require("../controllers/adminC.js");
const express = require("express");
const auth = require("../middleware/auth");
const fileVerify = require("../middleware/fileVerify");

const router = express.Router();

router.post("/addProduct", adminC.addProduct);
router.post("/allOrders", adminC.allOrders);
module.exports = router;
