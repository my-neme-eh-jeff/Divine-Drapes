const express = require("express")
require("./db.js")
require('dotenv').config()
const cookieParser = require("cookie-parser")

const userRoutes = require("./routes/userRoutes")
const adminRoutes = require("./routes/adminRoutes")

const cors = require("cors")
const bodyParser = require("body-parser")

const app = express()
app.use(cors())
app.use(bodyParser.json());

app.use(express.json())
app.use(cookieParser())

// user 
app.use('/user', userRoutes)

//admin routes
app.use("/admin", adminRoutes)


app.listen(process.env.PORT || 3001, ()=>{
  console.log('The server is up and running at port 3001')
})


