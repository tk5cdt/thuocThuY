import express from "express";
import homeController from "../controller/homeController";
import userController from "../controller/userController";

let router = express.Router();

const initWebRoute = (app) => {
    router.get('/', homeController.getHompage)
    router.get('/db', homeController.getConnect)
    router.get('/thuoc/:MATHUOC', homeController.getTHUOC)
    router.get('/admin/themthuoc', homeController.themthuoc)
    router.post('/createNewThuoc', homeController.newTHUOC)
    router.post('/deleteTHUOC', homeController.deleteTHUOC)
    router.get('/editThuoc/:MATHUOC', homeController.editTHUOC)
    router.post('/updateTHUOC', homeController.updateTHUOC)
    router.post('/addToCart/:MATHUOC', homeController.addToCart)
    router.get('/cart', homeController.getCart)
    router.get('/4T', homeController.get4T)
    router.get('/sp', homeController.getsp)
    //login signup logout
    router.get('/signup', userController.dangky);
    router.post('/signup', userController.signup);
    router.get('/login', userController.dangnhap);
    router.post('/login', userController.login);
    router.get('/logout', userController.logout);
    
    router.get('/admin', homeController.admin)
    return app.use('/', router);
}

export default initWebRoute;