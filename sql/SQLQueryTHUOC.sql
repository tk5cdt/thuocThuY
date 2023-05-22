--tạo database
CREATE DATABASE QL_NHATHUOCTY
GO

--DROP DATABASE QL_NHATHUOCTY

--sử dụng database
USE QL_NHATHUOCTY
GO

--mặc định kiểu ngày tháng
SET DATEFORMAT DMY
---------------------------------------------TẠO CÁC BẢNG-----------------------------------------------

--tạo bảng thuốc
CREATE TABLE THUOC
(
      MATHUOC VARCHAR(10) NOT NULL,
      TENTHUOC NVARCHAR(30),
      MANHOM VARCHAR(5),
      LOAISD NVARCHAR(10),
      THANHPHAN NVARCHAR(40) DEFAULT NULL,
      MANCC VARCHAR(10) NOT NULL,
      GIASI MONEY DEFAULT 0,
      GIALE MONEY DEFAULT 0,
      GIANHAP MONEY DEFAULT 0,
      DANGBAOCHE NVARCHAR(20),
      QCDONGGOI VARCHAR(10) NOT NULL,
      CONGDUNG NVARCHAR(100),
      PRIMARY KEY(MATHUOC)
)

--tạo bảng nhóm thuốc
CREATE TABLE NHOMTHUOC
(
      MANHOM VARCHAR(5) NOT NULL,
      TENNHOM NVARCHAR(20),
      SOLUONG INT DEFAULT 0,
      PRIMARY KEY(MANHOM)
)


--tạo bảng nhà cung cấp
CREATE TABLE NHACUNGCAP
(
      MANCC VARCHAR(10) NOT NULL,
      TENNCC NVARCHAR(50),
      DIACHI NVARCHAR(80) DEFAULT NULL,
      DIENTHOAI NCHAR(11) UNIQUE,
      CONGNO MONEY DEFAULT 0,
      PRIMARY KEY(MANCC)
)

--tạo bảng nhân viên
CREATE TABLE NHANVIEN
(
      MANV VARCHAR(10) NOT NULL,
      TENNV NVARCHAR(50),
      NGAYSINH DATE,
      VANBANG NVARCHAR(30) DEFAULT NULL,
      DIACHI NVARCHAR(80),
      PHAI NVARCHAR(3),
      VITRI NVARCHAR(15),
      BOPHAN NVARCHAR(15),
      PRIMARY KEY(MANV)
)

--tạo bảng khách hàng
CREATE TABLE KHACHHANG
(
      MAKH VARCHAR(10) NOT NULL,
      TENKHACH NVARCHAR(30),
      DIACHI NVARCHAR(80) DEFAULT NULL,
      DIENTHOAI NCHAR(11) UNIQUE,
      LOAIKH NVARCHAR(15),
      CONGNO MONEY DEFAULT 0,
      PRIMARY KEY(MAKH)
)

--tạo bảng đơn hàng xuất
CREATE TABLE DONHANGXUAT
(
      MADONHANG VARCHAR(10) NOT NULL DEFAULT 'DX000',
      MAKH VARCHAR(10) NOT NULL,
      MANV VARCHAR(10) NOT NULL,
      TRANGTHAIDH  NVARCHAR(30) DEFAULT N'Đang chuẩn bị', --đang chuẩn bị, đã hủy, đang vận chuyển, đã giao, giao không thành công
      NGAYLAP DATE NOT NULL,
      TONGTIEN MONEY DEFAULT 0,
      DATHANHTOAN MONEY DEFAULT 0,
      CONGNO MONEY DEFAULT 0,
      PRIMARY KEY(MADONHANG)
)

--tạo bảng đơn hàng nhập
CREATE TABLE DONHANGNHAP
(
      MADONHANG VARCHAR(10) NOT NULL DEFAULT 'DN000',
      MANCC VARCHAR(10) NOT NULL,
      MANV VARCHAR(10) NOT NULL,
      TRANGTHAIDH  NVARCHAR(30) DEFAULT N'Đang lập đơn', --đang lập đơn, đã đặt, đã hủy, đã nhận, nhận không thành công
      NGAYLAP DATE,
      TONGTIEN MONEY DEFAULT 0,
      DATHANHTOAN MONEY DEFAULT 0,
      CONGNO MONEY DEFAULT 0,
      PRIMARY KEY(MADONHANG)
)

--tạo bảng nhập thuốc
CREATE TABLE NHAPTHUOC
(
      MADONHANG VARCHAR(10) NOT NULL,
      THUOC VARCHAR(10) NOT NULL,
      SOLUONG INT DEFAULT 1,
      DONVITINH NVARCHAR(20),
      THANHTIEN MONEY,
      NGAYSX DATE,
      NGAYHETHAN DATE,
      PRIMARY KEY(MADONHANG, THUOC)
)

--tạo bảng xuất thuốc
CREATE TABLE XUATTHUOC
(
      MADONHANG VARCHAR(10) NOT NULL,
      THUOC VARCHAR(10) NOT NULL,
      SOLUONG INT DEFAULT 1,
      DONVITINH NVARCHAR(20),
      THANHTIEN MONEY
      PRIMARY KEY(MADONHANG, THUOC)
)

--tạo bảng kho hàng
CREATE TABLE KHOHANG
(
      MATHUOC VARCHAR(10) NOT NULL,
      DONNHAP VARCHAR(10),
      TONKHO INT DEFAULT 0,
      NGAYHETHAN DATE,
      PRIMARY KEY(MATHUOC, DONNHAP, TONKHO)
)

--tạo bảng người dùng
CREATE TABLE TAIKHOAN
(
      USERNAME VARCHAR(20) NOT NULL,
      MATKHAU VARCHAR(61),
      EMAIL VARCHAR(50),
      QUANTRI BIT,
      PRIMARY KEY(USERNAME)
)

--tạo bảng giỏ hàng
CREATE TABLE GIOHANG
(
      USERNAME VARCHAR(20) NOT NULL,
      MATHUOC VARCHAR(10) NOT NULL,
      SOLUONG INT,
      DONVITINH NVARCHAR(20),
      THANHTIEN MONEY,
      PRIMARY KEY(USERNAME, MATHUOC)
)
--tạo bảng đơn hàng oline
CREATE TABLE DONHANGONLINE
(
      MADONHANG VARCHAR(10) NOT NULL DEFAULT 'DHO000',
      USERNAME VARCHAR(20) NOT NULL,
      DIENTHOAI NCHAR(11) NOT NULL,
      DIACHI NVARCHAR(80) NOT NULL,
      TRANGTHAIDH NVARCHAR(30) DEFAULT N'Đang lập đơn', --đang lập đơn, đã đặt, đang chuẩn bị, đang vận chuyển, đã giao, giao không thành công
      TONGTIEN MONEY DEFAULT 0,
      PRIMARY KEY(MADONHANG)
)

--tạo bảng xuất thuốc
CREATE TABLE DONXUATONLINECHITIET
(
      MADONHANG VARCHAR(10) NOT NULL,
      THUOC VARCHAR(10) NOT NULL,
      SOLUONG INT DEFAULT 1,
      DONVITINH NVARCHAR(20),
      THANHTIEN MONEY
      PRIMARY KEY(MADONHANG, THUOC)
)

-- tạo table lưu ảnh chính
CREATE TABLE PROFILEPICTURE
(
      MATHUOC VARCHAR(10) NOT NULL,
      TENANH NVARCHAR(100) UNIQUE,
      PRIMARY KEY(MATHUOC, TENANH)
)

-- tạo table lưu album
CREATE TABLE ALBUMPICTURES
(
      MATHUOC VARCHAR(10) NOT NULL,
      TENALBUM NVARCHAR(100),
      PRIMARY KEY(MATHUOC, TENALBUM)
)


---------------------------------------------TẠO RÀNG BUỘC KHÓA NGOẠI-----------------------------------------------

--tạo khóa ngoại bảng thuốc và nhóm thuốc
ALTER TABLE THUOC
ADD CONSTRAINT FK_THUOC_NHOMTHUOC FOREIGN KEY(MANHOM)
REFERENCES NHOMTHUOC(MANHOM)
GO

--tạo khóa ngoại bảng thuốc và nhà cung cấp
ALTER TABLE THUOC
ADD CONSTRAINT FK_THUOC_NHACC FOREIGN KEY(MANCC)
REFERENCES NHACUNGCAP(MANCC)
GO

--tạo khóa ngoại bảng đơn hàng xuất và khách hàng
ALTER TABLE DONHANGXUAT
ADD CONSTRAINT FK_DONHANGXUAT_KHACHHANG FOREIGN KEY(MAKH)
REFERENCES KHACHHANG(MAKH)
GO

--tạo khóa ngoại bảng đơn hàng xuất và nhân viên
ALTER TABLE DONHANGXUAT
ADD CONSTRAINT FK_DONHANGXUAT_NHANVIEN FOREIGN KEY(MANV)
REFERENCES NHANVIEN(MANV)
GO

--tạo khóa ngoại bảng đơn hàng nhập và nhà cung cấp
ALTER TABLE DONHANGNHAP
ADD CONSTRAINT FK_DONHANGNHAP_NHACUNGCAP FOREIGN KEY(MANCC)
REFERENCES NHACUNGCAP(MANCC)
GO

--tạo khóa ngoại bảng đơn hàng nhập và nhân viên
ALTER TABLE DONHANGNHAP
ADD CONSTRAINT FK_DONHANGNHAP_NHANVIEN FOREIGN KEY(MANV)
REFERENCES NHANVIEN(MANV)
GO

--tạo khóa ngoại bảng kho hàng và thuốc
ALTER TABLE KHOHANG
ADD CONSTRAINT FK_KHOHANG_NHAPTHUOC FOREIGN KEY(DONNHAP, MATHUOC)
REFERENCES NHAPTHUOC(MADONHANG, THUOC)
GO

--tạo khóa ngoại bảng xuất thuốc và đơn hàng xuất
ALTER TABLE XUATTHUOC
ADD CONSTRAINT FK_XUATTHUOC_DONHANGXUAT FOREIGN KEY(MADONHANG)
REFERENCES DONHANGXUAT(MADONHANG)
GO

--tạo khóa ngoại bảng nhập thuốc và đơn hàng nhập
ALTER TABLE NHAPTHUOC
ADD CONSTRAINT FK_NHAPTHUOC_DONHANGNHAP FOREIGN KEY(MADONHANG)
REFERENCES DONHANGNHAP(MADONHANG)
GO

--tạo khóa ngoại bảng xuất thuốc và thuốc
ALTER TABLE XUATTHUOC
ADD CONSTRAINT FK_XUATTHUOC_THUOC FOREIGN KEY(THUOC)
REFERENCES THUOC(MATHUOC)
GO

--tạo khóa ngoại bảng nhập thuốc và thuốc
ALTER TABLE NHAPTHUOC
ADD CONSTRAINT FK_NHAPTHUOC_THUOC FOREIGN KEY(THUOC)
REFERENCES THUOC(MATHUOC)
GO

--tạo khóa ngoại bảng giỏ hàng và user
ALTER TABLE GIOHANG
ADD CONSTRAINT FK_GIOHANG_USER FOREIGN KEY(USERNAME)
REFERENCES TAIKHOAN(USERNAME)
GO

--tạo khóa ngoại bảng giỏ hàng và thuốc
ALTER TABLE GIOHANG
ADD CONSTRAINT FK_GIOHANG_THUOC FOREIGN KEY(MATHUOC)
REFERENCES THUOC(MATHUOC)
GO

--tạo khóa ngoại cho bảng đơn hàng online và user
ALTER TABLE DONHANGONLINE
ADD CONSTRAINT FK_DONHANGONLINE_TAIKHOAN FOREIGN KEY(USERNAME)
REFERENCES TAIKHOAN(USERNAME)
GO

--tạo khóa ngoại cho đơn xuất online chi tiết và đơn hàng online
ALTER TABLE DONXUATONLINECHITIET
ADD CONSTRAINT FK_DXOLCT_DONHANGONLINE FOREIGN KEY(MADONHANG)
REFERENCES DONHANGONLINE(MADONHANG)
GO

--tạo khóa ngoại cho đơn xuất online chi tiết và thuốc
ALTER TABLE DONXUATONLINECHITIET
ADD CONSTRAINT FK_DXOLCT_THUOC FOREIGN KEY(THUOC)
REFERENCES THUOC(MATHUOC)
GO

-- tạo khóa ngoại bảng profile picture và thuốc
ALTER TABLE PROFILEPICTURE
ADD CONSTRAINT FK_PROFILEPICTURE_THUOC FOREIGN KEY(MATHUOC)
REFERENCES THUOC(MATHUOC)
GO

-- tạo khóa ngoại bảng album picture và thuốc
ALTER TABLE ALBUMPICTURES
ADD CONSTRAINT FK_ALBUMPICTURES_THUOC FOREIGN KEY(MATHUOC)
REFERENCES THUOC(MATHUOC)
GO

---------------------------------------------TẠO RÀNG BUỘC CHECK-----------------------------------------------

--tạo điều kiện ngày hết hạn của kho hàng
ALTER TABLE NHAPTHUOC
ADD CONSTRAINT CK_NGAYHETHAN CHECK (NGAYHETHAN > NGAYSX)

--tạo điều kiện số lượng của bảng xuất thuốc
ALTER TABLE XUATTHUOC
ADD CONSTRAINT CK_XUATTHUOC_SOLUONG CHECK( SOLUONG > 0)

--tạo điều kiện số lượng của bảng nhập thuốc
ALTER TABLE NHAPTHUOC
ADD CONSTRAINT CK_NHAPTHUOC_SOLUONG CHECK( SOLUONG > 0)

--tạo điều kiện đã thanh toán của bảng đơn hàng nhập
ALTER TABLE DONHANGNHAP
ADD CONSTRAINT CK_DATHANHTOAN_NHAP CHECK (DATHANHTOAN >= 0)

--tạo điều kiện đã thanh toán của bảng đơn hàng xuất    
ALTER TABLE DONHANGXUAT
ADD CONSTRAINT CK_DATHANHTOAN_XUAT CHECK (DATHANHTOAN >= 0)

--tạo điều kiện cho bảng khách hàng
ALTER TABLE KHACHHANG
ADD CONSTRAINT CK_KHACHHANG_LOAIKH CHECK (LOAIKH = N'Khách lẻ' OR LOAIKH = N'Khách sỉ')

--tạo điều kiện cho bảng nhân viên
ALTER TABLE NHANVIEN 
ADD CONSTRAINT CK_NHANVIEN_PHAI CHECK (PHAI = N'Nam' OR PHAI = N'Nữ')
GO

--tạo điều kiện số lượng của bảng nhập thuốc
ALTER TABLE GIOHANG
ADD CONSTRAINT CK_GIOHANG_SOLUONG CHECK( SOLUONG > 0)
GO

