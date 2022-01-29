const router = require("express").Router();
const userController = require('../controllers/userController');
const noteController = require('../controllers/noteController')
const verify = require('../middleware/verifyjwt');

router.get('/', (req, res) =>{
    // console.log(req.body);
    res.send('somethning');
});
router.post('/register', userController.userRegister);
router.post('/login', userController.userLogin);
router.get('/users', userController.getUsers);
router.get('/test', userController.test);

router.post('/notes/create', verify, noteController.noteCreate);
router.get('/notes', verify, noteController.noteIndex);
router.put('/notes/:id', verify, noteController.noteUpdate);
router.get('/notes/:id', verify, noteController.noteGet);
router.delete('/notes/:id', verify, noteController.noteDelete)
module.exports = router;
