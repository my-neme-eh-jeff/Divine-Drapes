const express = require("express")

const router = express.Router()

//controllers 
const publicC = require("../controllers/publicC")

// routes

//get all products
router.get("/allProducts", publicC.allProducts)


module.exports = router