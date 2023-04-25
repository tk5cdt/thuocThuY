import express from 'express'
import configViewEngine from './configs/viewEngine'

require('dotenv').config();
let port = process.env.PORT || 8080;

const app = express()

configViewEngine(app)

app.get('/', (req, res) => {
  res.render('index.ejs')
})

app.listen(port, () => {
  //callback
  console.log("Backend Nodejs is running on the port: " + port);
})