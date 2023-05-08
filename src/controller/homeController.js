import { connectDB } from '../configs/connectDB';
let getHompage = (req, res) => {
    return res.render("index.ejs", { user: req.session.user });
}

let getConnect = async (req, res) => {
    const pool = await connectDB();
    try {
        const result = await pool.request().query('select * from THUOC');
        return res.render("db.ejs", { THUOC: result.recordset, user: req.session.user});
    }
    catch (err) {
        console.log(err);
    }
}

let getTHUOC = async (req, res) => {
    let MATHUOC = req.params.MATHUOC;
    const pool = await connectDB();
    try {
        const result = await pool.request().query(`select * from THUOC where MATHUOC = '${MATHUOC}'`)
        return res.render("thuoc.ejs", { THUOC: result.recordset[0], user: req.session.user })
    }
    catch (err) {
        console.log(err);
    }
}

let themthuoc = (req, res) => {
    return res.render("themthuoc.ejs", { message: "" , user: req.session.user});
}

let newTHUOC = async (req, res) => {
    let { MATHUOC, TENTHUOC, MANHOM, LOAISD, THANHPHAN, MANCC, GIASI, GIALE, GIANHAP, DANGBAOCHE, QCDONGGOI, CONGDUNG } = req.body;
    const pool = await connectDB();
    const result = await pool.request().query(`insert into THUOC(MATHUOC, TENTHUOC, MANHOM, LOAISD, THANHPHAN, MANCC, GIASI, GIALE, GIANHAP, DANGBAOCHE, QCDONGGOI, CONGDUNG) values ('${MATHUOC}', N'${TENTHUOC}', '${MANHOM}', N'${LOAISD}', '${THANHPHAN}', '${MANCC}', '${GIASI}', '${GIALE}', '${GIANHAP}', N'${DANGBAOCHE}', N'${QCDONGGOI}', N'${CONGDUNG}')`)
    return res.redirect('/db/thuoc')
}

let deleteTHUOC = async (req, res) => {
    let MATHUOC = req.body.MATHUOC;
    console.log(MATHUOC)
    const pool = await connectDB();
    const result = await pool.request().query(`delete from THUOC where MATHUOC = '${MATHUOC}'`)
    return res.redirect('/db')
}

let editTHUOC = async (req, res) => {
    let MATHUOC = req.params.MATHUOC;
    const pool = await connectDB();
    const result = await pool.request().query(`select * from THUOC where MATHUOC = '${MATHUOC}'`)
    return res.render("update.ejs", { THUOC: result.recordset[0], user: req.session.user });
}

let updateTHUOC = async (req, res) => {
    let { MATHUOC, TENTHUOC, MANHOM, LOAISD, THANHPHAN, MANCC, GIASI, GIALE, GIANHAP, DANGBAOCHE, QCDONGGOI, CONGDUNG } = req.body;
    const pool = await connectDB();
    const result = await pool.request().query(`update THUOC set TENTHUOC = '${TENTHUOC}', MANHOM = '${MANHOM}', LOAISD = N'${LOAISD}', THANHPHAN = '${THANHPHAN}', MANCC = '${MANCC}', GIASI = '${GIASI}', GIALE = '${GIALE}', GIANHAP = '${GIANHAP}', DANGBAOCHE = N'${DANGBAOCHE}', QCDONGGOI = N'${QCDONGGOI}', CONGDUNG = N'${CONGDUNG}' where MATHUOC = '${MATHUOC}'`)
    return res.redirect('/db/thuoc')
}

let addToCart = async (req, res) => {
    let MATHUOC = req.params.MATHUOC;
    const pool = await connectDB();
    const result = await pool.request().query(`UPDATE CART SET SOLUONG = SOLUONG + 1 WHERE MATHUOC = '${MATHUOC}'`)
    return res.redirect('/cart')
}

let getCart = (req, res) => {
    return res.render("cart.ejs" , { user: req.session.user });
}

let get4T = (req, res) => {
    return res.render("4T.ejs" , { user: req.session.user });
}

let getsp = (req, res) => {
    return res.render("sp.ejs" , { user: req.session.user });
}

let admin = (req, res) => {
    if (req.session.user == null) {
        return res.redirect('/login')
    }
    return res.render("admin.ejs" , { user: req.session.user });
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
    get4T: get4T,
    getsp: getsp,
    addToCart: addToCart,
    getCart: getCart,
    admin: admin,
}