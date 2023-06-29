// Models
const ProductSchema = require("../models/productSchema");

//view all products
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

//view a particular product
const viewSpecificProduct = async (req, res) => {
  try {
    const { productID } = req.body;
    const product = await ProductSchema.findById({ _id: productID }).populate(
      "reviews"
    );

    res.status(200).json({
      success: true,
      data: product,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

//view products category wise
const categoryWise = async (req, res) => {
  try {
    const category = req.params.category;

    const list = await ProductSchema.find({ category: category }).populate(
      "reviews"
    );

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


module.exports = {
    allProducts,
    viewSpecificProduct,
    categoryWise
}