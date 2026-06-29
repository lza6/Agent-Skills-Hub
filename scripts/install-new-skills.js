#!/usr/bin/env node
/**
 * 批量安装新发现的技能仓库
 * 从 data/new-skills-repos.txt 读取仓库列表
 */

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const REPOS_FILE = path.join(__dirname, '..', 'data', 'new-skills-repos.txt');
const LOG_DIR = path.join(__dirname, '..', 'logs');
const FAILURES_FILE = path.join(LOG_DIR, 'new-skills-failures.txt');
const SUCCESS_FILE = path.join(LOG_DIR, 'new-skills-success.txt');

// 确保 logs 目录存在
if (!fs.existsSync(LOG_DIR)) {
  fs.mkdirSync(LOG_DIR, { recursive: true });
}

// 清空日志文件
fs.writeFileSync(FAILURES_FILE, '');
fs.writeFileSync(SUCCESS_FILE, '');

// 读取仓库列表
const reposContent = fs.readFileSync(REPOS_FILE, 'utf-8');
const repos = reposContent
  .split('\n')
  .filter(line => line.trim() && !line.startsWith('#'))
  .map(line => line.trim());

console.log(`准备安装 ${repos.length} 个仓库...\n`);

let successCount = 0;
let failCount = 0;

for (const repo of repos) {
  console.log(`[${successCount + failCount + 1}/${repos.length}] 安装 ${repo}...`);

  try {
    const result = execSync(
      `node "C:/Users/Administrator.DESKTOP-EGNE9ND/AppData/Roaming/npm/node_modules/skills/bin/cli.mjs" add ${repo}`,
      {
        encoding: 'utf-8',
        timeout: 120000,
        stdio: ['pipe', 'pipe', 'pipe']
      }
    );

    // 检查是否真的成功
    if (result.includes('No valid skills') || result.includes('No skills found')) {
      console.log(`  SKIP: 无有效技能文件`);
      fs.appendFileSync(FAILURES_FILE, `SKIP ${repo}\n`);
      failCount++;
    } else {
      console.log(`  OK`);
      fs.appendFileSync(SUCCESS_FILE, `OK ${repo}\n`);
      successCount++;
    }
  } catch (error) {
    const errorMsg = error.message || error.stdout || error.stderr || 'Unknown error';
    console.log(`  FAIL: ${errorMsg.split('\n')[0]}`);
    fs.appendFileSync(FAILURES_FILE, `FAIL ${repo}\n`);
    failCount++;
  }
}

console.log(`\n完成！成功: ${successCount}, 失败: ${failCount}`);
console.log(`日志: ${LOG_DIR}`);