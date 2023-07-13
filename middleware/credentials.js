const allowedOrigins = require("../config/allowedOrigins");

const credentials = (req, res, next) => {
  const origin = req.headers.origin;
  console.log(origin);
  if (allowedOrigins.includes(origin)) {
    console.log("yes");
    res.header("Access-Control-Allow-Credentials", true);
    console.log(res.header);
  }
  next();
};

module.exports = credentials;
