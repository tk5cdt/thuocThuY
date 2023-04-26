CREATE DATABASE QL_NHATHUOCTY
GO

USE QL_NHATHUOCTY
GO

SET DATEFORMAT DMY

CREATE TABLE THUOC
(
    MATHUOC VARCHAR(10) NOT NULL,
    TENTHUOC NVARCHAR(30),
    MANHOM VARCHAR(5),
    LOAISD NVARCHAR(10),
    THANHPHAN NVARCHAR(40),
    MANCC VARCHAR(10),
    GIASI MONEY,
    GIALE MONEY,
    GIANHAP MONEY,
    DANGBAOCHE NVARCHAR(20),
    QCDONGGOI VARCHAR(10),
    CONGDUNG NVARCHAR(100),
    PRIMARY KEY(MATHUOC)
)

CREATE TABLE NHOMTHUOC
(
    MANHOM VARCHAR(5) NOT NULL,
    TENNHOM NVARCHAR(20),
    SOLUONG INT,
    PRIMARY KEY(MANHOM)
)

CREATE TABLE NHACUNGCAP
(
    MANCC VARCHAR(10) NOT NULL,
    TENNCC NVARCHAR(50),
    DIACHI NVARCHAR(80),
    DIENTHOAI NCHAR(11),
    CONGNO MONEY,
    PRIMARY KEY(MANCC)
)

CREATE TABLE NHANVIEN
(
    MANV VARCHAR(10) NOT NULL,
    TENNV NVARCHAR(50),
    NGAYSINH DATE,
    VANBANG NVARCHAR(30),
    DIACHI NVARCHAR(80),
    PHAI NVARCHAR(3),
    VITRI NVARCHAR(15),
    BOPHAN NVARCHAR(15),
    PRIMARY KEY(MANV)
)

CREATE TABLE KHACHHANG
(
    MAKH VARCHAR(10) NOT NULL,
    TENKHACH NVARCHAR(30),
    DIACHI NVARCHAR(80),
    DIENTHOAI NCHAR(11),
    LOAIKH NVARCHAR(15),
    CONGNO MONEY,
    PRIMARY KEY(MAKH)
)

CREATE TABLE DONHANGXUAT
(
    MADONHANG VARCHAR(10) NOT NULL,
    MAKH VARCHAR(10),
    MANV VARCHAR(10),
    TRANGTHAIDH  NVARCHAR(30),
    NGAYLAP DATE,
    TONGTIEN MONEY,
    DATHANHTOAN MONEY,
    CONGNO MONEY
    PRIMARY KEY(MADONHANG)
)

CREATE TABLE DONHANGNHAP
(
    MADONHANG VARCHAR(10) NOT NULL,
    MANCC VARCHAR(10),
    TRANGTHAIDH  NVARCHAR(30),
    NGAYLAP DATE,
    TONGTIEN MONEY,
    DATHANHTOAN MONEY,
    CONGNO MONEY
    PRIMARY KEY(MADONHANG)
)

CREATE TABLE NHAPTHUOC
(
    MADONHANG VARCHAR(10) NOT NULL,
    THUOC VARCHAR(10) NOT NULL,
    SOLUONG INT,
    DONVITINH NVARCHAR(10),
    THANHTIEN MONEY
    PRIMARY KEY(MADONHANG, THUOC)
)

CREATE TABLE XUATTHUOC
(
    MADONHANG VARCHAR(10) NOT NULL,
    THUOC VARCHAR(10) NOT NULL,
    SOLUONG INT,
    DONVITINH NVARCHAR(10),
    THANHTIEN MONEY
    PRIMARY KEY(MADONHANG, THUOC)
)

CREATE TABLE KHOHANG
(
    MATHUOC VARCHAR(10) NOT NULL,
    LANNHAP INT,
    NGAYNHAP DATE,
    NGAYSX DATE,
    NGAYHETHAN DATE,
    SOLUONG INT
    PRIMARY KEY(MATHUOC, LANNHAP)
)

ALTER TABLE THUOC
ADD CONSTRAINT FK_THUOC_NHOMTHUOC FOREIGN KEY(MANHOM)
REFERENCES NHOMTHUOC(MANHOM)
GO

ALTER TABLE THUOC
ADD CONSTRAINT FK_THUOC_NHACC FOREIGN KEY(MANCC)
REFERENCES NHACUNGCAP(MANCC)
GO

