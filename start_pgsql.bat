@echo off
REM ================================
REM Start PostgreSQL Portable Server
REM ================================

set PG_PATH=C:\pgsql
set PG_DATA=%PG_PATH%\data
set PG_PORT=5432

echo [INFO] Dang khoi dong PostgreSQL tren port %PG_PORT%...
"%PG_PATH%\bin\pg_ctl.exe" -D "%PG_DATA%" -l "%PG_PATH%\pgsql.log" -o "-p %PG_PORT%" start

timeout /t 2 /nobreak >nul
echo [DONE] PostgreSQL da khoi dong thanh cong!
pause
