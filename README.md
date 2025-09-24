Chạy install_pgsql.bat để cài đặt pgsql 16 cho winx64 

Init database (chỉ làm 1 lần)

Nếu bạn chưa có folder dữ liệu (C:\pgsql\data), chạy:

C:\pgsql\pgsql\bin\initdb.exe -D C:\pgsql\data -U postgres -A password -W


-D C:\pgsql\data → nơi lưu dữ liệu database

-U postgres → user mặc định

-A password -W → dùng password, bạn nhập postgres hoặc mật khẩu bạn muốn  (vd: 123@123a )

Sau lệnh xong, sẽ tạo ra cluster dữ liệu.

Cập nhật set PG_PASS=123@123a trong start_pgsql.bat

Chạy start_pgsql.bat → PostgreSQL server chạy nền + mở psql CLI

Chạy stop_pgsql.bat → dừng server nhanh gọn.
