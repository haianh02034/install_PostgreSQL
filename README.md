Init database (chỉ làm 1 lần)

Nếu bạn chưa có folder dữ liệu (C:\pgsql\data), chạy:

C:\pgsql\pgsql\bin\initdb.exe -D C:\pgsql\data -U postgres -A password -W


-D C:\pgsql\data → nơi lưu dữ liệu database

-U postgres → user mặc định

-A password -W → dùng password, bạn nhập postgres hoặc mật khẩu bạn muốn

Sau lệnh xong, sẽ tạo ra cluster dữ liệu.


Chạy start_pgsql.bat → PostgreSQL server chạy nền.
Chạy stop_pgsql.bat → dừng server nhanh gọn.
