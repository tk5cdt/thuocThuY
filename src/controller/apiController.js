import { connectDB } from '../configs/connectDB';

let getTHUOC = async (req, res) => {
    const pool = await connectDB();
    const result = await pool.request().query('select * from THUOC')
    return res.status(200).send(result.recordset)
}

let newTHUOC = async (req, res) => {
    let { MATHUOC, TENTHUOC, MANHOM, LOAISD, THANHPHAN, MANCC, GIASI, GIALE, GIANHAP, DANGBAOCHE, QCDONGGOI, CONGDUNG } = req.body;
    const pool = await connectDB();
    const result = await pool.request().query(`insert into THUOC(MATHUOC, TENTHUOC, MANHOM, LOAISD, THANHPHAN, MANCC, GIASI, GIALE, GIANHAP, DANGBAOCHE, QCDONGGOI, CONGDUNG) values ('${MATHUOC}', N'${TENTHUOC}', '${MANHOM}', N'${LOAISD}', '${THANHPHAN}', '${MANCC}', '${GIASI}', '${GIALE}', '${GIANHAP}', N'${DANGBAOCHE}', N'${QCDONGGOI}', N'${CONGDUNG}')`)
    // return res.send(result.recordset)
}

module.exports = {
    getTHUOC: getTHUOC,
    newTHUOC: newTHUOC
}