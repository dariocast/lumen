#!/usr/bin/env bash
# Lumen skill installer
# Usage:
#   bash scripts/install.sh              # install globally for Claude Code
#   bash scripts/install.sh --project    # install into current project's .claude/skills/
#   bash scripts/install.sh --cursor     # install for Cursor (global)
#   bash scripts/install.sh --all        # install for all supported tools

set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../skills/lumen" && pwd)"
SKILL_NAME="lumen"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

install_to() {
  local target="$1"
  local label="$2"
  mkdir -p "$target"
  cp -r "$SKILL_DIR/." "$target/"
  echo -e "${GREEN}✓${NC} Installed to $target  ($label)"
}

MODE="${1:-}"

case "$MODE" in
  --project)
    install_to ".claude/skills/$SKILL_NAME" "Claude Code — this project"
    ;;
  --cursor)
    install_to "$HOME/.cursor/skills/$SKILL_NAME" "Cursor — global"
    ;;
  --all)
    install_to "$HOME/.claude/skills/$SKILL_NAME"  "Claude Code — global"
    install_to "$HOME/.cursor/skills/$SKILL_NAME"  "Cursor — global"
    ;;
  "")
    install_to "$HOME/.claude/skills/$SKILL_NAME" "Claude Code — global"
    ;;
  *)
    echo "Unknown option: $MODE"
    echo "Usage: bash scripts/install.sh [--project | --cursor | --all]"
    exit 1
    ;;
esac

echo ""
echo -e "${YELLOW}Invoke with /lumen in Claude Code, Cursor, or any Agent Skills-compatible tool.${NC}"
