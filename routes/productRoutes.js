const express = require("express")

const router = express.Router()

//controllers 
const productC = require("../controllers/productC")

// routes

//get all products
router.get("/allProducts", productC.allProducts)

//view products category wise
router.get("/categoryWise/:category", productC.categoryWise)

//view specific product
router.get("/viewProduct/:productID", productC.viewSpecificProduct)

module.exports = router