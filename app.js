const morgan = require("morgan");
const express = require("express")
const cookieParser = require("cookie-parser")
const cors = require("cors")
const corsOptions = require("./config/corsOptions.js");
const {logger} = require("./middleware/logEvents")
const mongoose = require('mongoose');
require('dotenv').config()
const credentials = require("./middleware/credentials.js")

require("./db.js")
const app = express()

app.use(morgan(":method :url :req[header] :status\n"))
app.use(logger)

app.use(credentials)
app.use(cors(corsOptions))

app.use(express.json())
app.use(cookieParser())

// Routes
const userRoutes = require("./routes/userRoutes")
const adminRoutes = require("./routes/adminRoutes.js")
const authRoutes = require("./routes/authRoutes.js");
// auth routes
app.use("/auth", authRoutes)

// user 
//app.use(verifyJWT)
app.use('/user', userRoutes)

//admin routes
//app.use(verifyRoles)
app.use('/admin', adminRoutes)


mongoose.connection.once('open', () => {
  app.listen(process.env.PORT, () => console.log(`\nServer running on port ${process.env.PORT}\n\n`));
});



