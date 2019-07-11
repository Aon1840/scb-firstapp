const express = require("express")
const app = express()
const bodyParser = require('body-parser')
const formidable =require('formidable')
const fs = require('fs-extra')
const path = require('path')

app.use(bodyParser.urlencoded({
    extended: false,
  }))
//   app.use(bodyParser.json())

app.post("/login", (req, res)=>{
    const { username,password} = req.body
    res.json({ result:'ok', username, password})
})

app.get("/", (req, res)=>{
    res.end("I am Home")
})

app.post('/uploads/', function (req, res) {
    console.log("Upload File");

    try {
        var form = new formidable.IncomingForm();
        var newname = Date.now();
        form.parse(req, function (err, fields, files) {

            console.log(JSON.stringify(files));
            var oldpath = files.userfile.path;
            var newpath = path.join(__dirname, "./upload/" + newname.toString() + "." + files.userfile.name.split('.').pop());
            
            fs.rename(oldpath, newpath, function (err) {
                if (err) throw err;

              var username = fields.username;
              var password =fields.password;
              console.log("username: " + username);
              console.log("password: " + password);
              res.end("Upload Successfully");

            });            
        });
    } catch (err) {
        console.log("err : " + err);
    }
});

app.post('/test2', (req,res) => {
	username = req.body.username
	password = req.body.password
	res.json({
		username: username,
		password: password,
    })
    console.log("username: ",username)
})


app.listen(3000, ()=>{
    console.log("Running...")
})