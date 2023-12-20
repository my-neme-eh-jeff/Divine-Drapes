const express = require("express");

const router = express.Router();

//controllers
const public = require("../controllers/publicC");

// routes

//get all products
router.get("/allProducts", public.allProducts);

//to keep the server from sleeping
router.get("/", public.preventColdStart);

module.exports = router;