ALTER TABLE DONHANGXUAT
ADD CONSTRAINT FK_DONHANGXUAT_KHACHHANG FOREIGN KEY(MAKH)
REFERENCES KHACHHANG(MAKH)
GO

ALTER TABLE DONHANGXUAT
ADD CONSTRAINT FK_DONHANGXUAT_NHANVIEN FOREIGN KEY(MANV)
REFERENCES NHANVIEN(MANV)
GO

ALTER TABLE DONHANGNHAP
ADD CONSTRAINT FK_DONHANGNHAP_NHACUNGCAP FOREIGN KEY(MANCC)
REFERENCES NHACUNGCAP(MANCC)
GO

ALTER TABLE KHOHANG
ADD CONSTRAINT FK_KHOHANG_THUOC FOREIGN KEY(MATHUOC)
REFERENCES THUOC(MATHUOC)
GO

ALTER TABLE XUATTHUOC
ADD CONSTRAINT FK_XUATTHUOC_DONHANGXUAT FOREIGN KEY(MADONHANG)
REFERENCES DONHANGXUAT(MADONHANG)
GO

ALTER TABLE NHAPTHUOC
ADD CONSTRAINT FK_NHAPTHUOC_DONHANGNHAP FOREIGN KEY(MADONHANG)
REFERENCES DONHANGNHAP(MADONHANG)
GO

ALTER TABLE XUATTHUOC
ADD CONSTRAINT FK_XUATTHUOC_THUOC FOREIGN KEY(THUOC)
REFERENCES THUOC(MATHUOC)
GO

ALTER TABLE NHAPTHUOC
ADD CONSTRAINT FK_NHAPTHUOC_THUOC FOREIGN KEY(THUOC)
REFERENCES THUOC(MATHUOC)
GO

INSERT INTO NHOMTHUOC(MANHOM, TENNHOM)
VALUES ('N001', N'Chế phẩm sinh học'),
       ('N002', N'Dược phẩm'),
       ('N003', N'Vaccine'),
       ('N004', N'Hóa chất thú y'),
       ('N005', N'Vi sinh vật')

INSERT INTO NHACUNGCAP(MANCC, TENNCC, DIACHI, DIENTHOAI)
VALUES ('3600278732', N'Công ty TNHH Minh Huy', N'Số 528 đường 21 tháng 4, Phường Xuân Bình, Thành phố Long khánh, Đồng Nai', '02513876071'),
       ('0311987413', N'Công ty cổ phần Sài Gòn V.E.T', N'Số 315 đường Nam Kỳ Khởi Nghĩa, Phường 17, Quận 3, TP.HCM', '0838466888'),
       ('0102137268', N'Công ty cổ phần thuốc thú y Toàn Thắng', N'Số 9 A3, đường Láng, Phường Láng Thượng, Đống Đa, Hà Nội', '0102137268'),
       ('0105298457', N'Công ty đầu tư và phát triển công nghệ Sakan VN', N'Lô D1+D2+D3+D4, Xã Đông Thọ, Yên Phong, Bắc Ninh', '0105298457'),
       ('0301460240', N'Công ty TM & SX thuốc thú Thịnh Á', N'220 Phạm Thế Hiển, Phường 2, Quận 8, Thành phố Hồ Chí Minh', '02838515503'),
       ('0305110871', N'Công ty cổ phần UV', N'Lô số 18, Đường D1, khu công nghiệp An Hạ, Xã Phạm Văn Hai, Bình Chánh, TP.HCM', '02837685370')