--trạng thái của đơn hàng nhập chỉ bao gồm (đang chuẩn bị, đã hủy, đang vận chuyển, đã nhận, giao không thành công)
ALTER TABLE DONHANGNHAP
ADD CONSTRAINT CK_DONHANGNHAP_TTDH CHECK(TRANGTHAIDH = N'Đang chuẩn bị' OR TRANGTHAIDH = N'Đã hủy' OR TRANGTHAIDH = N'Đang vận chuyển' OR TRANGTHAIDH = N'Đã nhận' OR TRANGTHAIDH = N'Giao không thành công')
GO

--trạng thái của đơn hàng xuất chỉ bao gồm (đang chuẩn bị, đã hủy, đang vận chuyển, đã giao, giao không thành công)
ALTER TABLE DONHANGXUAT
ADD CONSTRAINT CK_DONHANGXUAT_TTDH CHECK(TRANGTHAIDH = N'Đang chuẩn bị' OR TRANGTHAIDH = N'Đã hủy' OR TRANGTHAIDH = N'Đang vận chuyển' OR TRANGTHAIDH = N'Đã giao' OR TRANGTHAIDH = N'Giao không thành công')
GO

--trạng thái của đơn hàng nhập chỉ bao gồm (đang lập đơn, đã đặt, đã hủy, đang vận chuyển, đã giao, giao không thành công)
ALTER TABLE DONHANGONLINE
ADD CONSTRAINT CK_DONHANGONLINE_TTDH CHECK(TRANGTHAIDH = N'Đang lập đơn' OR TRANGTHAIDH = N'Đã đặt' OR TRANGTHAIDH = N'Đã hủy' OR TRANGTHAIDH = N'Đang vận chuyển' OR TRANGTHAIDH = N'Đã giao' OR TRANGTHAIDH = N'Giao không thành công')
GO


-----------------------------------------------TẠO CÁC PROCEDURE-----------------------------------------

--tìm mã đơn hàng nhập tiếp theo
CREATE PROC usp_TimMaDonHangNhapTiepTheo
      @madonhang VARCHAR(10) OUT
AS
BEGIN
      SET @madonhang = 'DN001'

      DECLARE @index INT

      SET @index = 1

      WHILE EXISTS(SELECT MADONHANG FROM DONHANGNHAP WHERE MADONHANG = @madonhang)
      BEGIN
            SET @index = @index + 1
            SET @madonhang = 'DN' + REPLICATE('0',3 - LEN(CAST(@index AS VARCHAR))) + CAST(@index AS VARCHAR)
      END
END
GO

--tìm mã đơn hàng xuất tiếp theo
CREATE PROC usp_TimMaDonHangXuatTiepTheo
      @madonhang VARCHAR(10) OUT
AS
BEGIN
      SET @madonhang = 'DX001'

      DECLARE @index INT

      SET @index = 1

      WHILE EXISTS(SELECT MADONHANG FROM DONHANGXUAT WHERE MADONHANG = @madonhang)
      BEGIN
            SET @index = @index + 1
            SET @madonhang = 'DX' + REPLICATE('0',3 - LEN(CAST(@index AS VARCHAR))) + CAST(@index AS VARCHAR)
      END
END
GO

--tìm mã đơn hàng Online tiếp theo
CREATE PROC usp_TimMaDonHangOnlineTiepTheo
      @madonhang VARCHAR(10) OUT
AS
BEGIN
      SET @madonhang = 'DHO001'

      DECLARE @index INT

      SET @index = 1

      WHILE EXISTS(SELECT MADONHANG FROM DONHANGONLINE WHERE MADONHANG = @madonhang)
      BEGIN
            SET @index = @index + 1
            SET @madonhang = 'DHO' + REPLICATE('0',3 - LEN(CAST(@index AS VARCHAR))) + CAST(@index AS VARCHAR)
      END
END
GO

--cài đặt hiển thị giỏ hàng của user
CREATE PROC usp_GioHangCuaUser
      @username VARCHAR(20)
AS 
      SELECT *
      FROM GIOHANG
      WHERE @username = USERNAME
GO

--cài đặt hóa đơn xuất chi tiết
CREATE PROC usp_DonXuatChiTiet
      @Madonhang VARCHAR(10)
AS 
      SELECT TENTHUOC, SOLUONG, DONVITINH, THANHTIEN FROM DONHANGXUAT D JOIN XUATTHUOC X
      ON D.MADONHANG = X.MADONHANG
      JOIN THUOC
      ON X.THUOC = THUOC.MATHUOC
      AND D.MADONHANG = @madonhang
GO

--cài đặt hóa đơn nhập chi tiết
CREATE PROC usp_DonNhapChiTiet
      @Madonhang VARCHAR(10)
AS 
      SELECT TENTHUOC, SOLUONG, DONVITINH, THANHTIEN FROM DONHANGNHAP D JOIN NHAPTHUOC N
      ON D.MADONHANG = N.MADONHANG
      JOIN THUOC
      ON N.THUOC = THUOC.MATHUOC
      AND D.MADONHANG = @madonhang
GO

--cài đặt hóa đơn online chi tiết
CREATE PROC usp_DonOnlineChiTiet
      @Madonhang VARCHAR(10)
AS 
      SELECT TENTHUOC, SOLUONG, DONVITINH, THANHTIEN FROM DONHANGONLINE D JOIN DONXUATONLINECHITIET DCT
      ON D.MADONHANG = DCT.MADONHANG
      JOIN THUOC
      ON DCT.THUOC = THUOC.MATHUOC
      AND D.MADONHANG = @madonhang
GO

--thanh toán công nợ cho một đơn hàng nhập
CREATE PROC usp_ThanhToanCongNoDHN
      @madh VARCHAR(6)
AS
BEGIN
      IF(SELECT CONGNO FROM DONHANGNHAP WHERE MADONHANG = @madh) = 0
      BEGIN
            PRINT N'ĐƠN HÀNG ĐÃ ĐƯỢC THANH TOÁN'
      END
      ELSE
      BEGIN
            UPDATE DONHANGNHAP
            SET DATHANHTOAN = TONGTIEN
            WHERE DONHANGNHAP.MADONHANG = @madh

            PRINT N'CÔNG NỢ CỦA ĐƠN HÀNG ĐÃ ĐƯỢC THANH TOÁN THÀNH CÔNG'
      END
END
GO

      --thanh toán công nợ cho một đơn hàng xuất
CREATE PROC usp_ThanhToanCongNoDHX
      @madh VARCHAR(6)
AS
BEGIN
      IF(SELECT CONGNO FROM DONHANGXUAT WHERE MADONHANG = @madh) = 0
      BEGIN
            PRINT N'ĐƠN HÀNG ĐÃ ĐƯỢC THANH TOÁN'
      END
      ELSE
      BEGIN
            UPDATE DONHANGXUAT
            SET DATHANHTOAN = TONGTIEN
            WHERE DONHANGXUAT.MADONHANG = @madh

            PRINT N'CÔNG NỢ CỦA ĐƠN HÀNG ĐÃ ĐƯỢC THANH TOÁN THÀNH CÔNG'
      END
END
GO

--trả tiền cho nhà cung cấp
CREATE PROC usp_TraNoNhaCungCap
      @mancc VARCHAR(10)
AS
BEGIN
      UPDATE DONHANGNHAP
      SET DATHANHTOAN = TONGTIEN
      WHERE DONHANGNHAP.MANCC = @mancc
      AND CONGNO != 0
      PRINT N'CÔNG NỢ ĐÃ ĐƯỢC THANH TOÁN THÀNH CÔNG CHO NHÀ CUNG CẤP'
END
GO

--lược sử giao dịch với khách hàng
CREATE PROC usp_LuocSuGiaoDichKH
      @makh VARCHAR(10)
AS 
      SELECT K.TENKHACH, K.LOAIKH, D.MADONHANG, D.NGAYLAP, D.TRANGTHAIDH, D.TONGTIEN, D.DATHANHTOAN, D.CONGNO FROM KHACHHANG K JOIN DONHANGXUAT D
      ON K.MAKH = D.MAKH
      AND K.MAKH = @makh
GO

--Báo cáo lược sử giao dịch với nhà cung cấp
CREATE PROC usp_LuocSuGiaoDichNCC
      @mancc VARCHAR(10)
AS 
      SELECT N.TENNCC, D.MADONHANG, D.NGAYLAP, D.TRANGTHAIDH, D.TONGTIEN, D.DATHANHTOAN, D.CONGNO FROM NHACUNGCAP N JOIN DONHANGNHAP D 
      ON N.MANCC = D.MANCC
      AND N.MANCC = @mancc
GO

---------------------------------------------TẠO TRIGGER-----------------------------------------------

-- tạo trigger khi thêm dữ liệu vào bảng THUOC
CREATE TRIGGER TRG_INSERT_THUOC
      ON THUOC
      AFTER INSERT
AS
BEGIN
      --cập nhật dữ liệu cho thuộc tính giá sỉ và giá lẻ cho thuốc vừa nhập
      UPDATE THUOC
      SET GIASI = inserted.GIANHAP + inserted.GIANHAP * 7/100,
      GIALE = inserted.GIANHAP + inserted.GIANHAP * 10/100
      FROM THUOC JOIN inserted
      ON THUOC.MATHUOC = inserted.MATHUOC
END
GO

-- tạo trigger khi xóa dữ liệu từ bảng THUOC
CREATE TRIGGER TRG_DELETE_THUOC
      ON THUOC
      INSTEAD OF DELETE
AS
BEGIN
      --khi thuốc bị xóa thì hình ảnh của thuốc đó cũng bị xóa theo
      IF EXISTS (SELECT MATHUOC FROM deleted WHERE MATHUOC IN (SELECT MATHUOC FROM ALBUMPICTURES))
      BEGIN
            PRINT N'DỮ LIỆU HÌNH ẢNH CỦA THUỐC SẼ ĐƯỢC XÓA'
            DELETE ALBUMPICTURES
            WHERE MATHUOC = (SELECT MATHUOC FROM deleted)
      END

      IF EXISTS (SELECT MATHUOC FROM deleted WHERE MATHUOC IN (SELECT MATHUOC FROM PROFILEPICTURE))
      BEGIN
            PRINT N'DỮ LIỆU HÌNH ẢNH CỦA THUỐC SẼ ĐƯỢC XÓA'
            DELETE PROFILEPICTURE
            WHERE MATHUOC = (SELECT MATHUOC FROM deleted)
      END

      DELETE THUOC 
      WHERE MATHUOC = (SELECT MATHUOC FROM deleted)
END
GO

--tạo trigger khi thêm dữ liệu vào bảng NHOMTHUOC
CREATE TRIGGER TRG_INSERT_NHOMTHUOC
      ON NHOMTHUOC
      FOR INSERT
AS
BEGIN
      --reset giá trị số lượng bằng 0 khi người dùng nhập dữ liệu khác
      IF (SELECT SOLUONG FROM inserted) != 0
      BEGIN
            PRINT N'SỐ LƯỢNG THUỐC CỦA NHÓM TRONG KHO HÀNG SẼ ĐƯỢC TỰ ĐỘNG CẬP NHẬT TRONG QUÁ TRÌNH NHẬP XUẤT THUỐC'
            PRINT N'RESET SỐ LƯỢNG = 0'
            UPDATE NHOMTHUOC
            SET SOLUONG = 0
            FROM inserted
            WHERE NHOMTHUOC.MANHOM = inserted.MANHOM
      END
END
GO

--tạo trigger khi them dữ liệu vào bảng NHACUNGCAP
CREATE TRIGGER TRG_INSERT_NCC
      ON NHACUNGCAP
      FOR INSERT
AS
BEGIN
      --reset giá trị công nợ bằng 0 khi người dùng nhập dữ liệu khác
      IF (SELECT CONGNO FROM inserted) != 0
      BEGIN
            PRINT N'CÔNG NỢ SẼ ĐƯỢC TỰ ĐỘNG CẬP NHẬT THEO ĐƠN HÀNG NHẬP'
            PRINT N'RESET CÔNG NỢ = 0'
            UPDATE NHACUNGCAP
            SET CONGNO = 0
            FROM inserted
            WHERE NHACUNGCAP.MANCC = inserted.MANCC
      END
END
GO

CREATE TRIGGER TRG_UPDATE_NCC
      ON NHACUNGCAP
      FOR UPDATE
AS
BEGIN
      --kiểm tra người dùng nhập vào giá trị công nợ không đúng
      IF EXISTS (
            SELECT * FROM inserted JOIN deleted
            ON inserted.CONGNO != deleted.CONGNO
            AND inserted.CONGNO != (
                  SELECT SUM(CONGNO) FROM DONHANGNHAP D
                  WHERE D.MANCC = inserted.MANCC
            )
      )
      BEGIN
            PRINT N'CÔNG NỢ CỦA NHÀ CUNG CẤP SẼ ĐƯỢC THAY ĐỔI THEO CÔNG NỢ CỦA ĐƠN HÀNG NHẬP'
            ROLLBACK TRAN
      END
END
GO

--tạo trigger khi thêm dữ liệu vào bảng KHACHHANG
CREATE TRIGGER TRG_INSERT_KHACHHANG
      ON KHACHHANG
      FOR INSERT
AS
BEGIN
      --reset giá trị công nợ bằng 0 khi người dùng nhập dữ liệu khác
      IF (SELECT CONGNO FROM inserted) != 0
      BEGIN
            PRINT N'CÔNG NỢ SẼ ĐƯỢC TỰ ĐỘNG CẬP NHẬT THEO ĐƠN HÀNG XUẤT'
            PRINT N'RESET CÔNG NỢ = 0'
            UPDATE KHACHHANG
            SET CONGNO = 0
            FROM inserted
            WHERE KHACHHANG.MAKH = inserted.MAKH
      END
END
GO

CREATE TRIGGER TRG_UPDATE_KHACHHANG
      ON KHACHHANG
      FOR UPDATE
AS
BEGIN
      --kiểm tr khi người dùng nhập vào giá trị công nợ khác
      IF EXISTS (
            SELECT * FROM inserted JOIN deleted
            ON inserted.CONGNO != deleted.CONGNO
            AND inserted.CONGNO != (
                  SELECT SUM(CONGNO) FROM DONHANGXUAT K
                  WHERE K.MAKH = inserted.MAKH
            )
      )
      BEGIN
            PRINT N'CÔNG NỢ CỦA KHÁCH HÀNG SẼ ĐƯỢC THAY ĐỔI THEO CÔNG NỢ CỦA ĐƠN HÀNG XUẤT'
            ROLLBACK TRAN
      END
END
GO

--tạo trigger khi thêm dữ liệu vào bảng DONHANGXUAT
CREATE TRIGGER TRG_INSERT_DONHANGXUAT
      ON DONHANGXUAT
      FOR INSERT
