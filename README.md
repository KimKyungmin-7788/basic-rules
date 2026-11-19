# basic-rules

Claude Code와 Codex에서 함께 쓰는 나의 전역 지침입니다.
어느 컴퓨터에서든 같은 지침으로 일할 수 있게 설치 방법까지 담았습니다.

| 파일 | 설치 위치 |
|---|---|
| [`claude/CLAUDE.md`](claude/CLAUDE.md) | `~/.claude/CLAUDE.md` (Claude Code 전역 지침) |
| [`codex/AGENTS.md`](codex/AGENTS.md) | `~/.codex/AGENTS.md` (Codex 전역 지침) |

## 설치 방법 1: AI에게 맡기기 (추천, Windows 포함)

새 환경의 Claude Code나 Codex에 아래 문장을 그대로 붙여 넣습니다.

```text
https://github.com/KimKyungmin-7788/basic-rules 의 INSTALL.md를 읽고 그대로 따라서 내 전역 지침을 설치해줘. Claude Code용과 Codex용 둘 다.
```

기존 전역 지침이 있으면 AI가 규칙별로 비교표를 보여 주고, 합친 최종본을 내가 확정한 뒤에만 저장합니다.
순서는 [INSTALL.md](INSTALL.md)에 있습니다.

## 설치 방법 2: 명령 한 줄 (macOS·Linux)

```bash
curl -fsSL https://raw.githubusercontent.com/KimKyungmin-7788/basic-rules/main/install.sh | bash
```

- 기존 지침이 없으면 바로 설치합니다.
- 기존 지침이 있으면 차이(diff)를 보여 주고 **교체 / 뒤에 덧붙이기 / 그대로 두기** 중에서 고르게 합니다.
- 바꾸기 전에 기존 파일을 `*.bak-날짜시각`으로 백업합니다.
- 하나만 설치하려면 명령 끝의 `bash`를 `bash -s claude` 또는 `bash -s codex`로 바꿉니다.

## 지침을 고친 뒤 올리기

이 저장소의 두 파일을 고쳐 커밋·푸시하고, 다른 컴퓨터에서 설치를 다시 하면 됩니다.
두 파일은 같은 내용으로 유지합니다.

## 함께 받아 두면 좋은 것

지침이 참조하는 자료입니다. 새 환경에 없으면 지침 일부가 동작하지 않습니다.

- 학교안심 글꼴 키트: [hakgyoansim-font-kit](https://github.com/KimKyungmin-7788/hakgyoansim-font-kit) → `~/Documents/hakgyoansim-font-kit`에 받기
- 교육용 앱 배포 점검 스킬: [edu-app-launch](https://github.com/KimKyungmin-7788/edu-app-launch)
