const express = require('express');
const apiRoute = require('./routes/api');
const cors = require('cors')
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const response = require('./imports/response');

// environment
const config = require('./config.json');

global.__basedir = __dirname;

const ip_addr = config.ip_addr;
const port = config.port;
const app = express();

const mutler = require('multer');
const fs = require('fs');
const upload = mutler({ dest: 'public/assets/uploads/'})

// connect to mongodb
const dbUrl = config.db_connect;
mongoose.connect(dbUrl, {useNewUrlParser: true, useUnifiedTopology: true})
  .then((result) => {
    console.log("Connected to database");
    app.listen(port, ip_addr,() => {
        console.log(`Listening at: ${ip_addr}:${port}`)
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

app.post('/upload', upload.single("audioFile"), function (req,res) {
    console.log("Received file " + req.file.originalname);
    var src = fs.createReadStream(req.file.path);
    var dest = fs.createWriteStream('public/assets/uploads/' + req.file.originalname);
    src.pipe(dest);
    src.on('end', function() {
    	fs.unlinkSync(req.file.path);
    	res.json('OK: received ' + req.file.originalname);
    });
    src.on('error', function(err) { res.json('Something went wrong!'); }); 
    console.log(req.body);
 })

app.use((req, res) => {
    response.response(res, response.status_fail, response.code_not_found, "Not found", null, null);
})