AS
BEGIN
      --set mã đơn hàng tự động
      PRINT N'MÃ ĐƠN HÀNG SẼ ĐƯỢC SET TỰ ĐỘNG'

      DECLARE @result VARCHAR(10) 
      EXEC usp_TimMaDonHangXuatTiepTheo @result OUT

      UPDATE DONHANGXUAT
      SET MADONHANG = @result
      FROM DONHANGXUAT JOIN inserted
      ON DONHANGXUAT.MADONHANG = inserted.MADONHANG

      --phải do nhân viên bán hàng hoặc nhân viên quản lý chịu trách nhiệm lập đơn
      IF((SELECT MANV FROM inserted) NOT IN (SELECT MANV FROM NHANVIEN WHERE BOPHAN = N'Quản lý' OR BOPHAN = N'Bán hàng'))
      BEGIN
            PRINT N'DƠN HÀNG PHẢI DO NHÂN VIÊN BỘ PHẬN BÁN HÀNG HOẶC QUẢN LÝ LẬP!'
            ROLLBACK TRAN
      END

      --reset giá trị tổng tiền về 0 khi người dùng nhập giá trị khác
      IF(SELECT TONGTIEN FROM inserted) !=0
      BEGIN
            PRINT N'TỔNG TIỀN SẼ ĐƯỢC HỆ THỐNG TỰ ĐỘNG CẬP NHẬT THEO ĐƠN HÀNG'
            PRINT N'RESET TỔNG TIỀN'
            UPDATE DONHANGXUAT
            SET TONGTIEN = 0
            FROM inserted
            WHERE DONHANGXUAT.MADONHANG = inserted.MADONHANG
      END

      --reset giá trị công nợ về 0 khi người dùng nhập giá trị khác
      IF(SELECT CONGNO FROM inserted) != 0
      BEGIN
            PRINT N'CÔNG NỢ SẼ ĐƯỢC HỆ THỐNG TỰ ĐỘNG CẬP NHẬT'
            PRINT N'RESET CÔNG NỢ'
            UPDATE DONHANGXUAT
            SET CONGNO = 0
            FROM inserted
            WHERE DONHANGXUAT.MADONHANG = inserted.MADONHANG
      END
END
GO

-- tạo trigger khi thay đổi dữ liệu trong bảng DONHANGXUAT
CREATE TRIGGER TRG_UPDATE_DONHANGXUAT
      ON  DONHANGXUAT
      FOR UPDATE
AS
BEGIN
      --chỉ được hủy đơn hàng khi đơn hàng đang trong trạng thái đang chuẩn bị
      IF ((SELECT TRANGTHAIDH FROM deleted) != N'Đang chuẩn bị' AND (SELECT TRANGTHAIDH FROM inserted) = N'Đã hủy')
      BEGIN
            PRINT N'KHÔNG THỂ HỦY ĐƠN HÀNG'
            ROLLBACK TRAN
      END

      IF EXISTS (
            SELECT inserted.TRANGTHAIDH FROM deleted JOIN inserted 
            ON (deleted.TRANGTHAIDH = N'Đã hủy' AND inserted.TRANGTHAIDH != N'Đã hủy') 
            OR (deleted.TRANGTHAIDH = N'Giao không thành công' AND inserted.TRANGTHAIDH != N'Giao không thành công'))
      BEGIN
            PRINT N'TRẠNG THÁI ĐƠN HÀNG KHÔNG THỂ THAY ĐỔI'
            ROLLBACK TRAN
      END

      -- thông báo khi đơn hàng bị hủy hoặc giao hàng không thành công
      IF ((SELECT TRANGTHAIDH FROM deleted) = N'Đang chuẩn bị' AND (SELECT TRANGTHAIDH FROM inserted) = N'Đã hủy') OR (SELECT TRANGTHAIDH FROM inserted) = N'Giao không thành công'
      BEGIN
            PRINT N'ĐƠN HÀNG ĐÃ NẰM TRONG TRẠNG THÁI KHÔNG THỂ UPDATE'
      END

      ELSE
      BEGIN
            --cập nhật công nợ cho đơn hàng vừa thay đổi
            UPDATE DONHANGXUAT
            SET CONGNO = inserted.TONGTIEN - inserted.DATHANHTOAN
            FROM DONHANGXUAT JOIN inserted
            ON inserted.TRANGTHAIDH = N'Đã giao'
            AND inserted.MADONHANG = DONHANGXUAT.MADONHANG

            --cập nhật công nợ của khách hàng với cửa hàng
            UPDATE KHACHHANG
            SET CONGNO = (
                  SELECT SUM(CONGNO)
                  FROM DONHANGXUAT
                  WHERE KHACHHANG.MAKH = DONHANGXUAT.MAKH
            )
      END
END
GO

CREATE TRIGGER TRG_DELETE_DONHANGXUAT
      ON DONHANGXUAT
      FOR DELETE
AS
BEGIN
      --không thể xóa đơn hàng, chỉ có thể thay đổi trạng thái bằng đã hủy hoặc giao không thành công
      PRINT N'ĐƠN HÀNG ĐÃ ĐƯỢC LƯU VÀO HỆ THỐNG, KHÔNG THỂ XÓA!'
      ROLLBACK TRAN
END
GO

--tạo trigger khi thêm dữ liệu vào bảng DONHANGNHAP
CREATE TRIGGER TRG_INSERT_DONHANGNHAP
      ON DONHANGNHAP
      FOR INSERT
AS
BEGIN
      --set mã đơn hàng tự động
      PRINT N'MÃ ĐƠN HÀNG SẼ ĐƯỢC SET TỰ ĐỘNG'

      DECLARE @result VARCHAR(10) 
      EXEC usp_TimMaDonHangNhapTiepTheo @result OUT

      UPDATE DONHANGNHAP
      SET MADONHANG = @result
      FROM DONHANGNHAP JOIN inserted
      ON DONHANGNHAP.MADONHANG = inserted.MADONHANG

      --phải do nhân viên bán hàng hoặc nhân viên quản lý chịu trách nhiệm lập đơn
      IF(SELECT MANV FROM inserted) NOT IN (SELECT MANV FROM NHANVIEN WHERE BOPHAN = N'Quản lý' OR BOPHAN = N'Kho')
      BEGIN
            PRINT N'DƠN HÀNG PHẢI DO NHÂN VIÊN BỘ PHẬN KHO HOẶC QUẢN LÝ LẬP!'
            ROLLBACK TRAN
      END

      --reset giá trị tổng tiền về 0 khi người dùng nhập giá trị khác
      IF(SELECT TONGTIEN FROM inserted) !=0
      BEGIN
            PRINT N'TỔNG TIỀN SẼ ĐƯỢC HỆ THỐNG TỰ ĐỘNG CẬP NHẬT THEO ĐƠN HÀNG'
            PRINT N'RESET TỔNG TIỀN'
            UPDATE DONHANGNHAP
            SET TONGTIEN = 0
            FROM inserted
            WHERE DONHANGNHAP.MADONHANG = inserted.MADONHANG
      END

      --reset giá trị công nợ về 0 khi người dùng nhập giá trị khác
      IF(SELECT CONGNO FROM inserted) != 0
      BEGIN
            PRINT N'CÔNG NỢ SẼ ĐƯỢC HỆ THỐNG TỰ ĐỘNG CẬP NHẬT'
            PRINT N'RESET CÔNG NỢ'
            UPDATE DONHANGNHAP
            SET CONGNO = 0
            FROM inserted
            WHERE DONHANGNHAP.MADONHANG = inserted.MADONHANG
      END
END
GO

-- tạo trigger khi thay đổi dữ liệu trong bảng DONHANGNHAP
CREATE TRIGGER TRG_UPDATE_DONHANGNHAP
      ON  DONHANGNHAP 
      AFTER UPDATE
AS
BEGIN
      --đơn hàng chỉ được hủy khi đang trong trạng thái đang chuẩn bị
      IF ((SELECT TRANGTHAIDH FROM deleted) != N'Đang chuẩn bị' AND (SELECT TRANGTHAIDH FROM inserted) = N'Đã hủy')
      BEGIN
            PRINT N'KHÔNG THỂ HỦY ĐƠN HÀNG'
            ROLLBACK TRAN
      END

      IF EXISTS (
            SELECT inserted.TRANGTHAIDH FROM deleted JOIN inserted 
            ON (deleted.TRANGTHAIDH = N'Đã hủy' AND inserted.TRANGTHAIDH != N'Đã hủy') 
            OR (deleted.TRANGTHAIDH = N'Giao không thành công' AND inserted.TRANGTHAIDH != N'Giao không thành công'))
      BEGIN
            PRINT N'TRẠNG THÁI ĐƠN HÀNG KHÔNG THỂ THAY ĐỔI'
            ROLLBACK TRAN
      END

      -- thông báo khi hủy đơn hàng hoặc giao hàng không thành công
      IF ((SELECT TRANGTHAIDH FROM deleted) = N'Đang chuẩn bị' AND (SELECT TRANGTHAIDH FROM inserted) = N'Đã hủy') OR (SELECT TRANGTHAIDH FROM inserted) = N'Giao không thành công'
      BEGIN
            PRINT N'ĐƠN HÀNG ĐÃ ĐƯỢC HỦY'
      END

      ELSE
      BEGIN
            --cập nhật công nợ của đơn hàng vừa thêm khi đơn hàng đã nhận thành công
            UPDATE DONHANGNHAP
            SET CONGNO = inserted.TONGTIEN - inserted.DATHANHTOAN
            FROM DONHANGNHAP JOIN inserted
            ON inserted.TRANGTHAIDH = N'Đã nhận'
            AND inserted.MADONHANG = DONHANGNHAP.MADONHANG

            --cập nhật công nợ của nhà cung cấp với cửa hàng
            UPDATE NHACUNGCAP
            SET CONGNO = (
                  SELECT SUM(CONGNO)
                  FROM DONHANGNHAP
                  WHERE NHACUNGCAP.MANCC = DONHANGNHAP.MANCC
            )
      END
END
GO

CREATE TRIGGER TRG_DELETE_DONHANGNHAP
      ON DONHANGNHAP
      FOR DELETE
AS
BEGIN
      --đơn hàng không thể xóa, chỉ có thể thay đổi trạng thái thành đã hủy hoặc giao hàng không thành công
      PRINT N'KHÔNG THỂ XÓA ĐƠN HÀNG'
      ROLLBACK TRAN
END
GO

--tạo trigger khi thêm dữ liệu cho bảng NHAPTHUOC
CREATE TRIGGER TRG_INSERT_NHAPTHUOC
      ON NHAPTHUOC
      FOR INSERT
AS
BEGIN
      --kiểm tra mã thuốc thuộc nhà cung cấp
      IF (SELECT THUOC FROM inserted) NOT IN (
            SELECT MATHUOC FROM THUOC T
            WHERE T.MANCC = (
                  SELECT MANCC FROM DONHANGNHAP D
                  WHERE D.MADONHANG = (
                        SELECT MADONHANG FROM inserted
                  )
            )
      )
      BEGIN
            PRINT N'THUỐC KHÔNG NẰM TRONG DANH MỤC THUỐC ĐƯỢC CUNG CẤP BỞI NHÀ CUNG CẤP THEO ĐƠN HÀNG!'
            ROLLBACK TRAN
      END

      --kiểm tra tính hợp lệ của ngày sản xuất (nsx phải trước ngày lập)
      ELSE IF(SELECT NGAYSX FROM inserted) > (
            SELECT NGAYLAP FROM DONHANGNHAP JOIN inserted
            ON inserted.MADONHANG = DONHANGNHAP.MADONHANG
      )
      BEGIN
            PRINT N'NGÀY SẢN XUẤT KHÔNG HỢP LỆ!'
            ROLLBACK TRAN
      END


      --kiểm tra sản phẩm còn hạn hay không
      ELSE IF(SELECT NGAYHETHAN FROM inserted) <= GETDATE()
      BEGIN
            PRINT N'SẢN PHẨM ĐÃ QUÁ HẠN SỬ DỤNG! VUI LÒNG KIỂM TRA LẠI VỚI NHÀ CUNG CẤP'
            ROLLBACK TRAN
      END

      --cập nhật dữ liệu cho thuộc tính đơn vị tính của bảng nhập thuốc
      UPDATE NHAPTHUOC
      SET DONVITINH = (
            SELECT QCDONGGOI FROM THUOC T
            WHERE NHAPTHUOC.THUOC = T.MATHUOC
      )
      FROM NHAPTHUOC JOIN inserted
      ON NHAPTHUOC.MADONHANG = inserted.MADONHANG
      AND NHAPTHUOC.THUOC = inserted.THUOC

      --cập nhật dữ liệu cho thuộc tính thành tiền của bảng nhập thuốc
      IF(SELECT THANHTIEN FROM inserted)!= NULL
      BEGIN
            PRINT N'THÀNH TIỀN SẼ ĐƯỢC HỆ THỐNG TỰ ĐỘNG CẬP NHẬT THEO ĐƠN HÀNG'
      END

      UPDATE NHAPTHUOC
      SET THANHTIEN = inserted.SOLUONG * GIANHAP
      FROM NHAPTHUOC, THUOC T, inserted
      WHERE NHAPTHUOC.MADONHANG = inserted.MADONHANG
      AND NHAPTHUOC.THUOC = inserted.THUOC
      AND NHAPTHUOC.THUOC = T.MATHUOC

      --cập nhật tổng tiền cho bảng đơn hàng nhập
      UPDATE DONHANGNHAP
      SET TONGTIEN = TONGTIEN + N.THANHTIEN
      FROM DONHANGNHAP, inserted, NHAPTHUOC N
      WHERE DONHANGNHAP.MADONHANG = inserted.MADONHANG
      AND N.THUOC = inserted.THUOC
      AND N.MADONHANG = inserted.MADONHANG

      IF(SELECT TRANGTHAIDH FROM DONHANGNHAP D, inserted
            WHERE D.MADONHANG = inserted.MADONHANG) = N'Đã nhận'
      BEGIN
            --cập nhật lại số lượng của nhóm thuốc
            UPDATE NHOMTHUOC
            SET NHOMTHUOC.SOLUONG += inserted.SOLUONG
            FROM NHOMTHUOC INNER JOIN inserted
            ON inserted.THUOC IN (
                  SELECT MATHUOC FROM THUOC T
                  WHERE T.MANHOM = NHOMTHUOC.MANHOM
            )

            --thêm dữ liệu vào kho hàng
            INSERT INTO KHOHANG (MATHUOC, DONNHAP, TONKHO, NGAYHETHAN)
            VALUES (
                  (
                        SELECT THUOC FROM inserted
                  ),(
                        SELECT MADONHANG FROM DONHANGNHAP D
                        WHERE D.MADONHANG = (SELECT MADONHANG FROM inserted)
                  ), (
                        SELECT SOLUONG FROM inserted   
                  ), (
                        SELECT NGAYHETHAN FROM inserted
                  )
            )
      END
