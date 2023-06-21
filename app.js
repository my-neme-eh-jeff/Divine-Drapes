const morgan = require("morgan");
const express = require("express")
const cookieParser = require("cookie-parser")
const cors = require("cors")
const corsOptions = require("./config/corsOptions.js");
const {logger} = require("./middleware/logEvents")
const mongoose = require('mongoose');

require("./db.js")
require('dotenv').config()
const app = express()

app.use(morgan(":method :url :req[header] :status\n"))
app.use(logger)

app.use(cors(corsOptions))

app.use(express.json())
app.use(cookieParser())

// Routes

const userRoutes = require("./routes/userRoutes")
const adminRoutes = require("./routes/adminRoutes.js")
const authRoutes = require("./routes/authRoutes.js")

// user 
app.use('/user', userRoutes)

//admin routes
app.use('/admin', adminRoutes)

// auth routes
app.use("/auth", authRoutes)

mongoose.connection.once('open', () => {
  app.listen(process.env.PORT, () => console.log(`\nServer running on port ${process.env.PORT}\n\n`));
});



