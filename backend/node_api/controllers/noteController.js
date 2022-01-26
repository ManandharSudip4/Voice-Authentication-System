const Note = require('../models/Note')
const {errorMessage, successMessage} = require('../imports/error_message')
const {noteValidation, noteUpdateValidation} = require('../imports/validation');

const noteIndex =  (req, res) => {
    var noteId = req.params.id;
    var userId = req.user._id;

    Note.find({userId: userId})
        .then((data) => {
            res.status(200).json(data);
        })
        .catch((err) => {
            res.status(400).json(err)
        });

    // res.send(`${noteId}  ${user._id}`)
}

const noteCreate = (req, res) => {
    var data = req.body;
    var userId = req.user._id;

    
    // validation
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
        .then((data) => {
            res.status(200).json(successMessage("Notes saved"));
        })
        .catch((err) => {
            res.status(400).send(err);
        });
}

const noteDelete = async (req, res) =>{
    var noteId = req.params.id;
    var userId = req.user._id;

    Note.findOneAndDelete({_id:noteId, userId: userId})
        .then((data) => {
            res.status(200).json(successMessage("Note deleted sucessfully"));
        })
        .catch((err) => {
            res.status(400).json(errorMessage("You are an imposter"));
        });
}

const noteGet = async (req, res) => {
    var noteId = req.params.id;
    var userId = req.user._id;

    Note.findOne({_id: noteId, userId: userId})
        .then((data) => {
            res.status(200).json(data);
        })
        .catch((err) => {
            res.status(400).json(errorMessage("userId not correct"));
        });
}

const noteUpdate = async (req, res) => {
    var noteId = req.params.id
    var userId = req.user._id;
    var data = req.body;

    // validation
    let error = noteUpdateValidation(data);
    if (error) {
        return res.status(400).json(error);
    }
    
    Note.findOneAndUpdate({_id: noteId, userId: userId}, data, {upsert: true})
        .then((data) => {
            res.status(400).json(successMessage("Updated"));
        })
        .catch((err) => {
            res.status(400).json(errorMessage("You are an imposter"));
        });
}

module.exports = {
    noteIndex,
    noteGet,
    noteCreate,
    noteDelete,
    noteUpdate
}