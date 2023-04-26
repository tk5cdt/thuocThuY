import express from "express";

let router = express.Router();

const initWebRoute = (app) => {
    router.get('/', (req, res) => {
        return res.render('index.ejs');
    })
    
    router.get('/about', (req, res) => {
        return res.send('This is about page');
    })
    return app.use('/', router);
}

export default initWebRoute;