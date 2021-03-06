const Note = require('../models/Note');
const {noteValidation, noteUpdateValidation} = require('../imports/validation');
const response =  require('../imports/response');

const noteIndex = async (req, res) => {
    console.log("Getting all notes");
    var userId = req.user._id;

    Note.find({userId: userId})
        .then((data) => {
            return response.response(res, response.status_ok, response.code_ok, null, "success", data);
        })
        .catch((err) => {
            return response.response(res, response.status_fail, response.code_failed, err, null, null);
        });

    // res.send(`${noteId}  ${user._id}`)
}

const noteCreate = async (req, res) => {
    console.log("Creating notes");
    var data = req.body;
    var userId = req.user._id;
    console.log(data);
    // validation
    let error = noteValidation(data);
    if (error) {
        return response.response(res, response.status_fail, response.code_failed, error, null, null);
    }

    const note = new Note({
        userId: userId,
        title: data.title,
        body: data.body,
        important: data.important || false
    });

    note.save()
        .then((data) => {
            return response.response(res, response.status_ok, response.code_ok, null, "success", null);
        })
        .catch((err) => {
            return response.response(res, response.status_fail, response.code_failed, err, null, null);
        });
}

const noteDelete = async (req, res) =>{
    console.log("Deleting notes");
    var noteId = req.params.id;
    var userId = req.user._id;

    Note.findOneAndDelete({_id:noteId, userId: userId})
        .then((data) => {
            return response.response(res, response.status_ok, response.code_ok, null, "success", null);
        })
        .catch((err) => {
            return response.response(res, response.status_fail, response.code_failed, "You are an imposter", null, null);
        });
}

const noteGet = async (req, res) => {
    console.log('Getting notes');
    var noteId = req.params.id;
    var userId = req.user._id;

    Note.findOne({_id: noteId, userId: userId})
        .then((data) => {
            return response.response(res, response.status_ok, response.code_ok, null, "success", data);
        })
        .catch((err) => {
            return response.response(res, response.status_fail, response.code_failed, "noteId is not correct", null, null);
        });
}

const noteUpdate = async (req, res) => {
    console.log('Getting update');
    var noteId = req.params.id
    var userId = req.user._id;
    var data = req.body;

    // validation
    let error = noteUpdateValidation(data);
    if (error) {
        return response.response(res, response.status_fail, response.code_failed, error, null, null);
    }
    
    Note.findOneAndUpdate({_id: noteId, userId: userId}, data, {upsert: true})
        .then((data) => {
            return response.response(res, response.status_ok, response.code_ok, null, "success", null);
        })
        .catch((err) => {
            return response.response(res, response.status_fail, response.code_failed, "You are an imposter", null);
        });
}

module.exports = {
    noteIndex,
    noteGet,
    noteCreate,
    noteDelete,
    noteUpdate
}
