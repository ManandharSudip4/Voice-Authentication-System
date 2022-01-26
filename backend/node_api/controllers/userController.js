const uploadFile = require('../middleware/upload');
const {loginValidation, registerValidation} = require('../imports/validation')
const { errorMessage, successMessage } = require('../imports/error_message');
const User = require('../models/User');
const jwt = require('jsonwebtoken');
const spwan = require('child_process').spawn;

// environment
const config = require('../config.json');


const userRegister = async (req, res) => {

    try {
        await uploadFile.registerUploadFileMiddleware(req, res);
        // fileName = uploadFile.getFileName();
        if (req.file == undefined) {
            return res.status(400).json(errorMessage("Please upload audio file"));
        }

    } catch (err) {
        res.status(500).send(err);
    }
    let data = req.body;
    let audioFile = req.file.originalname;

    // validation
    let error = registerValidation(data);
    if (error) {
        return res.status(400).json(error);
    }

    // checking if userName already exists
    var userNameExists = await User.findOne({ userName: data.userName });
    if (userNameExists) return res.status(400).json(errorMessage("Email already exists"));

    var fileExists = await User.findOne({ audioFile: audioFile });
    if (fileExists) return res.status(400).json(errorMessage("File already exists"));

    // create new user
    const user = new User({
        userName: data.userName,
        audioFile: audioFile
    });

    user.save()
        .then((result) => {
            // create jwt token
            var token = jwt.sign({ _id: user._id }, config.token_key)
            res.status(200).header('auth-token', token).json(successMessage("Successfully Registered"))
        })
        .catch((err) => {
            res.status(400).send(err);
        })


    // create token 
    // var token = jwt 
}

const userLogin = async (req, res) => {
    try {
        await uploadFile.loginUploadFileMiddleware(req, res);
        audioFile = uploadFile.getFileName();
        if (req.file == undefined) {
            return res.status(400).json(errorMessage("Please upload audio file"));
        }

    } catch (err) {
        res.status(500).send(err);
    }

    var data = req.body;
    // let audioFile = req.file.originalname;

    // validation
    let error = loginValidation(data);
    if (error) {
        return res.status(400).json(error);
    }

    // check user
    var user = await User.findOne({ userName: data.userName });
    if (!user) return res.status(400).json(errorMessage("User not found"));

    // interaction with python module
    const pythonProcess = spwan('python', ['login.py', user.userName, user.audioFile])
    await pythonProcess.stdout.on('data', (data) => {
        pythonData =  data.toString();
        pythonData = JSON.parse(pythonData);
        // console.log(pythonData)
    });

    await pythonProcess.on('close', (code) => {
        console.log(`Child process closs all stdio with code: ${code}`)
        if (!pythonData.isUser) return res.status(400).json(errorMessage("You are an imposter"));
        // create jwt token and assign
        var token = jwt.sign({ _id: user._id }, config.token_key);

        return res.status(200).header('auth-token', token).json(successMessage("login successful"));
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
    test
}
// const upload =  async 