INSERT INTO THUOC(MATHUOC, TENTHUOC, MANHOM, LOAISD, THANHPHAN, MANCC, GIANHAP, DANGBAOCHE, QCDONGGOI, CONGDUNG)
VALUES ('HCM-X4-25', N'Terramycin Egg Formula', 'N001', N'Gia cầm', N'Oxytetracyclin, Vitamin A, C, D, E, B1' ,'3600278732', 50000, N'Bột', N'Lọ 100g', N'Nâng cao năng suất trứng, phòng các bệnh ở gia cầm.'),
       ('HCM-X4-79', N'Anticoc', 'N002', N'Gia cầm', N'Sulfamethoxazol, Diaveridine' ,'3600278732', 35000, N'Bột', N'Gói 100g', N'Phòng và trị bệnh cầu trùng.'),
       ('HCM-X2-16', N'Iron Dextran B12', 'N002', N'Gia súc', N'Sắt, Vitamin B12' ,'0311987413', 50000, N'Dung dịch', N'Lọ 100ml', N'Phòng chống thiếu máu do thiếu sắt.'),
       ('HCM-X2-164', N'Tylosin 200', 'N002', N'Gia súc', N'Tylosin tartrate, Dexamethasone acetate' ,'0311987413', 55000, N'Dung dịch tiêm', N'Lọ 100ml', N'Trị viêm phổi, viêm tử cung, bệnh lepto, viêm ruột'),
       ('HCM-X2-198', N'Tiacotin', 'N002', N'Gia súc', N'Tiamulin hydrogen fumarate' ,'0311987413', 20000, N'Dung dịch', N'Lọ 100ml', N'Trị bệnh đường hô hấp, tiêu hóa.'),
       ('GDA-10', N'NVDC-JXA1 Strain', 'N003', N'Gia súc', N'Virus chủng NVDC-JXA1 vô hoạt' ,'0102137268', 27000, N'Dung dịch tiêm', N'Lọ 100ml', N'Phòng bệnh lợn tai xanh'),
       ('ETT-163', N'ECO Recicort', 'N002', N'Thú cưng', N'Recicort' ,'0102137268', 100000, N'Dung dịch', N'Chai 500ml', N'Trị viêm tai ngoài, viêm da tiết bã nhờn trên chó, mèo.'),
       ('UV-65', N'RODO-UV', 'N005', N'Thủy sản', N'Rhodopseudomonas' ,'0305110871',150000, N'Dung dịch', N'Can 5L', N'Ức chế vi khuẩn gây bệnh trong ao nuôi'),
       ('ETT-165', N'ECO Supprestral', 'N001', N'Thú cưng', N'Progesterone (Medroxy Progesterone)' ,'0102137268', 100000 , N'Dung dịch', N'Chai 500ml', N'Giảm co bóp, ổn định tử cung, an thai trong trường hợp đe dọa sẩy thai'),
       ('SAK-118', N'Sakan-Fipro', 'N004', N'Thú cưng', N'Fipronil' ,'0105298457', 60000, N'Dung dịch', N'Tuýp 20ml', N'Diệt ve, bọ rận, bọ chét và ghẻ trên chó mèo'),
       ('SAK-169', N'HZ-PETLOVE-2', 'N004', N'Thú cưng', N'Amitraz, Ketoconazole' ,'0105298457', 75000, N'Dung dịch', N'Tuýp 20ml', N'Làm mượt lông cho chó, mèo'),
       ('SAK-185', N'Flzazol', 'N002', N'Thú cưng', N'Fluconazol' ,'0105298457', 40000, N'Dung dịch', N'Lọ 50ml', N'Trị nấm gây ra trên chó, mèo.'),
       ('BD.TS5-4', N'MD Selen E.W.S', 'N001', N'Thủy sản', N'Vitamin E, Sodium selenite' ,'0301460240', 300000, N'Viên nén', N'Bao 10kg', N'Giúp tăng sản lượng đẻ trứng ở cá. Cá ương đạt tỷ lệ cao hơn, giảm hao hụt'),
       ('BD.TS5-5', N'MD Bio Calcium', 'N001', N'Thủy sản', N'Biotin, Vitamin A, D3' ,'0301460240', 200000, N'Dung dịch', N'Can 5l', N'Thúc đẩy quá trình lột vỏ ở tôm và giúp mau cứng vỏ sau khi lột.'),
       ('BD.TS5-19', N'MD Protect', 'N004', N'Thủy sản', N'1,5 Pentanedial' ,'0301460240', 200000, N'Dung dịch', N'Can 5 lít', N'Diệt các loại vi khuẩn, nấm, vi sinh động vật trong nước ao nuôi'),
       ('BN.TS2-51', N'ECO-OMICD Fish', 'N004', N'Thủy sản', N'Benzalkonium chloride, Glutaraldehyde' ,'0102137268', 100000, N'Dung dịch', N'Chai 500ml', N'Sát trùng nguồn nước nuôi trồng thủy sản'),
       ('BN.TS2-15', N'ECO-Doxyfish Power 20%', 'N002', N'Thủy sản', N'Doxycyclin' ,'0102137268', 34000, N'Bột', N'Gói 500g', N'Trị bệnh đỏ thân trên tôm do vi khuẩn Vibrio alginolyticus'),
       ('SAK-37', N'Flormax', 'N002', N'Gia súc', N'Doxycycline hyclate, Tylosin tartrate' ,'0105298457', 43000, N'Bột', N'Gói 100g', N'Trị nhiễm trùng đường tiêu hóa, hô hấp trên heo, trâu, bò, dê, cừu.'),
       ('CME-3', N'Vắc xin PRRS JXA1-R', 'N003', N'Gia súc', N'Virus PRRS nhược độc chủng JXA1-R' ,'0105298457',57000, N'Dung dịch tiêm', N'Lọ 50ml', N'Phòng hội chứng rối loạn hô hấp và sinh sản (PRRS) trên heo.'),
       ('LBF-1', N'Foot And Mouth Disease Vaccine', 'N003', N'Gia súc', N'Virus Lở mồm Long móng type O, chủng O' ,'0105298457', 34000, N'Dung dịch tiêm', N'Lọ 100ml', N'Phòng bệnh Lở mồm long móng trên lợn'),
       ('ETT-94', N'ECO Erycol 10', 'N002', N'Gia cầm', N'Erythromycin thiocynat, Colistin sulfate' ,'0102137268', 350000, N'Viên nén', N'Thùng 10kg', N'Trị nhiễm trùng đường tiêu hóa, hô hấp trên vịt, gà, ngan, ngỗng'),
       ('UV-2', N'Ecolus', 'N005', N'Thủy sản', N'Bacillus subtilis, Bacillus megaterium' ,'0305110871', 200000, 'Bột', 'Thùng 5kg', 'Phân hủy nhanh chất thải, phân tôm, xác tảo và thức ăn dư thừa.'),
       ('ETT-50', N'Eco-Terra egg', 'N001', N'Gia cầm', N'Oxytetracyclin, Neomycin' ,'0102137268', 30000, N'Bột', N'Gói 10g', N'Tăng trọng nhanh, giảm tỷ lệ tiêu tốn thức ăn, rút ngắn thời gian nuôi')

