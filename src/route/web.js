import express from "express";
import homeController from "../controller/homeController";
import userController from "../controller/userController";
import multer from "multer";
import path from "path";
import appRoot from "app-root-path";
import fs from "fs";

let router = express.Router();

const storage = multer.diskStorage({
    destination: function(req, file, cb) {
        //create folder name = MATHUOC
        fs.mkdirSync(appRoot + '/src/public/uploads/' + req.body.MATHUOC, { recursive: true })
        cb(null, appRoot + '/src/public/uploads/' + req.body.MATHUOC);
    },

    // By default, multer removes file extensions so add them back
    filename: function(req, file, cb) {
        cb(null, file.fieldname + '-' + req.body.MATHUOC + '-' + Date.now() + path.extname(file.originalname));
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
    router.get('/thuoc/:MATHUOC', homeController.getTHUOC)
    router.post('/deleteTHUOC', homeController.deleteTHUOC)
    router.get('/editThuoc/:MATHUOC', homeController.editTHUOC)
    router.post('/updateTHUOC', homeController.updateTHUOC)
    router.post('/addToCart/:MATHUOC', homeController.addToCart)
    router.get('/cart', homeController.getCart)
    router.post('/delCart', homeController.deleteCart)
    router.get('/sp', homeController.getConnect)
    router.get('/sp/:LOAISD', homeController.getLOAISD)
    router.get('/contact', homeController.getcontact)
    router.get('/info', homeController.getinfo)
    router.post('/search', homeController.getSearch)
    router.post('/thanhtoan', homeController.thanhToan)
    //login signup logout
    router.get('/signup', userController.dangky);
    router.post('/signup', userController.signup);
    router.get('/login', userController.dangnhap);
    router.post('/login', userController.login);    // nhập thông tin đăng nhập
    router.get('/logout', userController.logout);
    //admin
    router.get('/admin', homeController.admin)
    router.get('/admin/db', homeController.getConnect)
    router.get('/admin/themthuoc', homeController.themthuoc)
    router.post('/createNewThuoc',upload.fields([{
        name: 'profile_pic', maxCount: 1
    }, {
        name: 'pic', maxCount: 5
    }]) ,homeController.newTHUOC)
    router.get('/admin/upload', homeController.getUploadPage)
    // router.post('/admin/uploadProfilePic', upload.single('profile_pic'), homeController.handleUploadProfilePic)
    // router.post('/admin/uploadMultiple', upload.array('pic', 3), homeController.handleUploadMultiPic)
    router.post('/admin/updateDONHANG', homeController.updateDONHANG)

    return app.use('/', router);
}

export default initWebRoute;