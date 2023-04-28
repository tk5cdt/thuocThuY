import express from 'express'
import configViewEngine from './configs/viewEngine'
import initWebRoutes from './route/web'
import './configs/connectDB'

require('dotenv').config();
let port = process.env.PORT || 8080;

const app = express()

//config view engine
configViewEngine(app)

//init web routes
initWebRoutes(app)

app.listen(port, () => {
  //callback
  console.log("Backend Nodejs is running on the port: " + port);
})