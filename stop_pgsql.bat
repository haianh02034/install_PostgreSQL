@echo off
REM ===========================================
REM Stop PostgreSQL Server - Windows
REM ===========================================

setlocal enabledelayedexpansion

:: --- Cấu hình ---
set PG_ROOT=C:\pgsql
set PG_DATA=%PG_ROOT%\data

:: --- Tìm thư mục bin ---
set BIN_PATH=
for /d %%D in ("%PG_ROOT%\*") do (
    if exist "%%D\bin\pg_ctl.exe" set BIN_PATH=%%D\bin
)
if not defined BIN_PATH (
    echo [ERROR] Khong tim thay thu muc bin trong %PG_ROOT%
    pause
    exit /b
)
echo [INFO] Su dung bin folder: %BIN_PATH%

:: --- Dừng server ---
echo [INFO] Dang dung PostgreSQL server...
"%BIN_PATH%\pg_ctl.exe" -D "%PG_DATA%" stop -m fast

if errorlevel 1 (
    echo [ERROR] Khong the dung server. Kiem tra server da chay chua.
) else (
    echo [INFO] Server da dung thanh cong.
)

pause
