const response = require("../imports/response");
const jwt = require('jsonwebtoken');
const config = require('../config.json');

module.exports = function (req, res, next){
    const token = req.header('auth-token');
    if (!token) return response.response(res, response.status_fail, response.code_unautiorized, "Access Unathorized", null, null);

    try {
        const verified = jwt.verify(token, config.token_key);
        req.user = verified;
        next()
    } catch (err) {
        return response.response(res, response.status_fail, response.code_unautiorized, "Access Unathorized", null, null);
    }
}