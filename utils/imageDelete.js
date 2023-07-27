const cloudinary = require("cloudinary").v2;
cloudinary.config({
  cloud_name: process.env.CLOUDINARY_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET,
});

async function imageDelete(url) {
  try {
    const parts = url.split("/");
    const publicId = parts.pop().split(".")[0];
    const deletionResponse = await cloudinary.uploader.destroy(publicId);

    // The response will indicate success or failure of the deletion
    if (deletionResponse.result === "ok") {
      console.log("File deleted from Cloudinary successfully.");
    } else {
      console.error(
        "Error deleting file from Cloudinary:",
        deletionResponse.result
      );
    }
  } catch (err) {
    console.error("Error deleting file from Cloudinary:", err.message);
    throw new Error("Error deleting file from Cloudinary.");
  }
}

module.exports = imageDelete;
