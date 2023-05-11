import express from "express";
import homeController from "../controller/homeController";
import userController from "../controller/userController";
import multer from "multer";
import path from "path";
import appRoot from "app-root-path";

let router = express.Router();

const storage = multer.diskStorage({
    destination: function(req, file, cb) {
        console.log(appRoot + '/src/public/uploads/')
        cb(null, appRoot + '/src/public/uploads/');
    },

    // By default, multer removes file extensions so let's add them back
    filename: function(req, file, cb) {
        cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
    }
});

const imageFilter = function(req, file, cb) {
    // Accept images only
    if (!file.originalname.match(/\.(jpg|JPG|jpeg|JPEG|png|PNG|gif|GIF)$/)) {
        req.fileValidationError = 'Only image files are allowed!';
        return cb(new Error('Only image files are allowed!'), false);
    }
    cb(null, true);
};

const upload = multer({ storage: storage, fileFilter: imageFilter })

const initWebRoute = (app) => {
    router.get('/', homeController.getHompage)
    router.get('/db', homeController.getConnect)
    router.get('/thuoc/:MATHUOC', homeController.getTHUOC)
    router.post('/deleteTHUOC', homeController.deleteTHUOC)
    router.get('/editThuoc/:MATHUOC', homeController.editTHUOC)
    router.post('/updateTHUOC', homeController.updateTHUOC)
    router.post('/addToCart/:MATHUOC', homeController.addToCart)
    router.get('/cart', homeController.getCart)
    router.post('/deleteCart/:USERNAME/:MATHUOC', homeController.deleteCart)
    router.get('/sp', homeController.getsp)
    router.get('/contact', homeController.getcontact)
    router.get('/info', homeController.getinfo)
    //login signup logout
    router.get('/signup', userController.dangky);
    router.post('/signup', userController.signup);
    router.get('/login', userController.dangnhap);
    router.post('/login', userController.login);    // nhập thông tin đăng nhập
    router.get('/logout', userController.logout);
    //admin
    router.get('/admin', homeController.admin)
    router.get('/admin/themthuoc', homeController.themthuoc)
    router.post('/createNewThuoc', homeController.newTHUOC)
    router.get('/admin/upload', homeController.getUploadPage)
    router.post('/admin/upload', upload.single('profile_pic'), homeController.handleUpload)
    return app.use('/', router);
}

export default initWebRoute;