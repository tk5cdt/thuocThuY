import { connectDB } from '../configs/connectDB';
import bcrypt from 'bcryptjs';

const signup = async (req, res) => {
    let { username, email, password, rePassword } = req.body;
    const pool = await connectDB();
    const result = await pool.request().query(`select * from NGUOIDUNG where USERNAME = '${username}'`)
    if (result.recordset.length > 0) {
        return res.render("signup.ejs", { message: "Username đã tồn tại" });
    }
    else {
        if (password !== rePassword) {
            return res.render("signup.ejs", { message: "Mật khẩu không khớp" });
        }
        else {
            try {
                const salt = bcrypt.genSaltSync(10);
                const hashPassword = bcrypt.hashSync(password, salt);
                console.log(hashPassword);
                const result = await pool.request().query(`insert into NGUOIDUNG(USERNAME, MATKHAU, EMAIL, QUANTRI) values('${username}', '${hashPassword}', '${email}', '0')`)
                return res.redirect('/login')
            } catch (error) {
                console.log(error);
                return res.render("signup.ejs", { message: "Đăng ký thất bại" });
            }
        }
    }
}

const login = async (req, res) => {
    let { username, password } = req.body;
    const pool = await connectDB();
    const result = await pool.request().query(`select * from NGUOIDUNG where USERNAME = '${username}'`)
    if (result.recordset.length === 0) {
        return res.render("login.ejs", { message: "Username không tồn tại" });
    }
    else {
        const user = result.recordset[0];
        const isMatch = await bcrypt.compare(password, user.MATKHAU);
        if (isMatch) {
            req.session.user = user;
            if (user.QUANTRI === true)
                return res.redirect('/admin');
            else
                return res.redirect('/');
        }
        else {
            return res.render("login.ejs", { message: "Sai mật khẩu" });
        }
    }
}

const dangky = (req, res) => {
    return res.render("signup.ejs", { message: "" , user: req.session.user});
}

const dangnhap = (req, res) => {
    return res.render("login.ejs", { message: "" , user: req.session.user});
}

const logout = (req, res) => {
    req.session.destroy((err) => {
      if (err) {
        console.log(err);
      } else {
        res.redirect('/');
      }
    });
  };

module.exports = {
    signup,
    login,
    dangky,
    dangnhap,
    logout
};