# -*- coding: utf-8 -*-
"""修复 skills_zh_data.py 的双重编码乱码。

损坏路径: 原UTF-8中文 -> 被错误按 latin1 读取 -> 当 utf-8 存储
还原路径: encode('latin1') -> decode('utf-8')

仅还原含乱码的字节；纯 ASCII (key/结构) 原样保留。
对无法还原的字符用 replace 兜底，避免整体崩溃。
"""
import re
import sys

SRC = 'data/skills_zh_data.py'

with open(SRC, 'rb') as f:
    raw_bytes = f.read()

# 先按 utf-8 解出当前(损坏的)字符串
text = raw_bytes.decode('utf-8', errors='replace')

# 乱码特征：latin1 范围的高位字符序列 (ç º ¨ © 等)，即 U+0080-U+00FF
# 找到所有连续的 latin1 高位段，逐段尝试还原
MOJI_RE = re.compile(r'[-ÿ]+')


def restore_segment(seg: str) -> str:
    try:
        return seg.encode('latin1').decode('utf-8')
    except Exception:
        # 兜底：尝试 gb18030
        try:
            return seg.encode('latin1').decode('gb18030', errors='replace')
        except Exception:
            return seg


def restore_line(line: str) -> str:
    # 不动代码结构，只替换乱码段
    return MOJI_RE.sub(lambda m: restore_segment(m.group(0)), line)


# 统计
before_count = len(MOJI_RE.findall(text))
restored_text = '\n'.join(restore_line(ln) for ln in text.split('\n'))
after_count = len(MOJI_RE.findall(restored_text))

# 写回 (utf-8, 保留 CRLF)
with open(SRC, 'wb') as f:
    f.write(restored_text.encode('utf-8'))

# stderr 输出统计，stdout 给人类可读校验
print(f'[fix] 修复前乱码段数: {before_count}', file=sys.stderr)
print(f'[fix] 修复后残留乱码段: {after_count}', file=sys.stderr)
print(f'[fix] 已写回 {SRC}', file=sys.stderr)

# 抽样校验到 stdout (前3个 title)
titles = re.findall(r'"title":\s*"([^"]+)"', restored_text)[:5]
for t in titles:
    print(t)
