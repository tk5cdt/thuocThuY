import { where } from 'sequelize';
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
    let MATHUOC = req.body.MATHUOC;
    let TENTHUOC = req.body.TENTHUOC;
    let MANHOM = req.body.MANHOM;
    let LOAISD = req.body.LOAISD;
    let THANHPHAN = req.body.THANHPHAN;
    let MANCC = req.body.MANCC;
    let GIASI = req.body.GIASI;
    let GIALE = req.body.GIALE;
    let GIANHAP = req.body.GIANHAP;
    let DANGBAOCHE = req.body.DANGBAOCHE;
    let QCDONGGOI = req.body.QCDONGGOI;
    let CONGDUNG = req.body.CONGDUNG;
    const pool = await connectDB();
    const result = await pool.request().query(`insert into THUOC(MATHUOC, TENTHUOC, MANHOM, LOAISD, THANHPHAN, MANCC, GIASI, GIALE, GIANHAP, DANGBAOCHE, QCDONGGOI, CONGDUNG) values ('${MATHUOC}', N'${TENTHUOC}', '${MANHOM}', N'${LOAISD}', '${THANHPHAN}', '${MANCC}', '${GIASI}', '${GIALE}', '${GIANHAP}', N'${DANGBAOCHE}', N'${QCDONGGOI}', N'${CONGDUNG}')`)
    return res.redirect('/db/thuoc')
}

let deleteTHUOC = async (req, res) => {
    let MATHUOC = req.body.MATHUOC;
    console.log(MATHUOC)
    const pool = await connectDB();
    const result = await pool.request().query(`delete from THUOC where MATHUOC = '${MATHUOC}'`)
    console.log(result)
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

module.exports = {
    getHompage: getHompage,
    getConnect: getConnect,
    getTHUOC: getTHUOC,
    newTHUOC: newTHUOC,
    deleteTHUOC: deleteTHUOC,
    editTHUOC: editTHUOC,
    updateTHUOC: updateTHUOC
}