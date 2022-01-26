const Note = require('../models/Note')
const {errorMessage, successMessage} = require('../imports/error_message')
const {noteValidation} = require('../imports/validation')

const noteGet =  (req, res) => {
    var noteId = req.params.id;
    var user = req.user;
    console.log(user)
    res.send(`${noteId}  ${user._id}`)
}

const noteCreate = (req, res) => {
    var data = req.body;
    var userId = req.user._id;

    
    // validation
    console.log(req);
    let error = noteValidation(data);
    if (error) {
        return res.status(400).json(error);
    }

    const note = new Note({
        userId: userId,
        title: data.title,
        body: data.body,
        important: data.important || false
    });

    note.save()
        .then((result) => {
            res.status(200).json(successMessage("Notes saved"));
        })
        .catch((err) => {
            res.status(400).send(err);
        })
}

module.exports = {
    noteGet,
    noteCreate
}