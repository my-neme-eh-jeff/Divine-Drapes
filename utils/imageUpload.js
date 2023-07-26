const multer=require('multer')
var upload=multer({dest:'uploads/'})
const cloudinary=require('cloudinary').v2
cloudinary.config({
    cloud_name:process.env.CLOUDINARY_NAME,
    api_key:process.env.CLOUDINARY_API_KEY,
    api_secret:process.env.CLOUDINARY_API_SECRET
})

const imageUpload = async(req)=>{
        const img = await cloudinary.uploader.upload(req.file.path)
        return img
}

const storage=multer.diskStorage({
    destination:function(req,file,cb){
        cb(null,'./upload')
    },
    filename:function(req,file,cb){
        cb(null,file.originalname)
    }
  })
  var upload=multer({storage:storage})

module.exports={
    imageUpload
}