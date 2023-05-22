# thuocThuY
web + server bán thuốc thú y
Hướng dẫn cài đặt
1. Database
  - B1: Mở port cho SQL server: mở SQL server configuration manager -> SQL server network configuration -> protocols for MSSQLSERVER -> TCP/IP -> enable (restart lại service để nhận thay đổi)
  - B2: Chạy file SQLQueryTHUOC.sql trong folder bằng SQL server
  - B3: config thông tin database tại file src/configs/connectDB.js
2. Cài đặt môi trường và thư viện
  - Node js: v18.6
  -Tại thư mục này, sử dụng lệnh "npm i" bằng cmd để tiến hành cài đặt thư viện
3. Chạy server
  - Sử dụng câu lệnh "npm start" để bắt đầu server
  - mở trình duyệt và truy cập localhost:3000
