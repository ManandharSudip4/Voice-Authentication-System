const util = require('util');
const multer = require('multer');
const path = require('path');

const config = require('../config.json');
var base_dir = path.join( __dirname, "../");
const registerDest = path.join(base_dir, config.uploadRegisterDir);
const loginDest = path.join(base_dir, config.uploadLoginDir);
var fileName;

function checkFileType(file, cb){
    let allowedTypes = /wav/;
    let extname = allowedTypes.test(path.extname(file.originalname).toLowerCase());
    let mimetype = allowedTypes.test(file.mimetype);

    if (mimetype && extname){
        return cb(null, true);
    } else {
        cb('Error: wav only!');
    }
}

let registerStorage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, registerDest);
    },
    filename: (req, file, cb) => {
        fileName = file.originalname 
        cb(null, file.originalname)
    },
});

let registerUploadFile = multer({
    storage: registerStorage,
    fileFilter: function(req, file, cb){
        checkFileType(file, cb)
    }
}).single("audio");

let registerUploadFileMiddleware = util.promisify(registerUploadFile);

let loginStorage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, loginDest);
    },
    filename: (req, file, cb) => {
        fileName = file.originalname 
        cb(null, file.originalname)
    },
});

let loginUploadFile = multer({
    storage: loginStorage,
    fileFilter: function(req, file, cb){
        checkFileType(file, cb)
    }
}).single("audio");

let loginUploadFileMiddleware = util.promisify(loginUploadFile);

const getFileName = () => {
    return fileName
}
module.exports = {registerUploadFileMiddleware, loginUploadFileMiddleware,getFileName}; 