END
GO

CREATE TRIGGER TRG_DELETE_NHAPTHUOC
      ON NHAPTHUOC
      FOR DELETE
AS
BEGIN
      IF(SELECT TRANGTHAIDH FROM DONHANGNHAP JOIN deleted ON DONHANGNHAP.MADONHANG = deleted.MADONHANG)!= N'Đang chuẩn bị'
      BEGIN
            PRINT N'KHÔNG THỂ THAY ĐỔI ĐƠN HÀNG'
            ROLLBACK TRAN
      END
      
      --cập nhật tổng tiền cho bảng đơn hàng nhập
      UPDATE DONHANGNHAP
      SET TONGTIEN = TONGTIEN - deleted.THANHTIEN
      FROM DONHANGNHAP, deleted
      WHERE DONHANGNHAP.MADONHANG = deleted.MADONHANG
END
GO

--tạo trigger khi thêm dữ liệu vào bảng XUATTHUOC
CREATE TRIGGER TRG_INSERT_XUATTHUOC
      ON XUATTHUOC
      FOR INSERT
AS
BEGIN
      --kiểm tra số lượng thuốc còn trong kho
      IF(SELECT SUM(TONKHO) FROM KHOHANG JOIN inserted
            ON KHOHANG.MATHUOC = inserted.THUOC) < (SELECT SOLUONG FROM inserted)
      BEGIN
            PRINT N'SỐ LƯỢNG TỒN KHO KHÔNG ĐỦ!'
            ROLLBACK TRAN
      END

      --kiểm tra sản phẩm trong kho hàng
      IF (SELECT THUOC FROM inserted) NOT IN  (SELECT MATHUOC FROM KHOHANG K)
      BEGIN
            PRINT N'SẢN PHẨM KHÔNG TỒN TẠI TRONG KHO HÀNG!'
            ROLLBACK TRAN
      END

      --cập nhật dữ liệu cho thuộc tính đơn vị tính của bảng xuất
      UPDATE XUATTHUOC
      SET DONVITINH = (
            SELECT QCDONGGOI FROM THUOC T
            WHERE XUATTHUOC.THUOC = T.MATHUOC
      )
      FROM inserted JOIN XUATTHUOC
      ON XUATTHUOC.MADONHANG = inserted.MADONHANG
      AND XUATTHUOC.THUOC = inserted.THUOC

      --cập nhật thành tiền
      IF(SELECT THANHTIEN FROM inserted)!= NULL
      BEGIN
            PRINT N'THÀNH TIỀN SẼ ĐƯỢC HỆ THỐNG TỰ ĐỘNG CẬP NHẬT THEO ĐƠN HÀNG'
      END

      UPDATE XUATTHUOC
      SET THANHTIEN = inserted.SOLUONG * (
            CASE 
            WHEN (
                  SELECT MAKH FROM DONHANGXUAT D
                  WHERE XUATTHUOC.MADONHANG = D.MADONHANG) IN ( 
                        SELECT MAKH FROM KHACHHANG K
                        WHERE K.LOAIKH = N'Khách lẻ'
                  ) 
                  THEN (
                        SELECT GIALE FROM THUOC T
                        WHERE XUATTHUOC.THUOC = T.MATHUOC
                  )
            WHEN(
                  SELECT MAKH FROM DONHANGXUAT D
                  WHERE XUATTHUOC.MADONHANG = D.MADONHANG) IN ( 
                        SELECT MAKH FROM KHACHHANG K
                        WHERE K.LOAIKH = N'Khách sỉ'
                  ) 
                  THEN (
                        SELECT GIASI FROM THUOC T
                        WHERE XUATTHUOC.THUOC = T.MATHUOC
                  )
            END
      )
      FROM inserted JOIN XUATTHUOC
      ON XUATTHUOC.MADONHANG = inserted.MADONHANG
      AND XUATTHUOC.THUOC = inserted.THUOC

      -- cập nhật lại tổng tiền của đơn hàng
      UPDATE DONHANGXUAT
      SET TONGTIEN = TONGTIEN + X.THANHTIEN
      FROM DONHANGXUAT JOIN inserted
      ON DONHANGXUAT.MADONHANG = inserted.MADONHANG
      JOIN XUATTHUOC X
      ON X.THUOC = inserted.THUOC
      AND X.MADONHANG = inserted.MADONHANG

      IF(SELECT TRANGTHAIDH FROM DONHANGXUAT D JOIN inserted
            ON D.MADONHANG = inserted.MADONHANG) = N'Đã giao'
      BEGIN
            -- Cập nhật số lượng nhóm thuốc
            UPDATE NHOMTHUOC
            SET NHOMTHUOC.SOLUONG -= inserted.SOLUONG
            FROM NHOMTHUOC INNER JOIN inserted
            ON inserted.THUOC IN (
                  SELECT MATHUOC FROM THUOC T
                  WHERE T.MANHOM = NHOMTHUOC.MANHOM
            )

            --cập nhật số lượng tồn kho
            DECLARE @NHHUUTIEN DATE
            SELECT @NHHUUTIEN = MIN(NGAYHETHAN) FROM KHOHANG JOIN inserted ON KHOHANG.MATHUOC = inserted.THUOC

            DECLARE @TONKHOUUTIEN INT
            SELECT @TONKHOUUTIEN = TONKHO FROM KHOHANG JOIN inserted ON NGAYHETHAN = @NHHUUTIEN AND KHOHANG.MATHUOC = inserted.THUOC

            IF @TONKHOUUTIEN > (SELECT SOLUONG FROM inserted)
            BEGIN
                  UPDATE KHOHANG
                  SET TONKHO -= inserted.SOLUONG
                  FROM inserted JOIN KHOHANG
                  ON NGAYHETHAN = @NHHUUTIEN
                  AND KHOHANG.MATHUOC = inserted.THUOC
            END

            ELSE
            BEGIN
                  UPDATE KHOHANG
                  SET TONKHO = TONKHO - inserted.SOLUONG + @TONKHOUUTIEN
                  FROM inserted JOIN KHOHANG
                  ON KHOHANG.MATHUOC = inserted.THUOC
                  AND NGAYHETHAN = (
                        SELECT MIN(NGAYHETHAN) FROM KHOHANG K
                        WHERE K.NGAYHETHAN != @NHHUUTIEN
                        AND KHOHANG.MATHUOC = K.MATHUOC
                  )

                  DELETE KHOHANG
                  WHERE NGAYHETHAN = @NHHUUTIEN
                  AND KHOHANG.MATHUOC = (SELECT THUOC FROM inserted)
            END
      END
END
GO

CREATE TRIGGER TRG_DELETE_XUATTHUOC
      ON XUATTHUOC
      FOR DELETE
AS
BEGIN
      IF(SELECT TRANGTHAIDH FROM DONHANGXUAT, deleted WHERE DONHANGXUAT.MADONHANG = deleted.MADONHANG)!= N'Đang chuẩn bị'
      BEGIN
            PRINT N'KHÔNG THỂ THAY ĐỔI ĐƠN HÀNG'
            ROLLBACK TRAN
      END

      -- cập nhật lại tổng tiền của đơn hàng
      UPDATE DONHANGXUAT
      SET TONGTIEN = TONGTIEN - deleted.THANHTIEN
      FROM DONHANGXUAT JOIN deleted
      ON DONHANGXUAT.MADONHANG = deleted.MADONHANG
END
GO

--tạo trigger khi xóa dữ liệu trong bảng KHOHANG
CREATE TRIGGER TRG_DELETE_KHOHANG
      ON KHOHANG
      FOR DELETE
AS
BEGIN
      --cập nhật lại số lượng của nhóm thuốc
      UPDATE NHOMTHUOC
      SET NHOMTHUOC.SOLUONG -= deleted.TONKHO
      FROM NHOMTHUOC INNER JOIN deleted
      ON deleted.MATHUOC IN (
            SELECT MATHUOC FROM THUOC
            WHERE THUOC.MANHOM = NHOMTHUOC.MANHOM
      )
END
GO

--tạo trigger khi thêm hoặc sửa dữ liệu ở bảng NGUOIDUNG
CREATE TRIGGER TRG_INSERT_TAIKHOAN
      ON TAIKHOAN
      AFTER INSERT, UPDATE
AS
BEGIN
      --kiểm tra email nhập vào đúng
IF EXISTS(
            SELECT EMAIL FROM inserted
            WHERE EMAIL NOT LIKE '%_@__%.__%'
)
BEGIN
      PRINT N'EMAIL KHÔNG ĐÚNG, HÃY THỬ LẠI!'
      ROLLBACK TRAN
END
END
GO

--tạo trigger khi thêm dữ liệu vào bảng GIOHANG
CREATE TRIGGER TRG_INSERT_GIOHANG
      ON GIOHANG
      INSTEAD OF INSERT
AS
BEGIN
      --reset thành tiền nếu người dùng nhập vào giá trị khác
      IF(SELECT THANHTIEN FROM inserted)!= NULL
      BEGIN
            PRINT N'THÀNH TIỀN SẼ ĐƯỢC HỆ THỐNG TỰ ĐỘNG CẬP NHẬT THEO ĐƠN HÀNG'
            PRINT N'UPDATE THÀNH TIỀN'
            UPDATE GIOHANG
            SET THANHTIEN = 0
            FROM inserted
            WHERE GIOHANG.MATHUOC = inserted.MATHUOC
      END

      --nếu thuốc đã được thêm vào giỏ hàng trước đó, số lượng sẽ được thay đổi thành số lượng mới
      IF EXISTS (
            SELECT * FROM inserted JOIN GIOHANG
            ON inserted.USERNAME = GIOHANG.USERNAME
            AND inserted.MATHUOC = GIOHANG.MATHUOC
      )
      BEGIN
            PRINT N'THUỐC ĐÃ CÓ TRONG GIỎ HÀNG, SỐ LƯỢNG MỚI SẼ ĐƯỢC CẬP NHẬT'
            UPDATE GIOHANG
            SET SOLUONG = inserted.SOLUONG
            FROM inserted
            WHERE inserted.USERNAME = GIOHANG.USERNAME

            --cập nhật lại thành tiền
            UPDATE GIOHANG
            SET THANHTIEN = GIALE * GIOHANG.SOLUONG
            FROM THUOC
            WHERE THUOC.MATHUOC = GIOHANG.MATHUOC
      END

      ELSE
      BEGIN
            INSERT INTO GIOHANG
            VALUES (
                        (SELECT USERNAME FROM inserted),
                        (SELECT MATHUOC FROM inserted),
                        (SELECT SOLUONG FROM inserted),
                        (SELECT QCDONGGOI FROM THUOC, inserted WHERE THUOC.MATHUOC = inserted.MATHUOC),
                        (SELECT SOLUONG * GIALE FROM THUOC, inserted WHERE THUOC.MATHUOC = inserted.MATHUOC)
                        )
      END
END
GO

--tạo triger khi thêm dữ liệu vào DONHANGONLINE
CREATE TRIGGER TRG_INSERT_DONHANGONLINE
      ON DONHANGONLINE
      FOR INSERT
AS
BEGIN
      --set mã đơn hàng tự động
      PRINT N'MÃ ĐƠN HÀNG SẼ ĐƯỢC SET TỰ ĐỘNG'

      DECLARE @result VARCHAR(10) 
      EXEC usp_TimMaDonHangOnlineTiepTheo @result OUT

      UPDATE DONHANGONLINE
      SET MADONHANG = @result
      FROM DONHANGONLINE JOIN inserted
      ON DONHANGONLINE.MADONHANG = inserted.MADONHANG

      --reset giá trị tổng tiền về 0 khi người dùng nhập giá trị khác
      IF(SELECT TONGTIEN FROM inserted) !=0
      BEGIN
            PRINT N'TỔNG TIỀN SẼ ĐƯỢC HỆ THỐNG TỰ ĐỘNG CẬP NHẬT THEO ĐƠN HÀNG'
            PRINT N'RESET TỔNG TIỀN'
            UPDATE DONHANGONLINE
            SET TONGTIEN = 0
            FROM inserted
            WHERE DONHANGONLINE.MADONHANG = inserted.MADONHANG
      END
END
GO

CREATE TRIGGER TRG_UPDATE_DONHANGONLINE
      ON DONHANGONLINE
      FOR UPDATE
AS
BEGIN
      --đơn hàng chỉ có thể hủy khi đang trong trạng thái đang lập đơn
      IF ((SELECT TRANGTHAIDH FROM deleted) != N'Đang lập đơn' AND (SELECT TRANGTHAIDH FROM inserted) = N'Đã hủy')
      BEGIN
            PRINT N'KHÔNG THỂ HỦY ĐƠN HÀNG'
            ROLLBACK TRAN
      END

      IF EXISTS (
            SELECT inserted.TRANGTHAIDH FROM deleted JOIN inserted 
            ON (deleted.TRANGTHAIDH = N'Đã hủy' AND inserted.TRANGTHAIDH != N'Đã hủy') 
            OR (deleted.TRANGTHAIDH = N'Giao không thành công' AND inserted.TRANGTHAIDH != N'Giao không thành công'))
      BEGIN
            PRINT N'TRẠNG THÁI ĐƠN HÀNG KHÔNG THỂ THAY ĐỔI'
            ROLLBACK TRAN
      END

      --thông báo khi hủy đơn hàng
      IF ((SELECT TRANGTHAIDH FROM deleted) = N'Đang lập đơn' AND (SELECT TRANGTHAIDH FROM inserted) = N'Đã hủy') OR (SELECT TRANGTHAIDH FROM inserted) = N'Giao không thành công'
      BEGIN
            PRINT N'ĐƠN HÀNG ĐÃ NẰM TRONG TRẠNG THÁI KHÔNG THỂ THAY ĐỔI'
      END

      --thông báo khi đặt hàng thành công
      IF ((SELECT TRANGTHAIDH FROM inserted) != N'Đang lập đơn' AND (SELECT TRANGTHAIDH FROM deleted) = N'Đã đặt')
      BEGIN
            PRINT N'ĐƠN HÀNG ĐÃ ĐƯỢC ĐẶT THÀNH CÔNG'
            DELETE GIOHANG
            FROM GIOHANG  JOIN inserted
            ON GIOHANG.USERNAME = inserted.USERNAME
            JOIN DONXUATONLINECHITIET D
            ON D.THUOC = GIOHANG.MATHUOC
      END
END
GO

--tạo trigger khi thêm dữ liệu vào bảng DONXUATONLINECHITIET
CREATE TRIGGER TRG_INSERT_DONXUATONLINECHITIET
      ON DONXUATONLINECHITIET
      FOR INSERT
