import express from "express";
import homeController, { getHompage } from "../controller/homeController";

let router = express.Router();

const initWebRoute = (app) => {
    router.get('/', homeController.getHompage)
    
    router.get('/about', (req, res) => {
        return res.send('This is about page');
    })
    return app.use('/', router);
}

export default initWebRoute;