UPDATE THUOC
SET GIASI = GIANHAP + GIANHAP * 7/100,
    GIALE = GIANHAP + GIANHAP * 10/100


SET DATEFORMAT DMY
INSERT INTO NHANVIEN
VALUES ('NV001', N'Nguyễn Quốc Thái', '26/12/1989', N'Dược sĩ đại học', N'49/1 Tân Trụ, Phường 15, Quận Tân Bình, TP HCM', N'Nam', N'Nhân viên', N'Kho'),
       ('NV002', N'Cù Đức Trường', '08/07/1994', N'Dược sĩ đại học', N'30/1 TMT 13, Phường Trung Mỹ Tây, Quận 12, TP HCM', N'Nam', N'Trưởng bộ phận', N'Bán hàng'),
       ('NV003', N'Võ Thị Thanh Trúc', '03/07/1990', N'Thạc sĩ', N'193/2/7 Đường Số 6, Phường Bình Hưng Hòa B, Quận Bình Tân, TP HCM', N'Nữ', N'Nhân viên', N'Bán hàng'),
       ('NV004', N'Lê Trương Trọng Tấn', '18/10/1995', N'Dược sĩ đại học', N'18 Tân Thới Nhất 17, Phường Tân Thới Nhất, Quận 12, TP HCM', N'Nam', N'Nhân viên', N'Quản lý')

INSERT INTO KHACHHANG(MAKH, TENKHACH, DIACHI, DIENTHOAI, LOAIKH)
VALUES ('KH001', N'Trần Thành Luân', N'48/1 Đỗ Nhuận, Phường Sơn Kỳ, Quận Tân Phú, TP HCM', '0367512498', N'Khách sỉ'),
       ('KH002', N'Bùi Phan Bảo Ngọc', N'48/1 Đỗ Nhuận, Phường Sơn Kỳ, Quận Tân Phú, TP HCM', '0379699529', N'Khách lẻ'),
       ('KH003', N'Bùi Phan Bảo Ngọc', N'66/9 Trần Văn Quang, Phường 10, Quận Tân Bình, TP HCM', '0334275096', N'Khách lẻ'),
       ('KH004', N'Nguyễn Phan Như Quỳnh', N'48/1 Đỗ Nhuận, Phường Sơn Kỳ, Quận Tân Phú, TP HCM', '0913630913', N'Khách sỉ'),
       ('KH005', N'Huỳnh Vũ Chí Thiện', N'100 Lê Văn Sỹ, Phường 2, Quận Tân Bình, TP HCM', '0908655684', N'Khách sỉ'),
       ('KH006', N'Khách vãn lai', NULL, NULL, N'Khách lẻ')


