import { connectDB } from '../configs/connectDB';
import multer from 'multer';
import fs from 'fs';
import appRoot from 'app-root-path';
import sql from 'mssql';

let upload = multer().single('profile_pic');
let uploadMulti = multer().array('pic');

let getHomepage = async (req, res) => {
    const user = req.session.user;
    if (user && user.QUANTRI) {
        return res.redirect("/admin");
    }
    const pool = await connectDB();
    const result = await pool.request().query(`select THUOC.*, TENANH from THUOC, PROFILEPICTURE where THUOC.MATHUOC = PROFILEPICTURE.MATHUOC order by MATHUOC offset 0 rows fetch next 10 rows only`);
    const SPBANCHAY = await pool.request().query(`SELECT u.*, p.TENANH FROM dbo.UF_XuatSanPhamBanChayTheoNam(YEAR(GETDATE())) AS u JOIN PROFILEPICTURE AS p ON p.MATHUOC = u.MATHUOC`);
    return res.render("index.ejs", { user: req.session.user, appRoot: appRoot.path, THUOC: result.recordset, SPBANCHAY: SPBANCHAY.recordset });
}

let getConnect = async (req, res) => {
    const pool = await connectDB();
    const pageNumber = parseInt(req.query.pageNumber) || 1;
    const pageSize = parseInt(req.query.pageSize) || 9;
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
        const LOAISD = result.recordset[0].LOAISD;
        const result2 = await pool.request().query(`select * from ALBUMPICTURES where MATHUOC = '${MATHUOC}'`);
        const result1 = await pool.request().query(`select THUOC.*, PROFILEPICTURE.TENANH from THUOC, PROFILEPICTURE where THUOC.MATHUOC = PROFILEPICTURE.MATHUOC and THUOC.LOAISD = N'${result.recordset[0].LOAISD}'`);
        return res.render("thuoc.ejs", { THUOC: result.recordset[0], user: req.session.user, appRoot: appRoot.path, ALBUMPICTURES: result2.recordset, THUOCLOAISD: result1.recordset });
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

// 

// let newTHUOC = async (req, res) => {
//     let { MATHUOC, TENTHUOC, MANHOM, LOAISD, THANHPHAN, MANCC, GIASI, GIALE, GIANHAP, DANGBAOCHE, QCDONGGOI, CONGDUNG } = req.body;
//     const pool = await connectDB();
//     const transaction = new sql.Transaction(pool);

//     try {
//         await transaction.begin();

//         if (!MATHUOC || !TENTHUOC || !MANHOM || !LOAISD || !THANHPHAN || !MANCC || !GIASI || !GIALE || !GIANHAP || !DANGBAOCHE || !QCDONGGOI || !CONGDUNG) {
//             await transaction.rollback();
//             return res.render("themthuoc.ejs", { message: "Vui lòng nhập đầy đủ thông tin", user: req.session.user });
//         }

//         const isExist = await pool.request().query(`select * from THUOC where MATHUOC = '${MATHUOC}'`);
//         if (isExist.recordset.length > 0) {
//             await transaction.rollback();
//             return res.render("themthuoc.ejs", { message: "Thuốc đã tồn tại", user: req.session.user });
//         }

//         const result = await pool.request().query(`insert into THUOC(MATHUOC, TENTHUOC, MANHOM, LOAISD, THANHPHAN, MANCC, GIASI, GIALE, GIANHAP, DANGBAOCHE, QCDONGGOI, CONGDUNG) values ('${MATHUOC}', N'${TENTHUOC}', '${MANHOM}', N'${LOAISD}', N'${THANHPHAN}', '${MANCC}', '${GIASI}', '${GIALE}', '${GIANHAP}', N'${DANGBAOCHE}', N'${QCDONGGOI}', N'${CONGDUNG}')`, transaction);

//         // Insert profile picture file name
//         if (req.files.profile_pic) {
//             let profilePicResult = await pool.request().query(`INSERT INTO PROFILEPICTURE VALUES ('${MATHUOC}', '${req.files.profile_pic[0].filename}')`, transaction);
//         }

//         // Insert album pictures file names
//         if (req.files.pic) {
//             for (let i = 0; i < req.files.pic.length; i++) {
//                 let albumPicResult = await pool.request().query(`INSERT INTO ALBUMPICTURES VALUES ('${MATHUOC}', '${req.files.pic[i].filename}')`, transaction);
//             }
//         }

//         await transaction.commit();
//         return res.redirect('/admin/db');
//     } catch (err) {
//         console.log(err);
//         await transaction.rollback();
//         let path = `./src/public/uploads/${MATHUOC}/`;
//         if (fs.existsSync(path)) {
//             await removeDirectory(path);
//         } else {
//             console.log(`Directory '${path}' does not exist.`);
//         }
//         return res.render("themthuoc.ejs", { message: "Không thể thêm thuốc", user: req.session.user });
//     } finally {
//         transaction.release();
//     }
// }

let newTHUOC = async (req, res) => {
    let { MATHUOC, TENTHUOC, MANHOM, LOAISD, THANHPHAN, MANCC, GIASI, GIALE, GIANHAP, DANGBAOCHE, QCDONGGOI, CONGDUNG } = req.body;
    const pool = await connectDB();
    const transaction = new sql.Transaction(pool);
    try {
        await transaction.begin();

        if (!MATHUOC || !TENTHUOC || !MANHOM || !LOAISD || !THANHPHAN || !MANCC || !GIASI || !GIALE || !GIANHAP || !DANGBAOCHE || !QCDONGGOI || !CONGDUNG) {
            await transaction.rollback();
            return res.render("themthuoc.ejs", { message: "Vui lòng nhập đầy đủ thông tin", user: req.session.user });
        }

        const isExist = await pool.request().query(`select * from THUOC where MATHUOC = '${MATHUOC}'`);
        if (isExist.recordset.length > 0) {
            await transaction.rollback();
            return res.render("themthuoc.ejs", { message: "Thuốc đã tồn tại", user: req.session.user });
        }

        const result = await pool.request().query(`insert into THUOC(MATHUOC, TENTHUOC, MANHOM, LOAISD, THANHPHAN, MANCC, GIASI, GIALE, GIANHAP, DANGBAOCHE, QCDONGGOI, CONGDUNG) values ('${MATHUOC}', N'${TENTHUOC}', '${MANHOM}', N'${LOAISD}', N'${THANHPHAN}', '${MANCC}', '${GIASI}', '${GIALE}', '${GIANHAP}', N'${DANGBAOCHE}', N'${QCDONGGOI}', N'${CONGDUNG}')`, transaction);

        // File upload logic
        upload(req, res, async function (err) {
            // Handle file upload errors
            if (req.fileValidationError) {
                await transaction.rollback();
                return res.send(req.fileValidationError);
            } else if (!req.files) {
                await transaction.rollback();
                return res.render('themthuoc.ejs', { user: req.session.user, message: 'Please select an image to upload' });
            } else if (err instanceof multer.MulterError) {
                await transaction.rollback();
                console.log(err);
                return res.send(err);
            } else if (err) {
                await transaction.rollback();
                console.log(err);
                return res.send(err);
            }

            try {
                // Insert profile picture file name
                if (req.files.profile_pic) {
                    let profilePicResult = await pool.request().query(`INSERT INTO PROFILEPICTURE VALUES ('${MATHUOC}', '${req.files.profile_pic[0].filename}')`, transaction);
                }

                // Insert album pictures file names
                if (req.files.pic) {
                    for (let i = 0; i < req.files.pic.length; i++) {
                        let albumPicResult = await pool.request().query(`INSERT INTO ALBUMPICTURES VALUES ('${MATHUOC}', '${req.files.pic[i].filename}')`, transaction);
                    }
                }

                await transaction.commit();
                return res.redirect('/admin/db');
            } catch (err) {
                console.log(err);
                await transaction.rollback();
                return res.render("themthuoc.ejs", { message: "Error occurred while inserting file names", user: req.session.user });
            }
        });
    } catch (err) {
        console.log(err);
        await transaction.rollback();
        let path = `./src/public/uploads/${MATHUOC}/`;
        if (fs.existsSync(path)) {
            await removeDirectory(path);
        } else {
            console.log(`Directory '${path}' does not exist.`);
        }
        return res.render("themthuoc.ejs", { message: "Không thêm được thuốc", user: req.session.user });
    } finally {
        transaction.release();
    }
}


let deleteTHUOC = async (req, res) => {
    let MATHUOC = req.body.MATHUOC;
    const pool = await connectDB();

    try {
        // Delete record from the database
        const result = await pool.request().query(`DELETE FROM THUOC WHERE MATHUOC = '${MATHUOC}'`);

        // Delete the corresponding directory
        let path = `./src/public/uploads/${MATHUOC}/`;
        if (fs.existsSync(path)) {
            await removeDirectory(path);
        } else {
            console.log(`Directory '${path}' does not exist.`);
        }

        return res.redirect('/admin/db');
    } catch (err) {
        console.error('Error deleting THUOC:', err);
        return res.redirect('/admin/db');
    }
}

async function removeDirectory(path) {
    const files = await fs.promises.readdir(path);

    for (const file of files) {
        const filePath = `${path}/${file}`;
        const fileStat = await fs.promises.lstat(filePath);

        if (fileStat.isDirectory()) {
            await removeDirectory(filePath);
        } else {
            await fs.promises.unlink(filePath);
        }
    }

    await fs.promises.rmdir(path);
}

let editTHUOC = async (req, res) => {
    const user = req.session.user;
    if (!user || !user.QUANTRI) {
        return res.redirect('/');
    }
    let MATHUOC = req.params.MATHUOC;
    const pool = await connectDB();
    const result = await pool.request().query(`select * from THUOC where MATHUOC = '${MATHUOC}'`)
    return res.render("update.ejs", { THUOC: result.recordset[0], user: req.session.user, message: "" });
}

let updateTHUOC = async (req, res) => {
    const user = req.session.user;
    if (!user || !user.QUANTRI) {
        return res.redirect('/');
    }
    let { MATHUOC, TENTHUOC, MANHOM, LOAISD, THANHPHAN, MANCC, GIASI, GIALE, GIANHAP, DANGBAOCHE, QCDONGGOI, CONGDUNG } = req.body;
    const pool = await connectDB();
    const transaction = new sql.Transaction(pool);

    try {
        await transaction.begin();

        const request = transaction.request();
        await request.query(`update THUOC set TENTHUOC = '${TENTHUOC}', MANHOM = '${MANHOM}', LOAISD = N'${LOAISD}', THANHPHAN = '${THANHPHAN}', MANCC = '${MANCC}', GIASI = '${GIASI}', GIALE = '${GIALE}', GIANHAP = '${GIANHAP}', DANGBAOCHE = N'${DANGBAOCHE}', QCDONGGOI = N'${QCDONGGOI}', CONGDUNG = N'${CONGDUNG}' where MATHUOC = '${MATHUOC}'`);

        await transaction.commit();

        return res.redirect('/admin/db');
    } catch (error) {
        await transaction.rollback();

        // Handle the error appropriately
        console.error('Transaction failed. Rolling back.', error);

        // Return an error response
        return res.status(500).render("update.ejs", { THUOC: req.body, user: req.session.user, message: "Cập nhật thất bại" });
    }
}


let getLOAISD = async (req, res) => {
    let LOAISD = req.params.LOAISD;
    if (LOAISD === 'thucung') {
        LOAISD = 'Thú cưng';
    }
    else if (LOAISD === 'thuysan') {
        LOAISD = 'Thủy sản';
    }
    else if (LOAISD === 'giacam') {
        LOAISD = 'Gia cầm';
    }
    else if (LOAISD === 'giasuc') {
        LOAISD = 'Gia súc';
    }
    const pool = await connectDB();
    const result = await pool.request().query(`select THUOC.*, TENANH from THUOC join PROFILEPICTURE on THUOC.MATHUOC = PROFILEPICTURE.MATHUOC where LOAISD = N'${LOAISD}'`);
    return res.render("sp.ejs", { THUOC: result.recordset, user: req.session.user, pageNumber: -1, pageSize: 10, message: "" });
}

let getsp = async (req, res) => {
    const pool = await connectDB();
    try {
        const result = await pool.request().query('select THUOC.*, TENANH from THUOC join PROFILEPICTURE on THUOC.MATHUOC = PROFILEPICTURE.MATHUOC');
        return res.render("sp.ejs", { THUOC: result.recordset, user: req.session.user, message: "" });
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
    let TENANH = req.params.TENANH;
    let MATHUOC = req.params.MATHUOC;
    let SOLUONG = req.body.SOLUONG || 1;
    let USERNAME = req.session.user.USERNAME;
    let THANHTIEN = req.body.GIALE;
    const pool = await connectDB();
    // const re = await pool.request().query(`SELECT * FROM GIOHANG WHERE USERNAME = '${USERNAME}' AND MATHUOC = '${MATHUOC}'`)
    // if (re.recordset.length == 0) {
    const result = await pool.request().query(`INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG) VALUES ('${USERNAME}', '${MATHUOC}', ${SOLUONG})`)
    // }
    // else {
    //     const result = await pool.request().query(`UPDATE GIOHANG SET SOLUONG = SOLUONG + '${SOLUONG}' WHERE USERNAME = '${USERNAME}' AND MATHUOC = '${MATHUOC}'`)
    // }
    return res.redirect('/sp/')
}

let getCart = async (req, res) => {
    if (req.session.user == null) {
        return res.redirect('/login')
    }
    let USERNAME = req.session.user.USERNAME;
    const pool = await connectDB();
    const result = await pool.request().query(`SELECT * FROM GIOHANG WHERE USERNAME = '${USERNAME}'`)
    const result2 = await pool.request().query(`SELECT THUOC.*, TENANH FROM THUOC, PROFILEPICTURE WHERE THUOC.MATHUOC = PROFILEPICTURE.MATHUOC AND THUOC.MATHUOC IN (SELECT MATHUOC FROM GIOHANG WHERE USERNAME = '${USERNAME}')`)
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
    await pool.request().query(`SET DATEFORMAT DMY`)
    const doanhthuThang = []
    for (let i = 1; i <= 12; i++) {
        const result = await pool.request().query(`SELECT dbo.UF_TinhDoanhThuTheoThang(${i}, YEAR(GETDATE())) as DOANHTHU`)
        doanhthuThang.push(result.recordset[0].DOANHTHU)
    }
    const doanhthuQuy = []
    for (let i = 1; i <= 4; i++) {
        const result = await pool.request().query(`SELECT dbo.UF_TinhDoanhThuTheoQuy(${i}, YEAR(GETDATE())) as DOANHTHU`)
        doanhthuQuy.push(result.recordset[0].DOANHTHU)
    }
    const result = await pool.request().query(`SELECT dbo.UF_TinhDoanhThuTheoNam(YEAR(GETDATE())) as DOANHTHU`)
    const doanhthuNam = result.recordset[0].DOANHTHU
    const result2 = await pool.request().query(`SELECT * FROM DONHANGONLINE`)
    const CongNoNCC = await pool.request().query(`SELECT TENNCC, CONGNO, FORMAT(NGAYNO, 'dd/MM/yyyy') as NGAYNO, FORMAT(HANNO, 'dd/MM/yyyy') as HANNO FROM CongNoNCC`)
    const CongNoKH = await pool.request().query(`SELECT TENKHACH, CONGNO, FORMAT(NGAYNO, 'dd/MM/yyyy') as NGAYNO, FORMAT(HANNO, 'dd/MM/yyyy') as HANNO FROM CongNoKhachHang`)
    return res.render("admin.ejs", { user: req.session.user, doanhthuThang: doanhthuThang, doanhthuQuy: doanhthuQuy, doanhthuNam: doanhthuNam, DONHANGONLINE: result2.recordset, CongNoNCC: CongNoNCC.recordset, CongNoKH: CongNoKH.recordset });
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
    try {
        let search = req.body.search;
        let pool = await connectDB();
        const user = req.session.user;

        if (search == '') {
            if (user && user.QUANTRI == 1) {
                return res.redirect('/admin');
            }
            return res.redirect('/');
        }

        let result = await pool.request().query(`SELECT THUOC.*, TENANH FROM THUOC, PROFILEPICTURE WHERE THUOC.MATHUOC = PROFILEPICTURE.MATHUOC and (TENTHUOC LIKE N'%${search}%' OR THUOC.MATHUOC LIKE '%${search}%' OR LOAISD LIKE N'%${search}%' OR CONGDUNG LIKE N'%${search}%')`);

        if (user && user.QUANTRI == 1) {
            if (result.recordset.length == 0) {
                return res.render('db.ejs', { user: req.session.user, THUOC: result.recordset, pageNumber: -1, pageSize: 0, message: 'Không tìm thấy sản phẩm nào' });
            }
            return res.render('db.ejs', { user: req.session.user, THUOC: result.recordset, pageNumber: -1, pageSize: 0, message: '' });
        }

        if (result.recordset.length == 0) {
            return res.render('sp.ejs', { user: req.session.user, THUOC: result.recordset, pageNumber: -1, pageSize: 0, message: 'Không tìm thấy sản phẩm nào' });
        }

        return res.render('sp.ejs', { user: req.session.user, THUOC: result.recordset, pageNumber: -1, pageSize: 0, message: '' });
    } catch (error) {
        // Handle the error appropriately
        console.error('Error in getSearch:', error);
        return res.status(500).send('Internal Server Error');
    }
};


let updateDONHANG = async (req, res) => {
    let pool = await connectDB();
    let MADONHANG = req.body.MADONHANG;
    let TRANGTHAI = req.body.TRANGTHAI;
    console.log(MADONHANG, TRANGTHAI)
    let result = await pool.request().query(`UPDATE DONHANGONLINE SET TRANGTHAIDH = N'${TRANGTHAI}' WHERE MADONHANG = '${MADONHANG}'`)
    return res.redirect('/admin')
}

const thanhToan = async (req, res) => {
    let user = req.session.user;
    if (!user) {
        return res.redirect('/login');
    }

    let DIENTHOAI = req.body.DIENTHOAI;
    let DIACHI = req.body.DIACHI;
    let GIOHANG = JSON.parse(req.body.GIOHANG);
    let THUOC = JSON.parse(req.body.THUOC);
    if (GIOHANG.length == 0) {
        return res.redirect('/cart');
    }
    console.log(GIOHANG, THUOC, DIENTHOAI, DIACHI);

    try {
        let pool = await connectDB(); // Establish a database connection
        let result = await pool.request().query(`INSERT INTO DONHANGONLINE (USERNAME, DIENTHOAI, DIACHI) VALUES ('${user.USERNAME}', N'${DIENTHOAI}', N'${DIACHI}')`);
        let result2 = await pool.request().query(`SELECT TOP 1 MADONHANG FROM DONHANGONLINE ORDER BY MADONHANG DESC`);
        let MADONHANG = result2.recordset[0].MADONHANG;

        for (let i = 0; i < GIOHANG.length; i++) {
            for (let j = 0; j < THUOC.length; j++) {
                if (GIOHANG[i].MATHUOC == THUOC[j].MATHUOC) {
                    let result3 = await pool.request().query(`INSERT INTO DONXUATONLINECHITIET (MADONHANG, THUOC, SOLUONG, DONVITINH) VALUES ('${MADONHANG}', '${THUOC[j].MATHUOC}', '${GIOHANG[i].SOLUONG}', N'${THUOC[j].QCDONGGOI}')`);
                }
            }
        }

        let result4 = await pool.request().query(`DELETE FROM GIOHANG WHERE USERNAME = '${user.USERNAME}'`);

        res.redirect('/donhang')
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Error occurred during payment" });
    }
};

let donHang = async (req, res) => {
    let user = req.session.user;
    if (!user) {
        return res.redirect('/login');
    }
    try {
        let pool = await connectDB();
        let result = await pool.request().query(`SELECT * FROM DONHANGONLINE WHERE USERNAME = '${user.USERNAME}'`);
        return res.render('donhang.ejs', { user: req.session.user, DONHANG: result.recordset });
    }
    catch (error) {
        console.error(error);
        return res.status(500).send('Internal Server Error');
    }
}

module.exports = {
    getHomepage: getHomepage,
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
    thanhToan: thanhToan,
    donHang: donHang,
}