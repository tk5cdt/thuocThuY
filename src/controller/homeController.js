import { connectDB } from '../configs/connectDB';
let getHompage = (req, res) => {
    return res.render("index.ejs");
}

let getConnect = async (req, res) => {
    const pool = await connectDB();
    const result = await pool.request().query('select * from THUOC').then((result) => {
        res.render("db.ejs", { THUOC: result.recordset});
    });
}

let getTHUOC = async (req, res) => {
    let MATHUOC = req.params.MATHUOC;
    const pool = await connectDB();
    const result = await pool.request().query(`select * from THUOC where MATHUOC = '${MATHUOC}'`)
    return res.send(JSON.stringify(result.recordset))
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
    return res.redirect('/db/thuoc')
}

let editTHUOC = async (req, res) => {
    let MATHUOC = req.params.MATHUOC;
    const pool = await connectDB();
    const result = await pool.request().query(`select * from THUOC where MATHUOC = '${MATHUOC}'`).then((result) => {
        res.render("update.ejs", { THUOC: result.recordset[0] });
    });
    // return res.render("update.ejs", { THUOC: result.recordset[0] });
}

let updateTHUOC = async (req, res) => {
    let { MATHUOC, TENTHUOC, MANHOM, LOAISD, THANHPHAN, MANCC, GIASI, GIALE, GIANHAP, DANGBAOCHE, QCDONGGOI, CONGDUNG } = req.body;
    const pool = await connectDB();
    const result = await pool.request().query(`update THUOC set TENTHUOC = '${TENTHUOC}', MANHOM = '${MANHOM}', LOAISD = N'${LOAISD}', THANHPHAN = '${THANHPHAN}', MANCC = '${MANCC}', GIASI = '${GIASI}', GIALE = '${GIALE}', GIANHAP = '${GIANHAP}', DANGBAOCHE = N'${DANGBAOCHE}', QCDONGGOI = N'${QCDONGGOI}', CONGDUNG = N'${CONGDUNG}' where MATHUOC = '${MATHUOC}'`)
    return res.redirect('/db/thuoc')
}

let getsp = (req, res) => {
    return res.render("sp.ejs", { user: req.session.user });
}

let getcontact = (req, res) => {
    return res.render("contact.ejs", { user: req.session.user });
}

let getinfo = (req, res) => {
    return res.render("info.ejs", { user: req.session.user });
}

let getregister = (req, res) => {
    return res.render("register.ejs", { user: req.session.user });
}

let getlog = (req, res) => {
    return res.render("log.ejs", { user: req.session.user });
}

let getgiohang = (req, res) => {
    return res.render("giohang.ejs", { user: req.session.user });
}

module.exports = {
    getHompage: getHompage,
    getConnect: getConnect,
    getTHUOC: getTHUOC,
    newTHUOC: newTHUOC,
    deleteTHUOC: deleteTHUOC,
    editTHUOC: editTHUOC,
    updateTHUOC: updateTHUOC,
    getsp: getsp,
    getsp: getcontact,
    getsp: getinfo,
    getsp: getregister,
    getsp: getlog,
    getsp: getgiohang,
}