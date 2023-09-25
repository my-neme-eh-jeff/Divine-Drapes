const morgan = require("morgan");
const express = require("express");
const cookieParser = require("cookie-parser");
const cors = require("cors");
const corsOptions = require("./config/corsOptions.js");
const { logger } = require("./middleware/logEvents");
const mongoose = require("mongoose");
require("dotenv").config();
const credentials = require("./middleware/credentials.js");
const errorHandler = require("./middleware/errorHandler.js");
const ROLES_LIST = require("./config/rolesList.js");
const verifyJWT = require("./middleware/verifyJWT.js");
const verifyRoles = require("./middleware/verifyRoles.js");
const session = require("express-session");
const cron = require("node-cron");

require("./db.js");
const app = express();

if (process.env.NODE_ENV === "development") {
  app.use(morgan(":method :url :req[header] :status\n"));
} else if (process.env.NODE_ENV === "production") {
  app.use(logger);
}

app.use(credentials);
app.use(cors(corsOptions));

app.use(express.json());
app.use(cookieParser());

//Cron to keep server alive
cron.schedule("*/10 * * * *", () => {
  console.log("Cron job running every 10 minutes");
});

// Routes
const userRoutes = require("./routes/userRoutes");
const adminRoutes = require("./routes/adminRoutes.js");
const authRoutes = require("./routes/authRoutes.js");
const productRoutes = require("./routes/productRoutes.js");
const publicRoutes = require("./routes/publicRoutes.js");
const passport = require("passport");
require("./utils/passport.js");

//public routes
app.use("/public", publicRoutes);

// auth routes
app.use(
  session({
    secret: "keyboard cat",
    resave: false,
    saveUninitialized: false,
    // store: MongoStore.create({ mongoUrl: process.env.MONGO_URI }),
  })
);

//TODO: uncomment this when passport is working
// app.use(passport.initialize());
// app.use(passport.session());
app.use("/auth", authRoutes);

// user
app.use(verifyJWT);
app.use("/user", userRoutes);

// product routes
app.use("/product", productRoutes);

//admin routes
app.use(verifyRoles(ROLES_LIST.Admin));
app.use("/admin", adminRoutes);

app.all("*", (req, res) => {
  res.status(404);
  if (req.accepts("html")) {
    res.sendFile(path.join(__dirname, "views", "404.html"));
  } else if (req.accepts("json")) {
    res.json({ error: "404 Not Found" });
  } else {
    res.type("txt").send("404 Not Found");
  }
});

app.use(errorHandler);

mongoose.connection.once("open", () => {
  app.listen(process.env.PORT, () =>
    console.log(`\nServer running on port ${process.env.PORT}\n\n`)
  );
});
