@echo off
REM =======================================
REM PostgreSQL Portable Setup Script - Win10
REM =======================================

setlocal enabledelayedexpansion

:: --- Cấu hình ---
set PG_VERSION=16
set PG_PATH=C:\pgsql
set PG_DATA=%PG_PATH%\data
set PG_PORT=5432
set PG_USER=postgres
set PG_PASS=postgres

:: --- Kiểm tra thư mục ---
if not exist "%PG_PATH%" (
    echo [INFO] Chưa có PostgreSQL Portable, hãy giải nén binaries vào %PG_PATH%
    echo [LINK] Tải tại: https://www.enterprisedb.com/download-postgresql-binaries
    pause
    exit /b
)

:: --- Tạo thư mục data nếu chưa có ---
if not exist "%PG_DATA%" (
    echo [INFO] Dang tao thu muc data...
    "%PG_PATH%\bin\initdb.exe" -D "%PG_DATA%" -U %PG_USER% -A password -W <<EOF
%PG_PASS%
%PG_PASS%
EOF
)

:: --- Start PostgreSQL server ---
echo [INFO] Dang khoi dong PostgreSQL tren port %PG_PORT% ...
"%PG_PATH%\bin\pg_ctl.exe" -D "%PG_DATA%" -l "%PG_PATH%\pgsql.log" -o "-p %PG_PORT%" start

:: --- Doi 3s de server len ---
timeout /t 3 /nobreak >nul

:: --- Ket noi psql ---
echo [INFO] Dang ket noi den PostgreSQL...
"%PG_PATH%\bin\psql.exe" -U %PG_USER% -h localhost -p %PG_PORT% -d postgres

pause
