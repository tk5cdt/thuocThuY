import express from "express";
import homeController from "../controller/homeController";
import sql from '../configs/connectDB';

let router = express.Router();

const initWebRoute = (app) => {
    router.get('/', homeController.getHompage)
    
    router.get('/about', (req, res) => {
        return res.send('This is about page');
    })
    router.get('/db', homeController.getConnect)
    return app.use('/', router);
}

export default initWebRoute;