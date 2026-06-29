# Wave 56: 调试/重构/代理技能
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 56: 调试/重构/代理技能 ===" -ForegroundColor Cyan

# 1. 嵌入式技能 (编译器、调试器、通信总线)
Write-Host "`n[1] Embedded Skills..." -ForegroundColor Yellow
npx skills add https://github.com/zhinkgit/embeddedskills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave56.log

# 2. 调试技能
Write-Host "[2] Debug Skill (Syncause)..." -ForegroundColor Yellow
npx skills add https://github.com/Syncause/debug-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave56.log

# 3. Claude Code 调试模式
Write-Host "[3] ClaudeCode Debug Mode..." -ForegroundColor Yellow
npx skills add https://github.com/lifedever/claudecode-debug-mode -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave56.log

# 4. Linux 内核崩溃调试
Write-Host "[4] Linux Kernel Crash Debug..." -ForegroundColor Yellow
npx skills add https://github.com/crazyss/linux-kernel-crash-debug -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave56.log

# 5. StarRocks 调试技能
Write-Host "[5] StarRocks Debug Skills..." -ForegroundColor Yellow
npx skills add https://github.com/StarRocks/starrocks-debug-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave56.log

# 6. J-Link 调试技能
Write-Host "[6] J-Link Debug Skill..." -ForegroundColor Yellow
npx skills add https://github.com/ylongw/jlink-debug-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave56.log

# 7. Python 重构技能
Write-Host "[7] Python Refactoring Skills..." -ForegroundColor Yellow
npx skills add https://github.com/l-mb/python-refactoring-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave56.log

# 8. 代码重构技能
Write-Host "[8] Code Refactoring Skill..." -ForegroundColor Yellow
npx skills add https://github.com/MuhiminOsim/code-refactoring-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave56.log

# 9. 重构代码异味技能
Write-Host "[9] Refactoring Code Smells Skills..." -ForegroundColor Yellow
npx skills add https://github.com/45ck/refactoring-code-smells-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave56.log

# 10. 自动重构
Write-Host "[10] Autorefactor..." -ForegroundColor Yellow
npx skills add https://github.com/tylergibbs1/autorefactor -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave56.log

Write-Host "`n=== Wave 56 完成 ===" -ForegroundColor Green
