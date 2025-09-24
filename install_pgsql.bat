@echo off
REM =======================================
REM PostgreSQL Portable Auto Setup - Win10
REM =======================================

setlocal enabledelayedexpansion

:: --- Config ---
set PG_VERSION=16.4
set PG_PATH=C:\pgsql
set PG_DATA=%PG_PATH%\data
set PG_PORT=5432
set PG_USER=postgres

:: --- Link download binaries (Windows x64 zip từ EDB) ---
set PG_URL=https://get.enterprisedb.com/postgresql/postgresql-%PG_VERSION%-1-windows-x64-binaries.zip
set ZIP_FILE=%TEMP%\pgsql.zip

:: --- Check folder ---
if not exist "%PG_PATH%" (
    echo [INFO] Dang tai PostgreSQL %PG_VERSION% binaries...
    powershell -Command "Invoke-WebRequest -Uri '%PG_URL%' -OutFile '%ZIP_FILE%'"

    echo [INFO] Dang giai nen vao %PG_PATH% ...
    powershell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%PG_PATH%'"

    del "%ZIP_FILE%"
)

:: --- Initdb nếu chưa có data ---
if not exist "%PG_DATA%" (
    echo [INFO] Khoi tao data directory...
    "%PG_PATH%\bin\initdb.exe" -D "%PG_DATA%" -U %PG_USER% -A password -W
)

:: --- Start PostgreSQL ---
echo [INFO] Khoi dong PostgreSQL tren port %PG_PORT% ...
"%PG_PATH%\bin\pg_ctl.exe" -D "%PG_DATA%" -l "%PG_PATH%\pgsql.log" -o "-p %PG_PORT%" start

timeout /t 3 >nul

:: --- Ket noi psql ---
echo [INFO] Ket noi PostgreSQL CLI...
"%PG_PATH%\bin\psql.exe" -U %PG_USER% -h localhost -p %PG_PORT% -d postgres

pause