INSERT INTO DONHANGNHAP(MADONHANG, MANCC, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
VALUES ('DN001', '3600278732', N'Đã nhận', '22/12/2022', 2550000),
       ('DN002', '0311987413', N'Đã nhận', '24/12/2022', 4650000),
       ('DN003', '0102137268', N'Đã nhận', '26/12/2022', 27290000),
       ('DN004', '0105298457', N'Đã nhận', '29/12/2022', 10840000),
       ('DN005', '0301460240', N'Đã nhận', '01/01/2023', 16000000),
       ('DN006', '0305110871', N'Đã nhận', '12/01/2023', 13500000),
       ('DN007', '3600278732', N'Đã nhận', '18/01/2023', 2400000),
       ('DN008', '0311987413', N'Đã nhận', '23/01/2023', 2050000),
       ('DN009', '0102137268', N'Đã nhận', '02/02/2023', 6680000),
       ('DN010', '0105298457', N'Đã nhận', '09/02/2023', 2200000),
       ('DN011', '0301460240', N'Đang vận chuyển', '20/02/2023', 0),
       ('DN012', '0305110871', N'NCC đang chuẩn bị', '06/03/2023', 0),
       ('DN013', '3600278732', N'Đã nhận', '19/03/2023', 1850000),
       ('DN014', '0311987413', N'Giao không thành công', '28/03/2023', 0),
       ('DN015', '0102137268', N'Đang vận chuyển', '10/04/2023', 0),
       ('DN016', '0311987413', N'NCC đang chuẩn bị', '26/04/2023', 0)


INSERT INTO DONHANGXUAT(MADONHANG, MAKH, MANV, TRANGTHAIDH, NGAYLAP, DATHANHTOAN)
VALUES ('DX001', 'KH001','NV002', N'Đã giao', '22/02/2023', 0),
       ('DX002', 'KH002','NV002', N'Đã giao', '24/02/2023', 275000),
       ('DX003', 'KH006','NV003',N'Đã giao', '26/02/2023', 77000),
       ('DX004', 'KH006','NV002', N'Đã giao', '27/02/2023', 225500),
       ('DX005', 'KH003','NV003', N'Đã giao', '01/03/2023', 220000),
       ('DX006', 'KH005','NV003', N'Đã giao', '12/03/2023', 214000),
       ('DX007', 'KH004','NV004', N'Đã giao', '18/03/2023', 0),
       ('DX008', 'KH005','NV004', N'Đã giao', '23/03/2023', 0),
       ('DX009', 'KH006','NV003', N'Đã giao', '02/03/2023', 93500),
       ('DX010', 'KH006','NV002', N'Đã giao', '09/03/2023', 165000),
       ('DX011', 'KH006','NV003', N'Đang vận chuyển', '20/03/2023', 0),
       ('DX012', 'KH006','NV004', N'Đang chuẩn bị', '06/04/2023', 0),
       ('DX013', 'KH006','NV002', N'Đã giao', '19/03/2023', 442200),
       ('DX014', 'KH001','NV003', N'Giao không thành công', '28/04/2023', 0),
       ('DX015', 'KH004','NV002', N'Đang vận chuyển', '10/04/2023', 0),
       ('DX016', 'KH002','NV004', N'Đang chuẩn bị', '26/04/2023', 0),
       ('DX017', 'KH001','NV002', N'Đã giao', '22/05/2023', 310300),
       ('DX018', 'KH002','NV003', N'Đã giao', '24/05/2023', 1599400),
       ('DX019', 'KH006','NV004', N'Đã giao', '26/03/2023', 125400),
       ('DX020', 'KH006','NV002', N'Đã giao', '29/03/2023', 178200),
       ('DX021', 'KH003','NV003', N'Đã giao', '01/01/2023', 253000),
       ('DX022', 'KH005','NV002', N'Đã giao', '12/01/2023', 0),
       ('DX023', 'KH004','NV003', N'Đã giao', '18/01/2023', 107000),
       ('DX024', 'KH005','NV004', N'Đã giao', '23/01/2023', 112350),
       ('DX025', 'KH006','NV004', N'Đã giao', '02/02/2023', 165000),
       ('DX026', 'KH006','NV003', N'Đang chuẩn bị', '09/02/2023', 0),
       ('DX027', 'KH006','NV002', N'Đang vận chuyển', '20/02/2023', 0),
       ('DX028', 'KH006','NV003', N'Đang chuẩn bị', '06/03/2023', 0),
       ('DX029', 'KH006','NV003', N'Đã giao', '19/03/2023', 275000),
       ('DX030', 'KH001','NV004', N'Giao không thành công', '28/03/2023', 0)

INSERT INTO NHAPTHUOC(MADONHANG, THUOC, SOLUONG)
VALUES ('DN001', 'HCM-X4-25', 30),
       ('DN001', 'HCM-X4-79', 30),
       ('DN002', 'HCM-X2-16', 40),
       ('DN002', 'HCM-X2-164', 30),
       ('DN002', 'HCM-X2-198', 50),
       ('DN003', 'BN.TS2-15', 25),
       ('DN003', 'BN.TS2-51', 40),
       ('DN003', 'ETT-163', 30),
       ('DN003', 'ETT-165', 40),
       ('DN003', 'ETT-50', 30),
       ('DN003', 'ETT-94', 40),
       ('DN003', 'GDA-10', 20),
       ('DN004', 'CME-3', 20),
       ('DN004', 'LBF-1', 30),
       ('DN004', 'SAK-118', 50),
       ('DN004', 'SAK-169', 20),
       ('DN004', 'SAK-185', 40),
       ('DN004', 'SAK-37', 60),
       ('DN005', 'BD.TS5-19', 30),
       ('DN005', 'BD.TS5-4', 20),
       ('DN005', 'BD.TS5-5', 20),
       ('DN006', 'UV-2', 30),
       ('DN006', 'UV-65', 50),
       ('DN007', 'HCM-X4-25', 20),
       ('DN007', 'HCM-X4-79', 40),
       ('DN008', 'HCM-X2-16', 30),
       ('DN008', 'HCM-X2-164', 10),
       ('DN009', 'ETT-163', 20),
       ('DN009', 'ETT-165', 20),
       ('DN009', 'BN.TS2-15', 20),
       ('DN009', 'BN.TS2-51', 20),
       ('DN010', 'SAK-118', 30),
       ('DN010', 'SAK-185', 10),
       ('DN011', 'BD.TS5-19', 30),
       ('DN011', 'BD.TS5-5', 10),
       ('DN012', 'UV-65', 10),
       ('DN012', 'UV-2', 10),
       ('DN013', 'HCM-X4-25', 30),
       ('DN013', 'HCM-X4-79', 10),
       ('DN014', 'HCM-X2-16', 30),
       ('DN014', 'HCM-X2-198', 10),
       ('DN015', 'ETT-50', 10),
       ('DN015', 'BN.TS2-51', 10),
       ('DN016', 'HCM-X2-164', 30),
       ('DN016', 'HCM-X2-198', 10)
       

INSERT INTO XUATTHUOC(MADONHANG, THUOC, SOLUONG)
VALUES ('DX001', 'HCM-X4-25', 2),
       ('DX001', 'HCM-X4-79', 3),
       ('DX002', 'UV-65', 1),
       ('DX002', 'HCM-X4-25', 2),
       ('DX003', 'HCM-X4-79', 2),
       ('DX004', 'HCM-X2-16', 3),
       ('DX004', 'HCM-X2-164', 1),
       ('DX005', 'ETT-163', 2),
       ('DX006', 'ETT-165', 2),
       ('DX007', 'BN.TS2-15', 2),
       ('DX007', 'BN.TS2-51', 2),
       ('DX007', 'SAK-118', 3),
       ('DX008', 'SAK-185', 1),
       ('DX008', 'HCM-X4-25', 3),
       ('DX009', 'HCM-X4-79', 1),
       ('DX009', 'HCM-X2-16', 1),
       ('DX010', 'HCM-X2-164', 2),
       ('DX010', 'HCM-X2-198', 2),
       ('DX011', 'ETT-163', 2),
       ('DX011', 'ETT-165', 2),
       ('DX012', 'UV-65', 2),
       ('DX012', 'BN.TS2-15', 2),
       ('DX013', 'BN.TS2-15', 3),
       ('DX013', 'BN.TS2-51', 1),
       ('DX013', 'ETT-163', 2),
       ('DX014', 'LBF-1', 3),
       ('DX014', 'SAK-118', 1),
       ('DX015', 'SAK-169', 2),
       ('DX016', 'SAK-185', 2),
       ('DX016', 'SAK-37', 3),
       ('DX017', 'ETT-165', 2),
       ('DX017', 'ETT-50', 3),
       ('DX018', 'ETT-94', 4),
       ('DX018', 'GDA-10', 2),
       ('DX019', 'CME-3', 2),
       ('DX020', 'LBF-1', 3),
       ('DX020', 'SAK-118', 1),
       ('DX021', 'SAK-169', 2),
       ('DX021', 'SAK-185', 2),
       ('DX022', 'SAK-37', 3),
       ('DX023', 'HCM-X4-25', 2),
       ('DX024', 'HCM-X4-79', 3),
       ('DX025', 'UV-65', 1),
       ('DX026', 'HCM-X4-25', 2),
       ('DX026', 'HCM-X4-79', 2),
       ('DX027', 'BD.TS5-19', 1),
       ('DX027', 'BD.TS5-4', 2),
       ('DX028', 'BD.TS5-5', 2),
       ('DX028', 'UV-2', 3),
       ('DX029', 'UV-65', 1),
       ('DX029', 'HCM-X4-25', 2),
       ('DX030', 'HCM-X4-79', 2),
       ('DX030', 'HCM-X2-16', 3),
       ('DX030', 'HCM-X2-164', 1)

UPDATE NHAPTHUOC
SET DONVITINH = (
    SELECT QCDONGGOI FROM THUOC T
    WHERE NHAPTHUOC.THUOC = T.MATHUOC
    )

UPDATE NHAPTHUOC
SET THANHTIEN = SOLUONG * (
    SELECT GIANHAP FROM THUOC T
    WHERE NHAPTHUOC.THUOC = T.MATHUOC
)

UPDATE XUATTHUOC
SET DONVITINH = (SELECT QCDONGGOI FROM THUOC t
                    WHERE XUATTHUOC.THUOC = T.MATHUOC
                )

UPDATE XUATTHUOC
SET THANHTIEN = SOLUONG * (
        SELECT GIASI FROM THUOC T
        WHERE XUATTHUOC.THUOC = T.MATHUOC
    ) WHERE (
        SELECT MAKH FROM DONHANGXUAT D
        WHERE XUATTHUOC.MADONHANG = D.MADONHANG
        ) IN ( SELECT MAKH FROM KHACHHANG K
            WHERE K.LOAIKH = N'Khách sỉ'
        )

UPDATE XUATTHUOC
SET THANHTIEN = SOLUONG * (
        SELECT GIALE FROM THUOC T
        WHERE XUATTHUOC.THUOC = T.MATHUOC
    ) WHERE (
        SELECT MAKH FROM DONHANGXUAT D
        WHERE XUATTHUOC.MADONHANG = D.MADONHANG
        ) IN ( SELECT MAKH FROM KHACHHANG K
            WHERE K.LOAIKH = N'Khách lẻ'
        )

UPDATE DONHANGNHAP
SET TONGTIEN = (
    SELECT SUM(THANHTIEN) FROM NHAPTHUOC N
    WHERE DONHANGNHAP.MADONHANG = N.MADONHANG
)

UPDATE DONHANGNHAP
SET CONGNO = TONGTIEN - DATHANHTOAN
WHERE TRANGTHAIDH = N'Đã nhận'

UPDATE DONHANGXUAT
SET TONGTIEN = (
    SELECT SUM(THANHTIEN) FROM XUATTHUOC X
    WHERE DONHANGXUAT.MADONHANG = X.MADONHANG
)

UPDATE DONHANGXUAT
SET CONGNO = TONGTIEN - DATHANHTOAN
WHERE TRANGTHAIDH = N'Đã giao'

UPDATE NHACUNGCAP
SET CONGNO = (
    SELECT SUM(d.CONGNO) FROM DONHANGNHAP d
    WHERE NHACUNGCAP.MANCC = D.MANCC
    )

UPDATE KHACHHANG
SET CONGNO = (
    SELECT SUM(d.CONGNO) FROM DONHANGXUAT d
    WHERE KHACHHANG.MAKH = D.MAKH
    )

--SELECT * FROM THUOC
--SELECT * FROM NHOMTHUOC
--SELECT * FROM NHACUNGCAP
--SELECT * FROM KHACHHANG
--SELECT * FROM DONHANGNHAP
--SELECT * FROM DONHANGXUAT
--SELECT * FROM NHAPTHUOC
--SELECT * FROM XUATTHUOC