const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    userName: {
        type: String,
        required: true,
        min: 5,
        max: 255,
        unique: true
    },
    audioFile: {
        type: String,
        required: true,
        max: 255,
        unique: true
    }
}, {timestamps: true});

const User = mongoose.model('User', userSchema);

module.exports = User;