import { connectDB } from '../configs/connectDB';
import multer from 'multer';
import fs from 'fs';
import appRoot from 'app-root-path';

let upload = multer().single('profile_pic');
let uploadMulti = multer().array('pic');

let getHompage = async (req, res) => {
    const user = req.session.user;
    if (user && user.QUANTRI) {
        return res.redirect("/admin");
    }
    const pool = await connectDB();
    const result = await pool.request().query(`select THUOC.*, TENANH from THUOC, PROFILEPICTURE where THUOC.MATHUOC = PROFILEPICTURE.MATHUOC order by MATHUOC offset 0 rows fetch next 10 rows only`);
    return res.render("index.ejs", { user: req.session.user, appRoot: appRoot.path, THUOC: result.recordset });
}

let getConnect = async (req, res) => {
    const pool = await connectDB();
    const pageNumber = parseInt(req.query.pageNumber) || 1;
    const pageSize = parseInt(req.query.pageSize) || 10;
    try {
        const result = await pool.request().query(`select THUOC.*, TENANH, SOLUONG from THUOC, PROFILEPICTURE, TonKho where THUOC.MATHUOC = PROFILEPICTURE.MATHUOC and THUOC.TENTHUOC = TonKho.TENTHUOC order by MATHUOC offset ${(pageNumber - 1) * pageSize} rows fetch next ${pageSize} rows only`);
        const totalRows = await pool.request().query(`select count(*) as total from THUOC`);
        const totalPages = Math.ceil(totalRows.recordset[0].total / pageSize);
        const user = req.session.user;
        if (user && user.QUANTRI == 1) {
            return res.render("db.ejs", { THUOC: result.recordset, user: req.session.user, totalPages, pageNumber, pageSize, message: "" });
        }
        return res.render("sp.ejs", { THUOC: result.recordset, user: req.session.user, totalPages, pageNumber, pageSize, message: "" });
    }
    catch (err) {
        console.log(err);
    }
}

let getTHUOC = async (req, res) => {
    let MATHUOC = req.params.MATHUOC;
    const pool = await connectDB();
    try {
        const result = await pool.request().query(`select THUOC.*, PROFILEPICTURE.TENANH from THUOC, PROFILEPICTURE where THUOC.MATHUOC = '${MATHUOC}' and THUOC.MATHUOC = PROFILEPICTURE.MATHUOC`)
        const result2 = await pool.request().query(`select * from ALBUMPICTURES where MATHUOC = '${MATHUOC}'`);
        return res.render("thuoc.ejs", { THUOC: result.recordset[0], user: req.session.user, appRoot: appRoot.path, ALBUMPICTURES: result2.recordset });
    }
    catch (err) {
        console.log(err);
    }
}

let themthuoc = (req, res) => {
    const user = req.session.user;
    if (!user || user.QUANTRI == 0) {
        return res.redirect('/');
    }
    return res.render("themthuoc.ejs", { message: "", user: req.session.user });
}

let newTHUOC = async (req, res) => {
    let { MATHUOC, TENTHUOC, MANHOM, LOAISD, THANHPHAN, MANCC, GIASI, GIALE, GIANHAP, DANGBAOCHE, QCDONGGOI, CONGDUNG } = req.body;
    const pool = await connectDB();
    const result = await pool.request().query(`insert into THUOC(MATHUOC, TENTHUOC, MANHOM, LOAISD, THANHPHAN, MANCC, GIASI, GIALE, GIANHAP, DANGBAOCHE, QCDONGGOI, CONGDUNG) values ('${MATHUOC}', N'${TENTHUOC}', '${MANHOM}', N'${LOAISD}', '${THANHPHAN}', '${MANCC}', '${GIASI}', '${GIALE}', '${GIANHAP}', N'${DANGBAOCHE}', N'${QCDONGGOI}', N'${CONGDUNG}')`)
    upload(req, res, function (err) {
        // req.file contains information of uploaded file
        // req.body contains information of text fields, if there were any

        if (req.fileValidationError) {
            return res.send(req.fileValidationError);
        }
        else if (!req.files) {
            return res.render('upload.ejs', { user: req.session.user, message: 'Please select an image to upload' });
        }
        else if (err instanceof multer.MulterError) {
            console.log(err);
            return res.send(err);
        }
        else if (err) {
            console.log(err);
            return res.send(err);
        }
    });

    // console.log(req.files.profile_pic);
    // console.log(req.files.pic);
    let result1 = await pool.request().query(`INSERT INTO PROFILEPICTURE VALUES ('${MATHUOC}', '${req.files.profile_pic[0].filename}')`)
    let files = req.files.pic;
    for (let i = 0; i < files.length; i++) {
        let result2 = await pool.request().query(`INSERT INTO ALBUMPICTURES VALUES ('${MATHUOC}', '${files[i].filename}')`)
    }
    return res.redirect('/thuoc/' + MATHUOC);
}

