import express from "express";
import apiController from "../controller/apiController";

let router = express.Router();

const initApiRoute = (app) => {
    router.get('/getTHUOC', apiController.getTHUOC)
    router.post('/createNewTHUOC', apiController.newTHUOC)
    // router.post('/deleteTHUOC', apiController.deleteTHUOC)
    // router.post('/editTHUOC', apiController.editTHUOC)
    // router.post('/updateTHUOC', apiController.updateTHUOC)
    return app.use('/api/v1/', router);//http://localhost:3000/api/v1/getTHUOC
}

export default initApiRoute;