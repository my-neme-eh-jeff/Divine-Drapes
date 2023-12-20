const ProductSchema = require("../models/productSchema");

const allProducts = async (req, res) => {
  try {
    const list = await ProductSchema.find().populate("reviews");
    res.status(200).json({
      success: true,
      data: list,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

const preventColdStart = (req, res) => {
  res.status(200).json({
    success: true,
    message: "Server is awake",
  });
};

module.exports = {
  allProducts,
  preventColdStart,
};