let deleteTHUOC = async (req, res) => {
    let MATHUOC = req.body.MATHUOC;
    const pool = await connectDB();
    let path = `./public/uploads/${MATHUOC}`;
    fs.rmdirSync(path, { recursive: true });
    const result = await pool.request().query(`delete from THUOC where MATHUOC = '${MATHUOC}'`)
    return res.redirect('/db')
}

let editTHUOC = async (req, res) => {
    const user = req.session.user;
    if (!user || !user.QUANTRI) {
        return res.redirect('/');
    }
    let MATHUOC = req.params.MATHUOC;
    const pool = await connectDB();
    const result = await pool.request().query(`select * from THUOC where MATHUOC = '${MATHUOC}'`)
    return res.render("update.ejs", { THUOC: result.recordset[0], user: req.session.user });
}

let updateTHUOC = async (req, res) => {
    const user = req.session.user;
    if (!user || !user.QUANTRI) {
        return res.redirect('/');
    }
    let { MATHUOC, TENTHUOC, MANHOM, LOAISD, THANHPHAN, MANCC, GIASI, GIALE, GIANHAP, DANGBAOCHE, QCDONGGOI, CONGDUNG } = req.body;
    const pool = await connectDB();
    const result = await pool.request().query(`update THUOC set TENTHUOC = '${TENTHUOC}', MANHOM = '${MANHOM}', LOAISD = N'${LOAISD}', THANHPHAN = '${THANHPHAN}', MANCC = '${MANCC}', GIASI = '${GIASI}', GIALE = '${GIALE}', GIANHAP = '${GIANHAP}', DANGBAOCHE = N'${DANGBAOCHE}', QCDONGGOI = N'${QCDONGGOI}', CONGDUNG = N'${CONGDUNG}' where MATHUOC = '${MATHUOC}'`)
    return res.redirect('/admin/db')
}

let getLOAISD = async (req, res) => {
    let LOAISD = req.params.LOAISD;
    if(LOAISD === 'thucung') {
        LOAISD = 'Thú cưng';
    }
    else if(LOAISD === 'thuysan') {
        LOAISD = 'Thủy sản';
    }
    else if(LOAISD === 'giacam') {
        LOAISD = 'Gia cầm';
    }
    else if(LOAISD === 'giasuc') {
        LOAISD = 'Gia súc';
    }
    const pool = await connectDB();
    const result = await pool.request().query(`select THUOC.*, TENANH from THUOC join PROFILEPICTURE on THUOC.MATHUOC = PROFILEPICTURE.MATHUOC where LOAISD = N'${LOAISD}'`);
    return res.render("sp.ejs", { THUOC: result.recordset, user: req.session.user, pageNumber: -1, pageSize: 10, message: ""});
}

let getsp = async (req, res) => {
    const pool = await connectDB();
    try {
        const result = await pool.request().query('select THUOC.*, TENANH from THUOC join PROFILEPICTURE on THUOC.MATHUOC = PROFILEPICTURE.MATHUOC');
        return res.render("sp.ejs", { THUOC: result.recordset, user: req.session.user, message: ""});
    }
    catch (err) {
        console.log(err);
    }
}

let getcontact = async (req, res) => {
    return res.render("contact.ejs", { user: req.session.user });
}

let getinfo = async (req, res) => {
    return res.render("about.ejs", { user: req.session.user });
}

let getgiohang = async (req, res) => {
    return res.render("giohang.ejs", { user: req.session.user });
}

