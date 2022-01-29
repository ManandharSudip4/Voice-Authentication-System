const uploadFile = require('../middleware/upload');
const {loginValidation, registerValidation} = require('../imports/validation')
const User = require('../models/User');
const jwt = require('jsonwebtoken');
const spwan = require('child_process').spawn;
const response = require('../imports/response');

// environment
const config = require('../config.json');


const userRegister = async (req, res) => {

    try {
        await uploadFile.registerUploadFileMiddleware(req, res);
        // fileName = uploadFile.getFileName();
        if (req.file == undefined) {
            // return res.status(400).json(errorMessage("Please upload audio file"));
            return response.response(res, response.status_fail, response.code_failed, "Please upload audio", null, null);
        }

    } catch (err) {
        return response.response(res, response.status_fail, response.code_error, err, null, null);
    }
    let data = req.body;
    let audioFile = req.file.originalname;

    // validation
    let error = registerValidation(data);
    if (error) {
        return response.response(res, response.status_fail, response.code_failed, error, null, null);
    }

    // checking if userName already exists
    var userNameExists = await User.findOne({ userName: data.userName });
    if (userNameExists) return response.response(res, response.status_fail, response.code_failed, {"userName": "userName already exists"}, null, null)   
    
    var fileExists = await User.findOne({ audioFile: audioFile });
    if (fileExists) return response.response(res, response.status_fail, response.code_failed, {"audioFile": "audioFile already exists"}, null, null);

    // create new user
    const user = new User({
        userName: data.userName,
        audioFile: audioFile
    });

    user.save()
        .then((result) => {
            // create jwt token
            var token = jwt.sign({ _id: user._id }, config.token_key);
            return response.responseToken(res, response.status_ok, response.code_ok, null, "success", null, token);
            // res.status(200).header('auth-token', token).json(successMessage("Successfully Registered"))
        })
        .catch((err) => {
            return response.response(res, response.status_fail, response.code_failed, err, null, null);
        })


    // create token 
    // var token = jwt 
}

const userLogin = async (req, res) => {
    try {
        await uploadFile.loginUploadFileMiddleware(req, res);
        audioFile = uploadFile.getFileName();
        if (req.file == undefined) {
            return response.response(res, response.status_fail, response.code_failed, "Please upload audio", null, null);
        }

    } catch (err) {
        return response.response(res, response.status_fail, response.code_error, err, null, null);
    }

    var data = req.body;
    // let audioFile = req.file.originalname;

    // validation
    let error = loginValidation(data);
    if (error) {
        return response.response(res, response.status_fail, response.code_failed, error, null, null);
    }

    // check user
    var user = await User.findOne({ userName: data.userName });
    if (!user) return response.response(res, response.status_fail, response.code_failed, {"userName": "UserName not found"}, null, null);

    // interaction with python module
    const pythonProcess = spwan('python', ['login.py', user.userName, user.audioFile])
    await pythonProcess.stdout.on('data', (data) => {
        pythonData =  data.toString();
        pythonData = JSON.parse(pythonData);
        // console.log(pythonData)
    });

    await pythonProcess.on('close', (code) => {
        console.log(`Child process closs all stdio with code: ${code}`)
        if (!pythonData.isUser) return response.response(res, response.status_fail, response.code_failed, "You are an imposter", null, null);
        // create jwt token and assign
        var token = jwt.sign({ _id: user._id }, config.token_key);

        return response.responseToken(res, response.status_ok, response.code_ok, null, "success", null, token);
    });

}

const getUsers = async (req, res) => {
    var usersProjection = {
        _id: 1,
        userName: 1
    }
    User.find({}, usersProjection)
        .then((data) => {
            return response.response(res, response.status_ok, response.code_ok, null, "success", data);
        })
        .catch((err) => {
            return response.response(res, response.status_fail, response.code_failed, err, null, null);
        });
}


const test = async (req, res) => {

    const pythonProcess = spwan('python', ["test.py", "lethal", "file"]);
    pythonProcess.stdout.on('data', (data) => {
        data = data.toString();
        data = JSON.parse(data);
        console.log(`${data.isUser} ${data.user} ${data.file}`);
    });
    pythonProcess.on('close', (code) => {
        console.log(`child process close all stdio with code: ${code}`);

    });
    res.status(200).send("success");
}

module.exports = {
    userRegister,
    userLogin,
    getUsers,
    test
}
// const upload =  async 