AS
BEGIN
      --kiểm tra số lượng thuốc còn trong kho
      IF(SELECT SUM(TONKHO) FROM KHOHANG, inserted
            WHERE KHOHANG.MATHUOC = inserted.THUOC) < (SELECT SOLUONG FROM inserted)
      BEGIN
            PRINT N'SỐ LƯỢNG TỒN KHO KHÔNG ĐỦ!'
            ROLLBACK TRAN
      END

      --kiểm tra thuốc có tồn tại trong kho hàng không
      IF (SELECT THUOC FROM inserted) NOT IN  (SELECT MATHUOC FROM KHOHANG K)
      BEGIN
            PRINT N'SẢN PHẨM KHÔNG TỒN TẠI TRONG KHO HÀNG!'
            ROLLBACK TRAN
      END

      --kiểm tra thuốc đã được thêm vào giỏ hàng của người dùng không
      IF NOT EXISTS (
            SELECT inserted.MADONHANG FROM DONXUATONLINECHITIET D JOIN inserted
            ON D.MADONHANG = inserted.MADONHANG
            AND D.THUOC = inserted.THUOC
            JOIN GIOHANG G
            ON D.THUOC = G.MATHUOC
            AND G.USERNAME = (SELECT USERNAME FROM DONHANGONLINE WHERE MADONHANG = inserted.MADONHANG)
      )
      BEGIN
            PRINT N'THUỐC CHƯA CÓ TRONG GIỎ HÀNG, HÃY THỬ LẠI!'
            ROLLBACK TRAN
      END

      --không thể thêm sản phẩm vào đơn hàng đã được đặt thành công
      IF (SELECT TRANGTHAIDH FROM DONHANGONLINE JOIN inserted ON inserted.MADONHANG = DONHANGONLINE.MADONHANG) != N'Đang lập đơn'
      BEGIN
            PRINT N'ĐƠN HÀNG ĐÃ ĐƯỢC ĐẶT THÀNH CÔNG, KHÔNG THỂ THÊM SẢN PHẨM VÀO ĐƠN HÀNG NÀY!'
            ROLLBACK TRAN
      END
      
      --cập nhật dữ liệu cho thuộc tính đơn vị tính, thành tiền và số lượng của bảng xuất online
      UPDATE DONXUATONLINECHITIET
      SET THANHTIEN = G.THANHTIEN,
      DONVITINH = G.DONVITINH,
      SOLUONG = G.SOLUONG
      FROM inserted JOIN DONXUATONLINECHITIET D
      ON D.MADONHANG = inserted.MADONHANG
      AND D.THUOC = inserted.THUOC
      JOIN GIOHANG G
      ON D.THUOC = G.MATHUOC     
      AND G.USERNAME = (SELECT USERNAME FROM DONHANGONLINE WHERE MADONHANG = inserted.MADONHANG)

      -- cập nhật lại tổng tiền của đơn hàng
      UPDATE DONHANGONLINE
      SET TONGTIEN = TONGTIEN + D.THANHTIEN
      FROM DONHANGONLINE JOIN inserted 
      ON DONHANGONLINE.MADONHANG = inserted.MADONHANG
      JOIN DONXUATONLINECHITIET D
      ON D.THUOC = inserted.THUOC
      AND D.MADONHANG = inserted.MADONHANG

      IF(SELECT TRANGTHAIDH FROM DONHANGONLINE D JOIN inserted
                  ON D.MADONHANG = inserted.MADONHANG) != N'Đã đặt'
      BEGIN
            -- Cập nhật số lượng nhóm thuốc
            UPDATE NHOMTHUOC
            SET NHOMTHUOC.SOLUONG -= inserted.SOLUONG
            FROM NHOMTHUOC INNER JOIN inserted
            ON inserted.THUOC IN (
                  SELECT MATHUOC FROM THUOC T
                  WHERE T.MANHOM = NHOMTHUOC.MANHOM
            )

            --cập nhật số lượng tồn kho
            DECLARE @NHHUUTIEN DATE
            SELECT @NHHUUTIEN = MIN(NGAYHETHAN) FROM KHOHANG JOIN inserted ON KHOHANG.MATHUOC = inserted.THUOC

            DECLARE @TONKHOUUTIEN INT
            SELECT @TONKHOUUTIEN = TONKHO FROM KHOHANG JOIN inserted ON NGAYHETHAN = @NHHUUTIEN AND KHOHANG.MATHUOC = inserted.THUOC

            IF @TONKHOUUTIEN > (SELECT SOLUONG FROM inserted)
            BEGIN
                  UPDATE KHOHANG
                  SET TONKHO -= inserted.SOLUONG
                  FROM inserted JOIN KHOHANG
                  ON NGAYHETHAN = @NHHUUTIEN
                  AND KHOHANG.MATHUOC = inserted.THUOC
            END

            ELSE
            BEGIN
                  UPDATE KHOHANG
                  SET TONKHO = TONKHO - inserted.SOLUONG + @TONKHOUUTIEN
                  FROM inserted JOIN KHOHANG
                  ON KHOHANG.MATHUOC = inserted.THUOC
                  AND NGAYHETHAN = (
                        SELECT MIN(NGAYHETHAN) FROM KHOHANG K
                        WHERE K.NGAYHETHAN != @NHHUUTIEN
                        AND KHOHANG.MATHUOC = K.MATHUOC
                  )

                  DELETE KHOHANG
                  WHERE NGAYHETHAN = @NHHUUTIEN
                  AND KHOHANG.MATHUOC = (SELECT THUOC FROM inserted)
            END
      END
END
GO


CREATE TRIGGER TRG_DELETE_DONXUATONLINECHITIET
      ON DONXUATONLINECHITIET
      FOR DELETE
AS
BEGIN
      --chỉ có thể hủy đơn hàng hoặc thay đổi trạng thái thành giao hàng không thành công
      IF(SELECT TRANGTHAIDH FROM DONHANGONLINE JOIN deleted ON DONHANGONLINE.MADONHANG = deleted.MADONHANG)!= N'Đang lập đơn'
      BEGIN
            PRINT N'KHÔNG THỂ THAY ĐỔI ĐƠN HÀNG'
            ROLLBACK TRAN
      END

      -- cập nhật lại tổng tiền của đơn hàng
      UPDATE DONHANGONLINE
      SET TONGTIEN = TONGTIEN + deleted.THANHTIEN
      FROM DONHANGONLINE JOIN deleted
      ON DONHANGONLINE.MADONHANG = deleted.MADONHANG
END
GO


----------------------------------------------------CÀI ĐẶT CÁC CHỨC NĂNG-----------------------------------------------------------

--tính hạn thanh toán nợ cho Khách hàng
CREATE FUNCTION UF_HanNoKH(@Ngaylap DATE, @loaikh NVARCHAR(15), @congno MONEY)
RETURNS DATE
AS
BEGIN
      IF @congno = 0
      BEGIN
            RETURN NULL
      END
      DECLARE @HANNOKH DATE
      IF @loaikh =N'Khách lẻ'
      BEGIN
            SELECT @HANNOKH = DATEADD(DAY, 5, @Ngaylap)
      END
      IF @loaikh =N'Khách sỉ'
      BEGIN
            SELECT @HANNOKH = DATEADD(DAY, 15, @Ngaylap)
      END
      RETURN @HANNOKH
END
GO

--tính hạn nợ đối với nhà cung cấp
CREATE FUNCTION UF_HanNoNCC(@Ngaylap DATE, @congno MONEY)
RETURNS DATE
AS
BEGIN
      IF @congno = 0
      BEGIN
            RETURN NULL
      END
      DECLARE @HANNONCC DATE
            SELECT @HANNONCC = DATEADD(DAY, 10, @Ngaylap)
      RETURN @HANNONCC
END
GO

--tính doanh thu theo năm
CREATE FUNCTION UF_TinhDoanhThuTheoNam(@nam INT)
RETURNS MONEY
AS
BEGIN
      DECLARE @Doanhthu MONEY
      SELECT @Doanhthu = SUM(DATHANHTOAN) FROM DONHANGXUAT
      WHERE YEAR(NGAYLAP) = @nam
      RETURN @Doanhthu
END
GO

--tính doanh thu theo tháng
CREATE FUNCTION UF_TinhDoanhThuTheoThang(@thang INT, @nam INT)
RETURNS MONEY
AS
BEGIN
      DECLARE @Doanhthu MONEY
      SELECT @Doanhthu = SUM(DATHANHTOAN) FROM DONHANGXUAT
      WHERE YEAR(NGAYLAP) = @Nam
      AND MONTH(NGAYLAP) = @thang
      RETURN @Doanhthu
END
GO

--tính doanh thu theo quý
CREATE FUNCTION UF_TinhDoanhThuTheoQuy(@quy INT, @nam INT)
RETURNS MONEY
AS
BEGIN
      DECLARE @Doanhthu MONEY
      SELECT @Doanhthu = SUM(DATHANHTOAN) FROM DONHANGXUAT
      WHERE YEAR(NGAYLAP) = @Nam
      AND DATEPART(QUARTER, NGAYLAP) = @quy
      RETURN @Doanhthu
END
GO

--danh sách nhập hàng theo năm
CREATE FUNCTION UF_DanhSachNhapHangTheoNam(@nam INT)
RETURNS TABLE
AS 
      RETURN SELECT N.MADONHANG, TENNCC, THUOC.TENTHUOC, N.SOLUONG, N.DONVITINH, D.NGAYLAP, N.NGAYSX, N.NGAYHETHAN
      FROM NHAPTHUOC N JOIN DONHANGNHAP D
      ON D.MADONHANG = N.MADONHANG
      JOIN NHACUNGCAP NCC
      ON D.MANCC = NCC.MANCC
      JOIN THUOC
      ON THUOC.MATHUOC = N.THUOC
      AND YEAR(NGAYLAP) = @nam
GO

--danh sách nhập hàng theo năm
CREATE FUNCTION UF_DanhSachNhapHangTheoThang(@thang INT, @nam INT)
RETURNS TABLE
AS 
      RETURN SELECT N.MADONHANG, TENNCC, THUOC.TENTHUOC, N.SOLUONG, N.DONVITINH, D.NGAYLAP, N.NGAYSX, N.NGAYHETHAN
      FROM NHAPTHUOC N JOIN DONHANGNHAP D
      ON D.MADONHANG = N.MADONHANG
      JOIN NHACUNGCAP NCC
      ON D.MANCC = NCC.MANCC
      JOIN THUOC
      ON THUOC.MATHUOC = N.THUOC
      AND YEAR(NGAYLAP) = @nam
      AND MONTH(NGAYLAP) = @thang
GO

--danh sách nhập hàng theo quý
CREATE FUNCTION UF_DanhSachNhapHangTheoQuy(@quy INT, @nam INT)
RETURNS TABLE
AS 
      RETURN SELECT N.MADONHANG, TENNCC, THUOC.TENTHUOC, N.SOLUONG, N.DONVITINH, D.NGAYLAP, N.NGAYSX, N.NGAYHETHAN
      FROM NHAPTHUOC N JOIN DONHANGNHAP D
      ON D.MADONHANG = N.MADONHANG
      JOIN NHACUNGCAP NCC
      ON D.MANCC = NCC.MANCC
      JOIN THUOC
      ON THUOC.MATHUOC = N.THUOC
      AND YEAR(NGAYLAP) = @nam
      AND DATEPART(QUARTER, NGAYLAP) = @quy
GO

--Xuất sản phẩm bán chạy theo năm/tháng/quý
CREATE FUNCTION UF_XuatSanPhamBanChayTheoNam(@nam INT)
RETURNS TABLE
AS 
      RETURN SELECT TOP 1 THUOC.MATHUOC, THUOC.TENTHUOC, THUOC.MANHOM, SUM(X.SOLUONG) AS SOLUONG FROM XUATTHUOC X JOIN THUOC
      ON X.THUOC = THUOC.MATHUOC
      JOIN DONHANGXUAT D
      ON YEAR(D.NGAYLAP) = @nam
      GROUP BY THUOC.MATHUOC, THUOC.TENTHUOC, THUOC.MANHOM
      ORDER BY SOLUONG DESC
GO

CREATE FUNCTION UF_XuatSanPhamBanChayTheoThang(@thang INT, @nam INT)
RETURNS TABLE
AS 
      RETURN SELECT TOP 1 THUOC.MATHUOC, THUOC.TENTHUOC, THUOC.MANHOM, SUM(X.SOLUONG) AS SOLUONG FROM XUATTHUOC X JOIN THUOC
      ON X.THUOC = THUOC.MATHUOC
      JOIN DONHANGXUAT D
      ON YEAR(D.NGAYLAP) = @nam
      AND MONTH(D.NGAYLAP) = @thang
      GROUP BY THUOC.MATHUOC, THUOC.TENTHUOC, THUOC.MANHOM
      ORDER BY SOLUONG DESC
GO

CREATE FUNCTION UF_XuatSanPhamBanChayTheoQuy(@quy INT, @nam INT)
RETURNS TABLE
AS 
      RETURN SELECT TOP 1 THUOC.MATHUOC, THUOC.TENTHUOC, THUOC.MANHOM, SUM(X.SOLUONG) AS SOLUONG FROM XUATTHUOC X JOIN THUOC
      ON X.THUOC = THUOC.MATHUOC
      JOIN DONHANGXUAT D
      ON YEAR(D.NGAYLAP) = @nam
      AND DATEPART(QUARTER, NGAYLAP) = @quy
      GROUP BY THUOC.MATHUOC, THUOC.TENTHUOC, THUOC.MANHOM
      ORDER BY SOLUONG DESC
GO

-- Báo cáo danh sách xuất hàng theo năm 
CREATE FUNCTION UF_DanhSachXuatHangTheoNam(@nam INT)
RETURNS TABLE
AS 
      RETURN SELECT X.MADONHANG, TENNCC, THUOC.TENTHUOC, X.SOLUONG, X.DONVITINH, D.NGAYLAP
      FROM XUATTHUOC X JOIN DONHANGXUAT D
      ON D.MADONHANG = X.MADONHANG
      JOIN THUOC
      ON THUOC.MATHUOC = X.THUOC
      JOIN NHACUNGCAP NCC
      ON THUOC.MANCC = NCC.MANCC
      AND YEAR(NGAYLAP) = @nam
GO

-- Báo cáo danh sách xuất hàng theo tháng
CREATE FUNCTION UF_DanhSachXuatHangTheoThang(@thang INT, @nam INT)
RETURNS TABLE
AS 
      RETURN SELECT X.MADONHANG, TENNCC, THUOC.TENTHUOC, X.SOLUONG, X.DONVITINH, D.NGAYLAP
      FROM XUATTHUOC X JOIN DONHANGXUAT D
      ON D.MADONHANG = X.MADONHANG
      JOIN THUOC
      ON THUOC.MATHUOC = X.THUOC
      JOIN NHACUNGCAP NCC
      ON THUOC.MANCC = NCC.MANCC
      AND YEAR(NGAYLAP) = @nam
      AND MONTH(NGAYLAP) = @thang
GO