let addToCart = async (req, res) => {
    if (!req.session.user) {
        return res.redirect('/login');
    }
    let MATHUOC = req.params.MATHUOC;
    let SOLUONG = req.body.SOLUONG || 1;
    let USERNAME = req.session.user.USERNAME;
    let THANHTIEN = req.body.GIALE;
    console.log(MATHUOC, SOLUONG, USERNAME);
    const pool = await connectDB();
    // const re = await pool.request().query(`SELECT * FROM GIOHANG WHERE USERNAME = '${USERNAME}' AND MATHUOC = '${MATHUOC}'`)
    // if (re.recordset.length == 0) {
    const result = await pool.request().query(`INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG) VALUES ('${USERNAME}', '${MATHUOC}', ${SOLUONG})`)
    // }
    // else {
    //     const result = await pool.request().query(`UPDATE GIOHANG SET SOLUONG = SOLUONG + '${SOLUONG}' WHERE USERNAME = '${USERNAME}' AND MATHUOC = '${MATHUOC}'`)
    // }
    return res.redirect('/cart')
}

let getCart = async (req, res) => {
    if (req.session.user == null) {
        return res.redirect('/login')
    }
    let USERNAME = req.session.user.USERNAME;
    const pool = await connectDB();
    const result = await pool.request().query(`SELECT * FROM GIOHANG WHERE USERNAME = '${USERNAME}'`)
    const result2 = await pool.request().query(`SELECT * FROM THUOC WHERE MATHUOC IN (SELECT MATHUOC FROM GIOHANG WHERE USERNAME = '${USERNAME}')`)
    const tongTien = await pool.request().query(`SELECT SUM(THANHTIEN) AS TONGTIEN FROM GIOHANG WHERE USERNAME = '${USERNAME}'`)
    return res.render("cart.ejs", { user: req.session.user, GIOHANG: result.recordset, THUOC: result2.recordset, TONGTIEN: tongTien.recordset[0].TONGTIEN });
}

let deleteCart = async (req, res) => {
    let MATHUOC = req.body.MATHUOC;
    let USERNAME = req.session.user.USERNAME;
    const pool = await connectDB();
    const result = await pool.request().query(`DELETE FROM GIOHANG WHERE USERNAME = '${USERNAME}' AND MATHUOC = '${MATHUOC}'`)
    return res.redirect('/cart')
}

let admin = async (req, res) => {
    if (req.session.user == null) {
        return res.redirect('/login')
    }
    const pool = await connectDB();
    const doanhthuThang = []
    for(let i = 1; i <= 12; i++) {
        const result = await pool.request().query(`SELECT dbo.UF_TinhDoanhThuTheoThang(${i}, YEAR(GETDATE())) as DOANHTHU`)
        doanhthuThang.push(result.recordset[0].DOANHTHU)
    }
    const doanhthuQuy = []
    for(let i = 1; i <= 4; i++) {
        const result = await pool.request().query(`SELECT dbo.UF_TinhDoanhThuTheoQuy(${i}, YEAR(GETDATE())) as DOANHTHU`)
        doanhthuQuy.push(result.recordset[0].DOANHTHU)
    }
    const result = await pool.request().query(`SELECT dbo.UF_TinhDoanhThuTheoNam(YEAR(GETDATE())) as DOANHTHU`)
    const doanhthuNam = result.recordset[0].DOANHTHU
    const result2 = await pool.request().query(`SELECT * FROM DONHANGONLINE`)
    return res.render("admin.ejs", { user: req.session.user, doanhthuThang: doanhthuThang, doanhthuQuy: doanhthuQuy, doanhthuNam: doanhthuNam, DONHANGONLINE: result2.recordset });
}

let getUploadPage = async (req, res) => {
    return res.render("upload.ejs", { user: req.session.user, message: '' });
}

