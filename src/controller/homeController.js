import { connectDB } from '../configs/connectDB';
let getHompage = (req, res) => {
    return res.render("index.ejs");
}

let getConnect = async (req, res) => {
    const pool = await connectDB();
    const result = await pool.request().query('select * from THUOC').then((result) => {
        res.render("db.ejs", { THUOC: JSON.stringify(result.recordset)});
    });
    console.log(result);
    // res.json(result.recordset);
}

module.exports = {
    getHompage: getHompage,
    getConnect: getConnect
}