--Báo cáo danh sách xuất hàng theo quý
CREATE FUNCTION UF_DanhSachXuatHangTheoQuy(@quy INT, @nam INT)
RETURNS TABLE
AS 
      RETURN SELECT X.MADONHANG, TENNCC, THUOC.TENTHUOC, X.SOLUONG, X.DONVITINH, D.NGAYLAP
      FROM XUATTHUOC X JOIN DONHANGXUAT D
      ON D.MADONHANG = X.MADONHANG
      JOIN THUOC
      ON THUOC.MATHUOC = X.THUOC
      JOIN NHACUNGCAP NCC
      ON THUOC.MANCC = NCC.MANCC
      AND YEAR(NGAYLAP) = @nam
      AND DATEPART(QUARTER, NGAYLAP) = @quy
GO
-------------------------------------------------TẠO CÁC BẢNG ẢO------------------------------------------------------

--tạo phiếu bán hàng
CREATE VIEW PhieuBanHang AS
SELECT MADONHANG, TENKHACH, LOAIKH, TENNV AS NGUOILAP, TRANGTHAIDH, NGAYLAP, TONGTIEN, DATHANHTOAN, D.CONGNO,  dbo.UF_HanNoKH(D.NGAYLAP, K.LOAIKH, D.CONGNO) AS HANNO 
FROM DONHANGXUAT D JOIN KHACHHANG K
ON D.MAKH = K.MAKH
JOIN NHANVIEN N
ON D.MANV = N.MANV
GO

--tạo phiếu mua hàng
CREATE VIEW PhieuMuaHang AS
SELECT MADONHANG, TENNCC, TENNV AS NGUOILAP, DIENTHOAI, TRANGTHAIDH, NGAYLAP, TONGTIEN, DATHANHTOAN, D.CONGNO,  dbo.UF_HanNoNCC(D.NGAYLAP, D.CONGNO) AS HANNO 
FROM DONHANGNHAP D JOIN NHACUNGCAP N
ON D.MANCC = N.MANCC
AND D.MANCC = N.MANCC
JOIN NHANVIEN NV
ON D.MANV = NV.MANV
GO

--lưu lại số lượng từng loại thuốc trong kho
CREATE VIEW TonKho AS
SELECT TENTHUOC, TENNHOM, DANGBAOCHE, QCDONGGOI, LOAISD, (
            SELECT SUM(TONKHO) FROM KHOHANG K
            WHERE T.MATHUOC = K.MATHUOC
      ) AS SOLUONG FROM THUOC T JOIN NHOMTHUOC N 
      ON N.MANHOM = T.MANHOM
GO

--lưu lại công nợ của khách hàng
CREATE VIEW CongNoKhachHang AS
SELECT TENKHACH, D.CONGNO, D.NGAYLAP AS NGAYNO, dbo.UF_HanNoKH(NGAYLAP, LOAIKH, D.CONGNO)AS HANNO 
FROM KHACHHANG K JOIN DONHANGXUAT D
ON K.MAKH = D.MAKH
AND D.CONGNO != 0
GO

--lưu lại công nợ của cửa hàng với nhà cung cấp
CREATE VIEW CongNoNCC AS
SELECT TENNCC, D.CONGNO, D.NGAYLAP AS NGAYNO, dbo.UF_HanNoNCC(NGAYLAP, D.CONGNO)AS HANNO 
FROM NHACUNGCAP N JOIN DONHANGNHAP D
ON N.MANCC = D.MANCC
AND D.CONGNO != 0
GO

--lưu lại thu tiền tổng hợp
CREATE VIEW BangThuTien AS
SELECT D.NGAYLAP, MADONHANG, K.TENKHACH, N.TENNV, DATHANHTOAN AS THUTIEN 
FROM DONHANGXUAT D JOIN KHACHHANG K
ON K.MAKH = D.MAKH
JOIN NHANVIEN N
ON N.MANV = D.MANV
AND DATHANHTOAN != 0
GO

--Lưu lại chi tiền tổng hợp
CREATE VIEW BangChiTien AS
SELECT D.NGAYLAP, MADONHANG, D.MANCC, N.TENNCC, D.DATHANHTOAN AS CHITIEN 
FROM DONHANGNHAP D JOIN NHACUNGCAP N
ON D.MANCC = N.MANCC
AND DATHANHTOAN != 0
GO

---------------------------------------------THÊM DỮ LIỆU CHO CÁC BẢNG-----------------------------------------------

--thêm dữ liệu cho bảng nhóm thuốc
INSERT INTO NHOMTHUOC
      VALUES ('N001', N'Chế phẩm sinh học', 0)
INSERT INTO NHOMTHUOC
      VALUES ('N002', N'Dược phẩm', 0)
INSERT INTO NHOMTHUOC
      VALUES ('N003', N'Vaccine', 0)
INSERT INTO NHOMTHUOC
      VALUES ('N004', N'Hóa chất thú y', 0)
INSERT INTO NHOMTHUOC
      VALUES ('N005', N'Vi sinh vật', 0)

--thêm dữ liệu cho bảng nhà cung cấp
INSERT INTO NHACUNGCAP(MANCC, TENNCC, DIACHI, DIENTHOAI)
      VALUES ('3600278732', N'Công ty TNHH Minh Huy', N'Số 528 đường 21 tháng 4, Phường Xuân Bình, Thành phố Long khánh, Đồng Nai', '02513876071')
INSERT INTO NHACUNGCAP(MANCC, TENNCC, DIACHI, DIENTHOAI)
      VALUES ('0311987413', N'Công ty cổ phần Sài Gòn V.E.T', N'Số 315 đường Nam Kỳ Khởi Nghĩa, Phường 17, Quận 3, TP.HCM', '0838466888')
INSERT INTO NHACUNGCAP(MANCC, TENNCC, DIACHI, DIENTHOAI)
      VALUES ('0102137268', N'Công ty cổ phần thuốc thú y Toàn Thắng', N'Số 9 A3, đường Láng, Phường Láng Thượng, Đống Đa, Hà Nội', '0102137268')
INSERT INTO NHACUNGCAP(MANCC, TENNCC, DIACHI, DIENTHOAI)
      VALUES ('0105298457', N'Công ty đầu tư và phát triển công nghệ Sakan VN', N'Lô D1+D2+D3+D4, Xã Đông Thọ, Yên Phong, Bắc Ninh', '0105298457')
INSERT INTO NHACUNGCAP(MANCC, TENNCC, DIACHI, DIENTHOAI)
      VALUES ('0301460240', N'Công ty TM & SX thuốc thú Thịnh Á', N'220 Phạm Thế Hiển, Phường 2, Quận 8, Thành phố Hồ Chí Minh', '02838515503')
INSERT INTO NHACUNGCAP(MANCC, TENNCC, DIACHI, DIENTHOAI)
      VALUES ('0305110871', N'Công ty cổ phần UV', N'Lô số 18, Đường D1, khu công nghiệp An Hạ, Xã Phạm Văn Hai, Bình Chánh, TP.HCM', '02837685370')

--thêm dữ liệu cho bảng thuốc
INSERT INTO THUOC(MATHUOC, TENTHUOC, MANHOM, LOAISD, THANHPHAN, MANCC, GIANHAP, DANGBAOCHE, QCDONGGOI, CONGDUNG)
VALUES ('HCM-X4-25', N'Terramycin Egg Formula', 'N001', N'Gia cầm', N'Oxytetracyclin' ,'3600278732', 50000, N'Bột', N'Chai 100g', N'Nâng cao năng suất trứng, phòng các bệnh ở gia cầm.'),
      ('HCM-X4-79', N'Bio-Anticoc', 'N002', N'Gia cầm', N'Sulfamethoxazol' ,'3600278732', 35000, N'Bột', N'Gói 100g', N'Phòng và trị bệnh cầu trùng.'),
      ('HCM-X2-16', N'Fe-Dextran B12', 'N002', N'Gia súc', N'Vitamin B12' ,'0311987413', 50000, N'Dung dịch', N'Chai 100ml', N'Phòng chống thiếu máu do thiếu sắt.'),
      ('HCM-X2-164', N'Tylosin 200', 'N002', N'Gia súc', N'Tylosin tartrate' ,'0311987413', 55000, N'Dung dịch tiêm', N'Chai 100ml', N'Trị viêm phổi, viêm tử cung, bệnh lepto, viêm ruột'),
      ('HCM-X2-198', N'Tia-K.C', 'N002', N'Gia súc', N'Tiamulin hydrogen fumarate' ,'0311987413', 20000, N'Dung dịch', N'Chai 100ml', N'Trị bệnh đường hô hấp, tiêu hóa.'),
      ('GDA-10', N'NVDC-JXA1-Strain', 'N003', N'Gia súc', N'Virus chủng NVDC-JXA1 vô hoạt' ,'0102137268', 27000, N'Dung dịch tiêm', N'Chai 100ml', N'Phòng bệnh lợn tai xanh'),
      ('ETT-163', N'Dental Creme', 'N002', N'Thú cưng', N'Recicort' ,'0102137268', 100000, N'Dung dịch', N'Chai 500ml', N'Trị viêm tai ngoài, viêm da tiết bã nhờn trên chó, mèo.'),
      ('UV-65', N'RODO-UV', 'N005', N'Thủy sản', N'Rhodopseudomonas' ,'0305110871',150000, N'Dung dịch', N'Can 5L', N'Ức chế vi khuẩn gây bệnh trong ao nuôi'),
      ('ETT-165', N'Progesterone', 'N001', N'Thú cưng', N'Progesterone' ,'0102137268', 100000 , N'Dung dịch', N'Chai 500ml', N'Giảm co bóp, ổn định tử cung, an thai trong trường hợp đe dọa sẩy thai'),
      ('SAK-118', N'Sakan-Fipro', 'N004', N'Thú cưng', N'Fipronil' ,'0105298457', 60000, N'Dung dịch', N'Tuýp 20ml', N'Diệt ve, bọ rận, bọ chét và ghẻ trên chó mèo'),
      ('SAK-169', N'Amitraz', 'N004', N'Thú cưng', N'Ketoconazole' ,'0105298457', 75000, N'Dung dịch', N'Tuýp 20ml', N'Làm mượt lông cho chó, mèo'),
      ('SAK-185', N'Funguikur', 'N002', N'Thú cưng', N'Fluconazol' ,'0105298457', 40000, N'Dung dịch', N'Chai 50ml', N'Trị nấm gây ra trên chó, mèo.'),
      ('BD.TS5-4', N'Selenvit-E', 'N001', N'Thủy sản', N'Sodium selenite' ,'0301460240', 300000, N'Viên nén', N'Bao 10kg', N'Giúp tăng sản lượng đẻ trứng ở cá. Cá ương đạt tỷ lệ cao hơn, giảm hao hụt'),
      ('BD.TS5-5', N'MD Bio Calcium', 'N001', N'Thủy sản', N'Biotin' ,'0301460240', 200000, N'Dung dịch', N'Can 5l', N'Thúc đẩy quá trình lột vỏ ở tôm và giúp mau cứng vỏ sau khi lột.'),
      ('BD.TS5-19', N'MD Protect', 'N004', N'Thủy sản', N'1,5 Pentanedial' ,'0301460240', 200000, N'Dung dịch', N'Can 5 lít', N'Diệt các loại vi khuẩn, nấm, vi sinh động vật trong nước ao nuôi'),
      ('BN.TS2-51', N'Iodin-200', 'N004', N'Thủy sản', N'Benzalkonium chloride' ,'0102137268', 100000, N'Dung dịch', N'Chai 500ml', N'Sát trùng nguồn nước nuôi trồng thủy sản'),
      ('BN.TS2-15', N'ECO-Doxyfish Power 20', 'N002', N'Thủy sản', N'Doxycyclin' ,'0102137268', 34000, N'Bột', N'Gói 500g', N'Trị bệnh đỏ thân trên tôm do vi khuẩn Vibrio alginolyticus'),
      ('SAK-37', N'Flormax', 'N002', N'Gia súc', N'Doxycycline hyclate' ,'0105298457', 43000, N'Bột', N'Gói 100g', N'Trị nhiễm trùng đường tiêu hóa, hô hấp trên heo, trâu, bò, dê, cừu.'),
      ('CME-3', N'Vắc xin PRRS JXA1-R', 'N003', N'Gia súc', N'Virus PRRS nhược độc chủng JXA1-R' ,'0105298457',57000, N'Dung dịch tiêm', N'Chai 50ml', N'Phòng hội chứng rối loạn hô hấp và sinh sản (PRRS) trên heo.'),
      ('LBF-1', N'Foot And Mouth Disease Vaccine', 'N003', N'Gia súc', N'Virus Lở mồm Long móng type O' ,'0105298457', 34000, N'Dung dịch tiêm', N'Chai 100ml', N'Phòng bệnh Lở mồm long móng trên lợn'),
      ('ETT-94', N'ECO Erycol 10', 'N002', N'Gia cầm', N'Erythromycin thiocynat' ,'0102137268', 350000, N'Viên nén', N'Thùng 10kg', N'Trị nhiễm trùng đường tiêu hóa, hô hấp trên vịt, gà, ngan, ngỗng'),
      ('UV-2', N'Apa-Plankton_fish', 'N005', N'Thủy sản', N'Bacillus subtilis' ,'0305110871', 200000, N'Bột', N'Thùng 5kg', N'Phân hủy nhanh chất thải, phân tôm, xác tảo và thức ăn dư thừa.'),
      ('ETT-50', N'Eco-Terra egg', 'N001', N'Gia cầm', N'Oxytetracyclin' ,'0102137268', 30000, N'Bột', N'Gói 10g', N'Tăng trọng nhanh, giảm tỷ lệ tiêu tốn thức ăn, rút ngắn thời gian nuôi')

--thêm dữ liệu cho bảng nhân viên
INSERT INTO NHANVIEN
VALUES ('NV001', N'Nguyễn Quốc Thái', '26/12/1989', N'Dược sĩ đại học', N'49/1 Tân Trụ, Phường 15, Quận Tân Bình, TP HCM', N'Nam', N'Nhân viên', N'Kho'),
      ('NV002', N'Cù Đức Trường', '08/07/1994', N'Dược sĩ đại học', N'30/1 TMT 13, Phường Trung Mỹ Tây, Quận 12, TP HCM', N'Nam', N'Trưởng bộ phận', N'Bán hàng'),
      ('NV003', N'Võ Thị Thanh Trúc', '03/07/1990', N'Thạc sĩ', N'193/2/7 Đường Số 6, Phường Bình Hưng Hòa B, Quận Bình Tân, TP HCM', N'Nữ', N'Nhân viên', N'Bán hàng'),
      ('NV004', N'Lê Trương Trọng Tấn', '18/10/1995', N'Dược sĩ đại học', N'18 Tân Thới Nhất 17, Phường Tân Thới Nhất, Quận 12, TP HCM', N'Nam', N'Nhân viên', N'Quản lý')

