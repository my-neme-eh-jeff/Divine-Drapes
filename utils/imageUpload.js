const multer = require("multer");
var upload = multer({ dest: "uploads/" });
const cloudinary = require("cloudinary").v2;
cloudinary.config({
  cloud_name: process.env.CLOUDINARY_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET,
});

const imageUpload = async (file) => {
  try {
    const img = await cloudinary.uploader.upload(file.path);
    return img;
  } catch (err) {
    console.log(err);
  }
};

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "./upload");
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname);
  },
});
var upload = multer({ storage: storage });

module.exports = {
  imageUpload,
};
