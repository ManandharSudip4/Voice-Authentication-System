const express = require('express');
const apiRoute = require('./routes/api');
const cors = require('cors')
const bodyParser = require('body-parser');
const mongoose = require('mongoose');

// environment
const config = require('./config.json')

global.__basedir = __dirname;

const port = 8000;
const app = express();

// connect to mongodb
const { MongoClient } = require('mongodb');
const dbUrl = config.db_connect;
mongoose.connect(dbUrl, {useNewUrlParser: true, useUnifiedTopology: true})
  .then((result) => {
    console.log("Connected to database");
    app.listen(port, () => {
        console.log(`Listening at port: ${port}`)
    })
  })
  .catch((err) => console.log(err));

var corsOptions = {
  origin: "http://localhost:8000"
};
app.use(cors(corsOptions));
// app.use(express.json());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use("/user", apiRoute);

app.use((req, res) => {
    res.status(404).send("Not found")
})