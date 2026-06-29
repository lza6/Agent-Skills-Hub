@echo off
chcp 65001 >nul
echo.
echo  Agent Skills Hub - 总安装（基础226 + Wave1-11）
echo  预计 30-90 分钟，请保持网络畅通
echo.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install-all-skills-total.ps1"
echo.
pause
