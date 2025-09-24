@echo off
REM ===========================================
REM Auto start PostgreSQL and open CLI
REM ===========================================

setlocal enabledelayedexpansion

:: --- Cấu hình ---
set PG_ROOT=C:\pgsql
set PG_DATA=%PG_ROOT%\data
set PG_PORT=5432
set PG_USER=postgres
set PG_DB=postgres
set PG_PASS=postgres

:: --- Tìm thư mục bin ---
set BIN_PATH=
for /d %%D in ("%PG_ROOT%\*") do (
    if exist "%%D\bin\initdb.exe" set BIN_PATH=%%D\bin
)
if not defined BIN_PATH (
    echo [ERROR] Khong tim thay thu muc bin trong %PG_ROOT%
    pause
    exit /b
)
echo [INFO] Su dung bin folder: %BIN_PATH%

:: --- Thêm bin vào PATH ---
set PATH=%BIN_PATH%;%PATH%

:: --- Init database nếu chưa có ---
if not exist "%PG_DATA%" (
    echo [INFO] Chua co data folder, khoi tao database...
    "%BIN_PATH%\initdb.exe" -D "%PG_DATA%" -U %PG_USER% -A password -W
    if errorlevel 1 (
        echo [ERROR] Init database khong thanh cong.
        pause
        exit /b
    )
)

:: --- Kiểm tra server đã chạy chưa ---
netstat -ano | findstr :%PG_PORT% >nul
if errorlevel 1 (
    echo [INFO] Server chua chay, dang start PostgreSQL...
    "%BIN_PATH%\pg_ctl.exe" -D "%PG_DATA%" -l "%PG_ROOT%\pgsql.log" -o "-p %PG_PORT%" start
    timeout /t 3 >nul
) else (
    echo [INFO] Server da dang chay tren port %PG_PORT%
)

:: --- Xuất password để psql không hỏi ---
set PGPASSWORD=%PG_PASS%

:: --- Mở PostgreSQL CLI ---
echo [INFO] Dang ket noi PostgreSQL CLI...
psql.exe -U %PG_USER% -h localhost -p %PG_PORT% -d %PG_DB%

if errorlevel 1 (
    echo [ERROR] Khong ket noi duoc den PostgreSQL.
)

pause
