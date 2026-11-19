#!/usr/bin/env bash
# basic-rules 설치 스크립트 (macOS·Linux)
# Claude Code 전역 지침(~/.claude/CLAUDE.md)과 Codex 전역 지침(~/.codex/AGENTS.md)을 설치한다.
# 기존 지침이 있으면 차이를 보여 주고, 사용자가 고른 대로만 바꾼다. 바꾸기 전에 항상 백업한다.
#
# 사용법: ./install.sh            # 둘 다 설치
#        ./install.sh claude     # Claude Code만
#        ./install.sh codex      # Codex만
set -euo pipefail

RAW="https://raw.githubusercontent.com/KimKyungmin-7788/basic-rules/main"
HERE=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
  HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi
STAMP="$(date +%Y%m%d-%H%M%S)"

# 저장소를 받아서 실행하면 그 파일을, curl로 바로 실행하면 GitHub에서 받은 파일을 쓴다.
source_file() {
  local rel="$1"
  if [ -n "$HERE" ] && [ -f "$HERE/$rel" ]; then
    echo "$HERE/$rel"
  else
    local tmp
    tmp="$(mktemp)"
    curl -fsSL --retry 2 -m 60 "$RAW/$rel" -o "$tmp" < /dev/null
    echo "$tmp"
  fi
}

ask() { # 파이프(curl | bash)로 실행해도 키보드 입력을 받는다
  local answer
  if { true < /dev/tty; } 2>/dev/null; then
    read -r -p "$1" answer < /dev/tty
  else
    read -r -p "$1" answer || true
  fi
  echo "$answer"
}

install_one() {
  local name="$1" src dest
  src="$(source_file "$2")"
  dest="$3"

  echo
  echo "=== $name → $dest ==="
  mkdir -p "$(dirname "$dest")"

  if [ ! -f "$dest" ]; then
    cp "$src" "$dest"
    echo "기존 지침이 없어 새로 설치했습니다."
    return
  fi

  if cmp -s "$src" "$dest"; then
    echo "이미 같은 내용입니다. 바꾸지 않았습니다."
    return
  fi

  echo "기존 지침과 다릅니다. ('-' 기존, '+' 새 지침)"
  echo "----------------------------------------"
  diff -u "$dest" "$src" | tail -n +3 || true
  echo "----------------------------------------"
  echo "  r) 새 지침으로 교체 (기존 파일은 백업)"
  echo "  a) 기존 지침 뒤에 새 지침 덧붙이기 (기존 파일은 백업, 겹치는 내용은 직접 정리)"
  echo "  k) 기존 지침 그대로 두기"
  case "$(ask "선택 [r/a/k]: ")" in
    r|R)
      cp "$dest" "$dest.bak-$STAMP"
      cp "$src" "$dest"
      echo "교체했습니다. 백업: $dest.bak-$STAMP" ;;
    a|A)
      cp "$dest" "$dest.bak-$STAMP"
      { echo; echo "<!-- basic-rules에서 덧붙임 ($STAMP) -->"; cat "$src"; } >> "$dest"
      echo "덧붙였습니다. 겹치는 규칙을 정리하세요. 백업: $dest.bak-$STAMP" ;;
    *)
      echo "그대로 두었습니다." ;;
  esac
}

target="${1:-all}"
CODEX_DIR="${CODEX_HOME:-$HOME/.codex}"

case "$target" in
  claude) install_one "Claude Code" "claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md" ;;
  codex)  install_one "Codex" "codex/AGENTS.md" "$CODEX_DIR/AGENTS.md" ;;
  all)
    install_one "Claude Code" "claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
    install_one "Codex" "codex/AGENTS.md" "$CODEX_DIR/AGENTS.md" ;;
  *) echo "사용법: $0 [claude|codex]"; exit 1 ;;
esac

echo
echo "끝났습니다. Claude Code·Codex를 새로 열면 바로 적용됩니다."
