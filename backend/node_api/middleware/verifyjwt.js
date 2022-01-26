const { errorMessage } = require("../imports/error_message");
const jwt = require('jsonwebtoken');
const config = require('../config.json');

module.exports = function (req, res, next){
    const token = req.header('auth-token');
    if (!token) return res.status(401).json(errorMessage('Access Denied'));

    try {
        const verified = jwt.verify(token, config.token_key);
        req.user = verified;
        next()
    } catch (err) {
        return res.status(400).send(errorMessage("Invalid token"));
    }
}