let handleUploadProfilePic = async (req, res) => {
    let MATHUOC = req.body.MATHUOC;
    let pool = await connectDB();
    upload(req, res, function (err) {
        // req.file contains information of uploaded file
        // req.body contains information of text fields, if there were any

        if (req.fileValidationError) {
            return res.send(req.fileValidationError);
        }
        else if (!req.file) {
            return res.render('upload.ejs', { user: req.session.user, message: 'Please select an image to upload' });
        }
        else if (err instanceof multer.MulterError) {
            console.log(err);
            return res.send(err);
        }
        else if (err) {
            console.log(err);
            return res.send(err);
        }
    });
    // let result = await pool.request().query(`UPDATE PROFILEPICTURE SET PROFILEPIC = '${req.file.buffer}', MATHUOC = '${MATHUOC}'`)
    return res.redirect('/admin')
}

let handleUploadMultiPic = async (req, res) => {
    let pool = await connectDB();
    let MATHUOC = req.body.MATHUOC;
    uploadMulti(req, res, function (err) {
        if (req.fileValidationError) {
            return res.send(req.fileValidationError);
        }
        // else if (!req.files) {
        //     return res.render('upload.ejs', { user: req.session.user, message: 'Please select an image to upload' });
        // }
        else if (err instanceof multer.MulterError) {
            console.log(err);
            return res.send(err);
        }
        else if (err) {
            console.log(err);
        }
    });
    if (req.files.length == 0) {
        return res.render('upload.ejs', { user: req.session.user, message: 'Please select an image to upload' });
    }
    // const files = req.files;
    // let index, len;
    // for (index = 0, len = files.length; index < len; ++index) {
    //     let result = pool.request().query(`INSERT INTO HINHANH VALUES ('${MATHUOC}', '${files[index].filename}')`)
    // }
    return res.redirect('/admin')
}

let getSearch = async (req, res) => {
    let search = req.body.search;
    let pool = await connectDB();
    const user = req.session.user;
    if (search == '') {
        if (user.QUANTRI == 1) {
            return res.redirect('/admin')
        }
        return res.redirect('/')
    }
    let result = await pool.request().query(`SELECT THUOC.*, TENANH FROM THUOC, PROFILEPICTURE WHERE THUOC.MATHUOC = PROFILEPICTURE.MATHUOC and (TENTHUOC LIKE N'%${search}%' OR THUOC.MATHUOC LIKE '%${search}%' OR LOAISD LIKE N'%${search}%' OR CONGDUNG LIKE N'%${search}%')`)
    if(user.QUANTRI == 1){
        if (result.recordset.length == 0) {
            return res.render('db.ejs', { user: req.session.user, THUOC: result.recordset, pageNumber: -1, pageSize: 0, message: 'Không tìm thấy sản phẩm nào' })
        }
        return res.render('db.ejs', { user: req.session.user, THUOC: result.recordset, pageNumber: -1, pageSize: 0, message: '' })
    }
    if (result.recordset.length == 0) {
        return res.render('sp.ejs', { user: req.session.user, THUOC: result.recordset, pageNumber: -1, pageSize: 0, message: 'Không tìm thấy sản phẩm nào' })
    }
    return res.render('sp.ejs', { user: req.session.user, THUOC: result.recordset, message: '' })
}

let updateDONHANG = async (req, res) => {
    let pool = await connectDB();
    let MADONHANG = req.body.MADONHANG;
    let TRANGTHAI = req.body.TRANGTHAI;
    console.log(MADONHANG, TRANGTHAI)
    let result = await pool.request().query(`UPDATE DONHANGONLINE SET TRANGTHAIDH = N'${TRANGTHAI}' WHERE MADONHANG = '${MADONHANG}'`)
    return res.redirect('/admin')
}

module.exports = {
    getHompage: getHompage,
    getConnect: getConnect,
    getTHUOC: getTHUOC,
    themthuoc: themthuoc,
    newTHUOC: newTHUOC,
    deleteTHUOC: deleteTHUOC,
    editTHUOC: editTHUOC,
    updateTHUOC: updateTHUOC,
    getsp: getsp,
    getcontact: getcontact,
    getinfo: getinfo,
    getgiahang: getgiohang,
    addToCart: addToCart,
    getCart: getCart,
    deleteCart: deleteCart,
    admin: admin,
    handleUploadProfilePic: handleUploadProfilePic,
    handleUploadMultiPic: handleUploadMultiPic,
    getUploadPage: getUploadPage,
    getSearch: getSearch,
    updateDONHANG: updateDONHANG,
    getLOAISD: getLOAISD,
}