--thêm dữ liệu cho bảng khách hàng
INSERT INTO KHACHHANG
      VALUES ('KH001', N'Trần Thành Luân', N'48/1 Đỗ Nhuận, Phường Sơn Kỳ, Quận Tân Phú, TP HCM', '0367512498', N'Khách sỉ', 0)
INSERT INTO KHACHHANG
      VALUES ('KH002', N'Bùi Phan Bảo Ngọc', N'48/1 Đỗ Nhuận, Phường Sơn Kỳ, Quận Tân Phú, TP HCM', '0379699529', N'Khách lẻ', 0)
INSERT INTO KHACHHANG
      VALUES ('KH003', N'Bùi Phan Bảo Ngọc', N'66/9 Trần Văn Quang, Phường 10, Quận Tân Bình, TP HCM', '0334275096', N'Khách lẻ', 0)
INSERT INTO KHACHHANG
      VALUES ('KH004', N'Nguyễn Phan Như Quỳnh', N'48/1 Đỗ Nhuận, Phường Sơn Kỳ, Quận Tân Phú, TP HCM', '0913630913', N'Khách sỉ', 0)
INSERT INTO KHACHHANG
      VALUES ('KH005', N'Huỳnh Vũ Chí Thiện', N'100 Lê Văn Sỹ, Phường 2, Quận Tân Bình, TP HCM', '0908655684', N'Khách sỉ', 0)
INSERT INTO KHACHHANG
      VALUES ('KH006', N'Khách vãng lai', NULL, NULL, N'Khách lẻ', 0)

--thêm dữ liệu cho bảng đơn hàng nhập
INSERT INTO DONHANGNHAP(MANCC, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('3600278732', 'NV001', N'Đã nhận', '22/12/2022', 2550000)
INSERT INTO DONHANGNHAP(MANCC, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('0311987413', 'NV001', N'Đã nhận', '24/12/2022', 4650000)
INSERT INTO DONHANGNHAP(MANCC, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('0102137268', 'NV004', N'Đã nhận', '26/12/2022', 0)
INSERT INTO DONHANGNHAP(MANCC, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('0105298457', 'NV001', N'Đã nhận', '29/12/2022', 10840000)
INSERT INTO DONHANGNHAP(MANCC, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('0301460240', 'NV001', N'Đã nhận', '01/01/2023', 16000000)
INSERT INTO DONHANGNHAP(MANCC, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('0305110871', 'NV001', N'Đã nhận', '12/01/2023',0)
INSERT INTO DONHANGNHAP(MANCC, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('3600278732', 'NV004', N'Đã nhận', '18/01/2023', 2400000)
INSERT INTO DONHANGNHAP(MANCC, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('0311987413', 'NV001', N'Đã nhận', '23/01/2023', 2050000)
INSERT INTO DONHANGNHAP(MANCC, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('0102137268', 'NV001', N'Đã nhận', '02/02/2023', 6680000)
INSERT INTO DONHANGNHAP(MANCC, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('0105298457', 'NV001', N'Đã nhận', '09/02/2023', 2200000)
INSERT INTO DONHANGNHAP(MANCC, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('0301460240', 'NV004', N'Đang vận chuyển', '20/02/2023', 0)
INSERT INTO DONHANGNHAP(MANCC, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('0305110871', 'NV001', N'Đang chuẩn bị', '06/03/2023', 0)
INSERT INTO DONHANGNHAP(MANCC, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('3600278732', 'NV004', N'Đã nhận', '19/03/2023', 1500000)
INSERT INTO DONHANGNHAP(MANCC, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('0311987413', 'NV001', N'Giao không thành công', '28/03/2023', 0)
INSERT INTO DONHANGNHAP(MANCC, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('0102137268', 'NV001', N'Đang vận chuyển', '10/04/2023', 0)
INSERT INTO DONHANGNHAP(MANCC, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('0311987413', 'NV004', N'Đang chuẩn bị', '26/04/2023', 0)

--thêm dữ liệu cho bảng đơn hàng xuất
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH001','NV002', N'Đã giao', '22/02/2023', 0)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH002','NV002', N'Đã giao', '24/02/2023', 275000)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH006','NV003',N'Đã giao', '26/02/2023', 77000)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH006','NV002', N'Đã giao', '27/02/2023', 225500)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH003','NV003', N'Đã giao', '01/03/2023', 220000)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH005','NV003', N'Đã giao', '12/03/2023', 214000)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH004','NV004', N'Đã giao', '18/03/2023', 0)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH005','NV004', N'Đã giao', '23/03/2023', 0)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH006','NV003', N'Đã giao', '02/03/2023', 93500)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH006','NV002', N'Đã giao', '09/03/2023', 165000)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH006','NV003', N'Đang vận chuyển', '20/03/2023', 0)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH006','NV004', N'Đang chuẩn bị', '06/04/2023', 0)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH006','NV002', N'Đã giao', '19/03/2023', 442200)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH001','NV003', N'Giao không thành công', '28/04/2023', 0)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH004','NV002', N'Đang vận chuyển', '10/04/2023', 0)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH002','NV004', N'Đang chuẩn bị', '26/04/2023', 0)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH001','NV002', N'Đã giao', '22/05/2023', 310300)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH002','NV003', N'Đã giao', '24/05/2023', 1599400)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH006','NV004', N'Đã giao', '26/03/2023', 125400)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH006','NV002', N'Đã giao', '29/03/2023', 178200)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH003','NV003', N'Đã giao', '01/01/2023', 253000)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH005','NV002', N'Đã giao', '12/01/2023', 0)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH004','NV003', N'Đã giao', '18/01/2023', 107000)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH005','NV004', N'Đã giao', '23/01/2023', 112350)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH006','NV004', N'Đã giao', '02/02/2023', 165000)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH006','NV003', N'Đang chuẩn bị', '09/02/2023', 0)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH006','NV002', N'Đang vận chuyển', '20/02/2023', 0)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH006','NV003', N'Đang chuẩn bị', '06/03/2023', 0)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH006','NV003', N'Đã giao', '19/03/2023', 275000)
INSERT INTO DONHANGXUAT(MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
      VALUES ('KH001','NV004', N'Giao không thành công', '28/03/2023', 0)

--thêm dữ liệu cho bảng nhập thuốc
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN001', 'HCM-X4-25', 30, '10/12/2022', '29/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN001', 'HCM-X4-79', 30, '10/12/2022', '29/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN002', 'HCM-X2-16', 40, '01/12/2022', '01/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN002', 'HCM-X2-164', 30, '03/02/2022', '03/02/2024')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN002', 'HCM-X2-198', 50, '12/01/2022', '12/01/2024')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN003', 'BN.TS2-15', 25,'13/01/2022', '13/01/2024')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN003', 'BN.TS2-51', 40, '20/12/2022', '20/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN003', 'ETT-163', 30, '12/12/2022', '12/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN003', 'ETT-165', 40, '12/12/2022', '12/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN003', 'ETT-50', 30, '12/12/2022', '12/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN003', 'ETT-94', 40, '12/12/2022', '12/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN003', 'GDA-10', 20, '12/12/2022', '12/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN004', 'CME-3', 20, '30/11/2022', '30/11/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN004', 'LBF-1', 30, '30/11/2022', '30/11/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN004', 'SAK-118', 50, '28/11/2022', '28/11/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN004', 'SAK-169', 20, '28/11/2022', '28/11/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN004', 'SAK-185', 40, '28/11/2022', '28/11/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN004', 'SAK-37', 60, '28/11/2022', '28/11/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN005', 'BD.TS5-19', 30, '23/12/2022', '23/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN005', 'BD.TS5-4', 20, '23/12/2022', '23/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN005', 'BD.TS5-5', 20, '20/12/2022', '20/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN006', 'UV-2', 30, '10/01/2023', '10/01/2024')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN006', 'UV-65', 50, '10/01/2023', '10/01/2024')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN007', 'HCM-X4-25', 20, '02/12/2022', '02/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN007', 'HCM-X4-79', 40, '02/12/2022', '08/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN008', 'HCM-X2-16', 30, '07/12/2022', '07/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN008', 'HCM-X2-164', 10, '24/12/2022', '24/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN009', 'ETT-163', 20, '19/06/2022', '19/06/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN009', 'ETT-165', 20, '19/06/2022', '19/06/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN009', 'BN.TS2-15', 20, '15/12/2022', '15/01/2024')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN009', 'BN.TS2-51', 20, '17/12/2022', '17/01/2024')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN010', 'SAK-118', 30, '02/12/2022', '02/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN010', 'SAK-185', 10, '02/12/2022', '02/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN011', 'BD.TS5-19', 30, '11/11/2022', '11/11/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN011', 'BD.TS5-5', 10, '11/11/2022', '11/11/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN012', 'UV-65', 10, '07/12/2022', '07/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN012', 'UV-2', 10, '07/12/2022', '07/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN013', 'HCM-X4-25', 30, '07/12/2022', '07/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN013', 'HCM-X4-79', 10, '02/12/2022', '02/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN014', 'HCM-X2-16', 30, '02/12/2022', '02/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN014', 'HCM-X2-198', 10, '02/12/2022', '02/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN015', 'ETT-50', 10, '07/12/2022', '07/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN015', 'BN.TS2-51', 10, '07/12/2022', '07/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN016', 'HCM-X2-164', 30, '07/12/2022', '07/12/2023')
INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG, NGAYSX, NGAYHETHAN)
      VALUES ('DN016', 'HCM-X2-198', 10, '07/12/2022', '05/12/2023')


--thêm dữ liệu cho bảng xuất thuốc
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX001', 'HCM-X4-25', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX001', 'HCM-X4-79', 3)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX002', 'UV-65', 1)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX002', 'HCM-X4-25', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX003', 'HCM-X4-79', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX004', 'HCM-X2-16', 3)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX004', 'HCM-X2-164', 1)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX005', 'ETT-163', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX006', 'ETT-165', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX007', 'BN.TS2-15', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX007', 'BN.TS2-51', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX007', 'SAK-118', 3)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX008', 'SAK-185', 1)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX008', 'HCM-X4-25', 3)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX009', 'HCM-X4-79', 1)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX009', 'HCM-X2-16', 1)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX010', 'HCM-X2-164', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX010', 'HCM-X2-198', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX011', 'ETT-163', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX011', 'ETT-165', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX012', 'UV-65', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX012', 'BN.TS2-15', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX013', 'BN.TS2-15', 3)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX013', 'BN.TS2-51', 1)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX013', 'ETT-163', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX014', 'LBF-1', 3)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX014', 'SAK-118', 1)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX015', 'SAK-169', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX016', 'SAK-185', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX016', 'SAK-37', 3)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX017', 'ETT-165', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX017', 'ETT-50', 3)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX018', 'ETT-94', 4)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX018', 'GDA-10', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX019', 'CME-3', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX020', 'LBF-1', 3)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX020', 'SAK-118', 1)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX021', 'SAK-169', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX021', 'SAK-185', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX022', 'SAK-37', 3)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX023', 'HCM-X4-25', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX024', 'HCM-X4-79', 3)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX025', 'UV-65', 1)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX026', 'HCM-X4-25', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX026', 'HCM-X4-79', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX027', 'BD.TS5-19', 1)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX027', 'BD.TS5-4', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX028', 'BD.TS5-5', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX028', 'UV-2', 3)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX029', 'UV-65', 1)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX029', 'HCM-X4-25', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX030', 'HCM-X4-79', 2)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX030', 'HCM-X2-16', 3)
INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
      VALUES ('DX030', 'HCM-X2-164', 1)

--thêm dữ liệu vào bảng TAIKHOAN
INSERT INTO TAIKHOAN
      VALUES ('ouoctiiai', '12345678', 'luphi2612@gmail.com', 0)
INSERT INTO TAIKHOAN
      VALUES ('tanle', '78787878', 'tanle@gmail.com', 0)
INSERT INTO TAIKHOAN
      VALUES ('idolTruong', '987654321', 'ductruong@gmail.com', 0)
INSERT INTO TAIKHOAN
      VALUES ('vtttruc', 'matkhau', 'thanhtruc23@gmail.com', 0)
INSERT INTO TAIKHOAN
      VALUES ('vuthien', 'lamgicomatkhau', 'anhtraimua@gmail.com', 0)
INSERT INTO TAIKHOAN
      VALUES ('baongocc', 'bahoangjavascript', 'bpbn@gmail.com', 0)
INSERT INTO TAIKHOAN
      VALUES ('baongann', 'bahoanhtml', 'html@gmail.com', 0)

--thêm dữ liệu vào bảng GIOHANG
INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG)
      VALUES ('ouoctiiai', 'HCM-X4-25', 3)
INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG)
      VALUES ('ouoctiiai', 'HCM-X2-198', 2)
INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG)
      VALUES ('ouoctiiai', 'BN.TS2-51', 3)
INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG)
      VALUES ('tanle', 'BD.TS5-4', 1)
INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG)
      VALUES ('tanle', 'ETT-165', 5)
INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG)
      VALUES ('tanle', 'SAK-118', 1)
INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG)
      VALUES ('idolTruong', 'GDA-10', 2)
INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG)
      VALUES ('idolTruong', 'LBF-1', 2)
INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG)
      VALUES ('idolTruong', 'ETT-94', 3)
INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG)
      VALUES ('vtttruc', 'CME-3', 2)
INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG)
      VALUES ('vtttruc', 'HCM-X4-25', 1)
INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG)
      VALUES ('vuthien', 'HCM-X2-198', 4)
INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG)
      VALUES ('vuthien', 'SAK-118', 4)
INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG)
      VALUES ('baongocc', 'BD.TS5-19', 5)
INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG)
      VALUES ('baongocc', 'BN.TS2-15', 1)
INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG)
      VALUES ('baongocc', 'HCM-X2-164', 2)
INSERT INTO GIOHANG (USERNAME, MATHUOC, SOLUONG)
      VALUES ('baongann', 'GDA-10', 3)

--thêm dữ liệu vào bảng đơn hàng online
INSERT INTO DONHANGONLINE (USERNAME, DIENTHOAI, DIACHI, TRANGTHAIDH, TONGTIEN)
      VALUES ('ouoctiiai', '0985206123', N'123 Lê Trọng Tấn', N'Đang lập đơn', 0)
INSERT INTO DONHANGONLINE (USERNAME, DIENTHOAI, DIACHI, TRANGTHAIDH, TONGTIEN)
      VALUES ('idolTruong', '0375833381', N'655 Tân Trụ', N'Đang lập đơn', 0)
INSERT INTO DONHANGONLINE (USERNAME, DIENTHOAI, DIACHI, TRANGTHAIDH, TONGTIEN)
      VALUES ('vuthien', '0392162671', N'48 Đỗ Nhuận', N'Đang lập đơn', 0)
