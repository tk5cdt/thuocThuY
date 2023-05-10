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
    router.get('/sanpham', homeController.getsp)
    router.get('/contact', homeController.getcontact)
    router.get('/info', homeController.getinfo)
    router.get('/dangxuat', homeController.getregister)
    router.get('/dangxuat', homeController.getlog)
    router.get('/sp', homeController.getgiohang)
    router.post('/updateTHUOC', homeController.updateTHUOC)
    return app.use('/', router);
}

export default initWebRoute;