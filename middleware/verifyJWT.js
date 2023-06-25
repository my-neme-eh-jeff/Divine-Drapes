const jwt = require('jsonwebtoken');
const UserSchema = require("../models/userSchema");

const verifyJWT = (req, res, next) => {
    const authHeader = req.headers.authorization || req.headers.Authorization;
    if (!authHeader?.startsWith('Bearer ')) return res.sendStatus(401);
    const token = authHeader.split(' ')[1];
    console.log(token)
    jwt.verify(
        token,
        process.env.ACCESS_TOKEN_SECRET,
        async (err, decoded) => {
            if (err) return res.sendStatus(403); //invalid token
            const user = await UserSchema.findOne({email:decoded.UserInfo.email})
            req.user = user
            req.roles = decoded.UserInfo.roles;
            next();
        }
    );
}

module.exports = verifyJWT