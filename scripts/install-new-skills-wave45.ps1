# Wave 45: 中文/营销/视频/交易技能
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 45: 中文/营销/视频/交易技能 ===" -ForegroundColor Cyan

# 1. 微信 Claude Code 技能
Write-Host "`n[1] WeChat Claude Code Skill..." -ForegroundColor Yellow
npx skills add https://github.com/Wechat-ggGitHub/wechat-claude-code -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave45.log

# 2. 微信文章转 Markdown
Write-Host "[2] WeChat Article for AI..." -ForegroundColor Yellow
npx skills add https://github.com/bzd6661/wechat-article-for-ai -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave45.log

# 3. 视频剪辑技能
Write-Host "[3] Chengfeng Videocut Skills..." -ForegroundColor Yellow
npx skills add https://github.com/Agentchengfeng/chengfeng-videocut-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave45.log

# 4. 视频技能合集
Write-Host "[4] Video Skills (xuliang2024)..." -ForegroundColor Yellow
npx skills add https://github.com/xuliang2024/video_skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave45.log

# 5. AI 营销技能
Write-Host "[5] AI Marketing Skills..." -ForegroundColor Yellow
npx skills add https://github.com/BrianRWagner/ai-marketing-claude-code-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave45.log

# 6. 交易技能
Write-Host "[6] Claude Trading Skills..." -ForegroundColor Yellow
npx skills add https://github.com/tradermonty/claude-trading-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave45.log

# 7. Buffet 投资技能
Write-Host "[7] Buffett Skills..." -ForegroundColor Yellow
npx skills add https://github.com/agi-now/buffett-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave45.log

# 8. X/Twitter 文章发布
Write-Host "[8] X Article Publisher Skill..." -ForegroundColor Yellow
npx skills add https://github.com/wshuyi/x-article-publisher-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave45.log

# 9. SEO/广告技能
Write-Host "[9] NotFair (SEO/GEO/Ads)..." -ForegroundColor Yellow
npx skills add https://github.com/nowork-studio/NotFair -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave45.log

# 10. 卡兹克中文技能
Write-Host "[10] Khazix Skills (中文)..." -ForegroundColor Yellow
npx skills add https://github.com/KKKKhazix/khazix-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave45.log

Write-Host "`n=== Wave 45 完成 ===" -ForegroundColor Green
