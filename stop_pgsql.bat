@echo off
REM ================================
REM Stop PostgreSQL Portable Server
REM ================================

set PG_PATH=C:\pgsql
set PG_DATA=%PG_PATH%\data

echo [INFO] Dang dung PostgreSQL...
"%PG_PATH%\bin\pg_ctl.exe" -D "%PG_DATA%" stop -m fast

echo [DONE] PostgreSQL da dung thanh cong!
pause
