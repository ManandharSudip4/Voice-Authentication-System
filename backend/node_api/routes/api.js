const router = require("express").Router();
const userController = require('../controllers/userController');
const noteController = require('../controllers/noteController')
const verify = require('../middleware/verifyjwt');
const config = require('../config.json');
const mutler = require('multer');
const fs = require('fs');
const uploadRegister = mutler({ dest: config.uploadRegisterDir});
const uploadLogin = mutler({ dest: config.uploadLoginDir});

router.get('/', verify, userController.getUserInfoFromToken);
router.post('/registerUser', uploadRegister.single("audioFile"), userController.userRegisternew);
router.post('/loginUser', uploadLogin.single("audioFile"), userController.userLoginnew);
// router.post('/register', userController.userRegister);
// router.post('/login', userController.userLogin);
router.get('/users', userController.getUsers);
// router.get('/test', userController.test);

router.post('/notes/create', verify, noteController.noteCreate);
router.get('/notes', verify, noteController.noteIndex);
router.put('/notes/:id', verify, noteController.noteUpdate);
router.get('/notes/:id', verify, noteController.noteGet);
router.delete('/notes/:id', verify, noteController.noteDelete)
module.exports = router;
