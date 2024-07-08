const http = require('http');
const express = require('express');
const app = express();
const session = require('express-session');
const mysql = require('mysql');
const bcrypt = require("bcrypt");
const fs = require('fs');
const bodyParser = require('body-parser');


app.use(bodyParser.urlencoded({extended: true}));

//A public mappaban vannak a frontend fileok (css, frontend javascript, images, audio...)
app.use(express.static('public'));
//A HTML kodokat a views mappaban ejs fajlokba irhatjuk (html fileok helyett).
app.set('view engine', 'ejs');


app.use(session({
  secret : 'titkoskeksz',
  resave : false,
  saveUninitialized : true
}));

app.use(function(request, response, next) {
  //Bejelentkezes utan igy tarolhatjuk el a user adata(i)t a sessionben.
  response.locals.user = request.session.user;
  next();
});

//Kulso backend javascript fajlok importalasa.
//A routes-ban feldolgozhatjuk a get kereseket.
require('./routes/routes')(app);

const hostname = '127.0.0.1';
const port = 3000;
 
const server = http.createServer(app);
 
server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
