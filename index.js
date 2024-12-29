const express = require("express");

const app = express();

app.get("/", (req, res) => {
  res.send("<h1>Hello guys, Welcome to my latest Web Application!!</h1>");
});

app.get("/info", (req, res) => {
  res.send("hey this is /info api");
});

app.listen(3000, () => {
  console.log("listening");
});