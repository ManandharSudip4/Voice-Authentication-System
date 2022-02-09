const mongoose = require('mongoose');

const noteSchema = new mongoose.Schema({
    userId: {
        type: String,
        required: true,
    },
    title: {
        type: String,
        required: true,
        min: 1,
        max: 255,
    },
    body: {
        type: String,
        required: true,
        max: 1000,
    },
    important: {
        type: Boolean,
        default: false
    }
}, {timestamps: true});

const Note = mongoose.model('Note', noteSchema);

module.exports = Note;