INSERT INTO DONHANGONLINE (USERNAME, DIENTHOAI, DIACHI, TRANGTHAIDH, TONGTIEN)
      VALUES ('baongocc', '0389713558', N'254 Trường Chinh', N'Đang lập đơn', 0)

--thêm dữ liệu vào bảng đơn xuất online chi tiết
INSERT INTO DONXUATONLINECHITIET (MADONHANG, THUOC)
      VALUES ('DHO001', 'HCM-X4-25')
INSERT INTO DONXUATONLINECHITIET (MADONHANG, THUOC)
      VALUES ('DHO001', 'HCM-X2-198')
INSERT INTO DONXUATONLINECHITIET (MADONHANG, THUOC)
      VALUES ('DHO004', 'BD.TS5-19')
INSERT INTO DONXUATONLINECHITIET (MADONHANG, THUOC)
      VALUES ('DHO002', 'LBF-1')
INSERT INTO DONXUATONLINECHITIET (MADONHANG, THUOC)
      VALUES ('DHO002', 'ETT-94')
INSERT INTO DONXUATONLINECHITIET (MADONHANG, THUOC)
      VALUES ('DHO003', 'SAK-118')

-- thêm dữ liệu bảng PROFILEPICTURE
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('BD.TS5-19', 'profile_pic-BD.TS5-19-MD_Protect.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('BD.TS5-4', 'profile_pic-BD.TS5-4-Selenvit-E.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('BD.TS5-5', 'profile_pic-BD.TS5-5-MD_Bio_Calcium.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('BN.TS2-15', 'profile_pic-BN.TS2-15-ECO-Doxyfish_Power_20.png')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('BN.TS2-51', 'profile_pic-BN.TS2-51-Iodin-200.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('CME-3', N'profile_pic-CME-3-Vắc_xin_PRRS_JXA1-R.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('ETT-163', 'profile_pic-ETT-163-Dental_Creme_3.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('ETT-165', 'profile_pic-ETT-165-Progesterone.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('ETT-50', 'profile_pic-ETT-50-Eco-Terra_egg.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('ETT-94', 'profile_pic-ETT-94-ECO_Erycol_10.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('GDA-10', 'profile_pic-GDA-10-NVDC-JXA1-Strain.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('HCM-X2-16', 'profile_pic-HCM-X2-16-Fe-Dextran_B12.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('HCM-X2-164', 'profile_pic-HCM-X2-164-Tylosin-200.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('HCM-X2-198', 'profile_pic-HCM-X2-198-Tia-K.C.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('HCM-X4-25', 'profile_pic-HCM-X4-25-Terramycin_Egg_Formula.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('HCM-X4-79', 'profile_pic-HCM-X4-79-Bio-Anticoc.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('LBF-1', 'profile_pic-LBF-1-Foot_And_Mouth_Disease_Vaccine.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('SAK-118', 'profile_pic-SAK-118-Sakan-Fipr.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('SAK-169', 'profile_pic-SAK-169-Amitraz.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('SAK-185', 'profile_pic-SAK-185-Funguikur.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('SAK-37', 'profile_pic-SAK-37-Flormax.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('UV-2', 'profile_pic-UV-2-APA-PLANKTON_FISH.jpg')
INSERT INTO PROFILEPICTURE(MATHUOC, TENANH)
      VALUES ('UV-65', 'profile_pic-UV-65-RODO-UV.jpg')

-- thêm dữ liệu cho bảng ALBUMPICTURE
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('BD.TS5-19', 'pic-BD.TS5-19-MD_Protect_2.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('BD.TS5-4', 'pic-BD.TS5-4-Selenvit-E_2.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('BD.TS5-5', 'pic-BD.TS5-5-MD_Bio_Calcium.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('BN.TS2-15', 'pic-BN.TS2-15-ECO-Doxyfish_Power_20.png')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('BN.TS2-51', 'pic-BN.TS2-51-Iodin-200.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('BN.TS2-51', 'pic-BN.TS2-51-Iodin-200_1.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('BN.TS2-51', 'pic-BN.TS2-51-Iodin-200_2.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('CME-3', N'pic-CME-3-Vắc_xin_PRRS_JXA1-R_2.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('CME-3', N'pic-CME-3-Vắc_xin_PRRS_JXA1-R_3.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('ETT-163', 'pic-ETT-163-Dental_Creme_2.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('ETT-163', 'pic-ETT-163-Dental_Creme.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('ETT-165', 'pic-ETT-165-Progesterone_2.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('ETT-165', 'pic-ETT-165-Progesterone.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('ETT-50', 'pic-ETT-50-Eco-Terra_egg_2.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('ETT-94', 'pic-ETT-94-ECO_Erycol_10.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('GDA-10', 'pic-GDA-10-NVDC-JXA1-Strain-2.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('GDA-10', 'pic-GDA-10-NVDC-JXA1-Strain.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('HCM-X2-16', 'pic-Fe-HCM-X2-16-Dextran_B12_1.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('HCM-X2-16', 'pic-Fe-HCM-X2-16-Dextran_B12_2.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('HCM-X2-16', 'pic-Fe-HCM-X2-16-Dextran_B12_3.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('HCM-X2-164', 'pic-HCM-X2-164-Tylosin-200_2.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('HCM-X2-164', 'pic-HCM-X2-164-Tylosin-200_3.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('HCM-X2-198', 'pic-HCM-X2-198-Tia-K.C_2.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('HCM-X2-198', 'pic-HCM-X2-198-Tia-K.C_3.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('HCM-X4-25', 'pic-HCM-X4-25-Terramycin_Egg_Formula_2.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('HCM-X4-25', 'pic-HCM-X4-25-Terramycin_Egg_Formula_3.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('HCM-X4-79', 'pic-HCM-X4-79-Bio-Anticoc.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('LBF-1', 'pic-LBF-1-Foot_And_Mouth_Disease_Vaccine_2.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('SAK-118', 'pic-SAK-118-Sakan-Fipr_2.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('SAK-118', 'pic-SAK-118-Sakan-Fipr_3.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('SAK-169', 'pic-SAK-169-Amitraz_2.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('SAK-169', 'pic-SAK-169-Amitraz.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('SAK-185', 'pic-SAK-185-Funguikur_3.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('SAK-185', 'pic-SAK-185-Funguikur_1.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('SAK-37', 'pic-SAK-37-Flormax_2.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('UV-2', 'pic-UV-2-APA-PLANKTON_FISH.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('UV-65', 'pic-UV-65-RODO-UV_2.jpg')
INSERT INTO ALBUMPICTURES(MATHUOC, TENALBUM)
      VALUES ('UV-65', 'pic-UV-65-RODO-UV_3.jpg')
GO

---------------------------------------------------TRUY VẤN-------------------------------------------------------------


--xuất danh sách phiếu bán hàng
SELECT * FROM PhieuBanHang

--xuất danh sách phiếu mua hàng
SELECT * from PhieuMuaHang

--báo cáo đơn nhập chi tiết của DN006
EXEC usp_DonNhapChiTiet 'DN006'

--báo cáo đơn xuất chi tiết của DX007
EXEC usp_DonXuatChiTiet 'DX007'

--báo cáo đơn online chi tiết của DHO001
EXEC usp_DonOnlineChiTiet 'DHO001'

--báo cáo công nợ khách hàng
SELECT * FROM CongNoKhachHang

--báo cáo công nợ nhà cung cấp
SELECT * FROM CongNoNCC

--Báo cáo tồn kho
SELECT * FROM TonKho

--tính số tiền thu lại
SELECT SUM(DATHANHTOAN) FROM DONHANGXUAT

--tính doanh thu năm 2023
PRINT dbo.UF_TinhDoanhThuTheoNam(2023)

--tính doanh thu tháng 4 năm 2023
PRINT dbo.UF_TinhDoanhThuTheoThang(4, 2023)

--tính doanh thu quý 2 năm 2023
PRINT dbo.UF_TinhDoanhThuTheoQuy(2, 2023)

--danh sách nhập hàng năm 2022
SELECT * FROM dbo.UF_DanhSachNhapHangTheoNam(2022)

--danh sách nhập hàng tháng 4 năm 2023
SELECT * FROM dbo.UF_DanhSachNhapHangTheoThang(4, 2023)

--danh sách nhập hàng quý 1 năm 2023
SELECT * FROM dbo.UF_DanhSachNhapHangTheoQuy(1, 2023)

--thông báo công nợ với nhà cung cấp quá 3 tháng
SELECT * FROM CongNoNCC
WHERE GETDATE() > DATEADD(MONTH, 3, HANNO)

--thông báo công nợ với nhà cung cấp quá 3 tháng
SELECT * FROM CongNoKhachHang
WHERE GETDATE() > DATEADD(MONTH, 3, HANNO)

--thông báo danh mục thuốc sắp hết hạn(2 tháng)
SELECT * FROM KHOHANG
WHERE DATEDIFF(MONTH, GETDATE(), NGAYHETHAN) < 2

--đếm số lượng sản phẩm trong kho dựa theo loài sử dụng
SELECT LOAISD, (
    SELECT  SUM(TONKHO) FROM KHOHANG K
    WHERE K.MATHUOC IN (
        SELECT MATHUOC FROM THUOC T1
        WHERE T1.LOAISD = T.LOAISD
    )
) AS SOLUONGTHUOC FROM THUOC T
GROUP BY LOAISD

--đếm số lượng sản phẩm trong kho dựa theo dạng bào chế
SELECT DANGBAOCHE, (
    SELECT  SUM(TONKHO) FROM KHOHANG K
    WHERE K.MATHUOC IN (
        SELECT MATHUOC FROM THUOC T1
        WHERE T1.DANGBAOCHE = T.DANGBAOCHE
    )
) AS SOLUONGTHUOC FROM THUOC T
GROUP BY DANGBAOCHE

--xuất nhà cung cấp có nhiều hơn 3 giao dịch
SELECT * FROM NHACUNGCAP N
WHERE 3 < (
    SELECT COUNT(*) FROM DONHANGNHAP D
    WHERE D.MANCC = N.MANCC
)

--thay đổi trạng thái cho một đơn hàng
UPDATE DONHANGNHAP
SET TRANGTHAIDH = N'Đã Nhận'
WHERE MADONHANG = 'DN011'

--Thay đổi loại khách hàng từ khách lẻ thành khách sỉ cho những khách hàng mua trên 5 đơn hàng ngoại trừ khách vãng lai
UPDATE KHACHHANG
SET LOAIKH = N'Khách sỉ'
WHERE MAKH IN (
    SELECT MAKH
    FROM (
        SELECT MAKH, COUNT(*) AS DONHANG_COUNT
        FROM DONHANGXUAT
        WHERE TENKHACH != N'Khách vãng lai'
        GROUP BY MAKH
    ) AS DONHANG_TABLE
    WHERE DONHANG_COUNT > 5
)

--Báo cáo thu tiền tổng hợp
SELECT * FROM dbo.BangThuTien

--Báo cáo chi tiền tổng hợp
SELECT * FROM dbo.BangChiTien

--Xuất những đơn mua hàng của khách sỉ
SELECT MADONHANG, TENKHACH, LOAIKH, TRANGTHAIDH, NGAYLAP, TONGTIEN, D.CONGNO, dbo.UF_HanNoKH(D.NGAYLAP, K.LOAIKH, D.CONGNO) AS HANNO 
FROM DONHANGXUAT D JOIN KHACHHANG K
	  ON D.MAKH = K.MAKH
	  AND K.LOAIKH = N'Khách sỉ'

--Tìm nhà cung cấp có số lượng thuốc đã cung cấp nhiều nhất trong kho
SELECT TOP 1 N.MANCC, N.TENNCC, COUNT(*) AS SOLUONG FROM NHACUNGCAP N JOIN DONHANGNHAP D
ON N.MANCC = D.MANCC
JOIN NHAPTHUOC NCC
ON D.MADONHANG = NCC.MADONHANG
GROUP BY N.MANCC, N.TENNCC
ORDER BY SOLUONG DESC

--Báo cáo đơn hàng xuất
SELECT * FROM DONHANGXUAT

-- Báo cáo lược sử giao dịch với khách hàng có mã là KH001
EXEC usp_LuocSuGiaoDichKH 'KH001'

-- Trả nợ, chi tiền nhà cung cấp cho đơn hàng  SELECT * FROM DONHANGNHAP
EXEC usp_TraNoNhaCungCap '0102137268'

--thanh toán công nợ cho đơn nhập DN013
EXEC usp_ThanhToanCongNoDHN 'DN013'

--thanh toán công nợ cho đơn xuất DX001
EXEC usp_ThanhToanCongNoDHX 'DX001'

-- Báo cáo nhập hàng chi tiết của đơn hàng có mã là DN005
EXEC usp_DonNhapChiTiet 'DN005'

-- Báo cáo lược sử giao dịch với nhà cung cấp có mã là 0305110871
EXEC usp_LuocSuGiaoDichNCC '0305110871'

-- Xuất sản phẩm bán chạy nhất năm 2023
SELECT * FROM dbo.UF_XuatSanPhamBanChayTheoNam(2023)

-- Xuất sản phẩm bán chạy nhất tháng 3 năm 2023
SELECT * FROM dbo.UF_XuatSanPhamBanChayTheoThang(3, 2023)

-- Xuất sản phẩm bán chạy nhất trong quý 1 năm 2023 (tháng 1 2 3 năm 2023)
SELECT * FROM dbo.UF_XuatSanPhamBanChayTheoQuy(1, 2023)

-- Báo cáo danh sách xuất hàng theo năm 2023
SELECT * FROM dbo.UF_DanhSachXuatHangTheoNam(2023)

-- Báo cáo danh sách xuất hàng theo tháng 3/2023
SELECT * FROM dbo.UF_DanhSachXuatHangTheoThang(3, 2023)

-- Báo cáo danh sách xuất hàng theo quý 1/2023
SELECT * FROM dbo.UF_DanhSachXuatHangTheoQuy(1, 2023)

--tìm những đơn hàng xuất do trưởng bộ phận bán hàng lập
SELECT * FROM DONHANGXUAT
WHERE MANV IN (
    SELECT MANV FROM NHANVIEN 
    WHERE VITRI = N'Trưởng bộ phận'    
    AND BOPHAN = N'Bán hàng'
    )

--tìm những đơn hàng do nhân viên bộ phận quản lý lập
SELECT MADONHANG, MANV, TRANGTHAIDH FROM DONHANGNHAP
WHERE MANV IN (
    SELECT MANV FROM NHANVIEN    
    WHERE BOPHAN = N'Quản lý'
    )
UNION
SELECT MADONHANG, MANV, TRANGTHAIDH FROM DONHANGXUAT
WHERE MANV IN (
    SELECT MANV FROM NHANVIEN    
    WHERE BOPHAN = N'Quản lý'
    )


SELECT * FROM DONHANGNHAP
