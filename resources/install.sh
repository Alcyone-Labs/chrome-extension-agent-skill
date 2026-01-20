#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/Alcyone-Labs/chrome-extension-agent-skill.git"
SKILL_NAME="chrome-extension-architect"

usage() {
  cat <<EOF
Usage: $0 [OPTIONS]

Install the Chrome Extension MV3 Privacy Architect skill for OpenCode, Gemini CLI, and FactoryAI Droid.

Options:
  -g, --global    Install globally (~/.config/opencode/skill/)
  -l, --local     Install locally (.opencode/skill/) [default]
  -s, --self      Install from local filesystem (for testing)
  -h, --help      Show this help message

Examples:
  curl -fsSL https://raw.githubusercontent.com/Alcyone-Labs/chrome-extension-agent-skill/main/install.sh | bash
  curl -fsSL https://raw.githubusercontent.com/Alcyone-Labs/chrome-extension-agent-skill/main/install.sh | bash -s -- --global
EOF
}

install_opencode_local() {
  local target_dir=".opencode/skill/${SKILL_NAME}"
  local command_dir=".opencode/command"

  echo "Installing to OpenCode (local)..."

  mkdir -p "$target_dir"
  mkdir -p "$command_dir"

  if [[ -d "$target_dir" ]]; then
    echo "Updating existing local installation..."
    rm -rf "$target_dir"
  fi

  cp -r "${tmp_dir}/skill/${SKILL_NAME}" "$target_dir"

  local command_path="${command_dir}/${SKILL_NAME}.md"
  if [[ -d "$command_path" ]] || [[ -f "$command_path" ]]; then
    rm -rf "$command_path"
  fi
  cp "${tmp_dir}/command/${SKILL_NAME}.md" "$command_path"

  echo "Installed skill to: ${target_dir}"
  echo "Installed command to: ${command_path}"
}

install_opencode_global() {
  local target_dir="${HOME}/.config/opencode/skill/${SKILL_NAME}"
  local command_dir="${HOME}/.config/opencode/command"

  echo "Installing to OpenCode (global)..."

  mkdir -p "$target_dir"
  mkdir -p "$command_dir"

  if [[ -d "$target_dir" ]]; then
    echo "Updating existing global installation..."
    rm -rf "$target_dir"
  fi

  cp -r "${tmp_dir}/skill/${SKILL_NAME}" "$target_dir"

  local command_path="${command_dir}/${SKILL_NAME}.md"
  if [[ -d "$command_path" ]] || [[ -f "$command_path" ]]; then
    rm -rf "$command_path"
  fi
  cp "${tmp_dir}/command/${SKILL_NAME}.md" "$command_path"

  echo "Installed skill to: ${target_dir}"
  echo "Installed command to: ${command_path}"
}

install_gemini() {
  local target_dir="${HOME}/.gemini/skills/${SKILL_NAME}"

  echo "Installing to Gemini CLI..."

  mkdir -p "$target_dir"

  if [[ -d "$target_dir" ]]; then
    echo "Updating existing Gemini installation..."
    rm -rf "$target_dir"
  fi

  cp -r "${tmp_dir}/skill/${SKILL_NAME}" "$target_dir"

  if [[ -f "${target_dir}/SKILL.md" ]]; then
    mv "${target_dir}/SKILL.md" "${target_dir}/SKILL.md"
  fi

  echo "Installed skill to: ${target_dir}"
}

install_factory() {
  local target_dir="${HOME}/.factory/skills/${SKILL_NAME}"

  echo "Installing to FactoryAI Droid..."

  mkdir -p "$target_dir"

  if [[ -d "$target_dir" ]]; then
    echo "Updating existing FactoryAI installation..."
    rm -rf "$target_dir"
  fi

  cp -r "${tmp_dir}/skill/${SKILL_NAME}" "$target_dir"

  echo "Installed skill to: ${target_dir}"
}

main() {
  local install_type="local"
  local self_install=false

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -g|--global) install_type="global"; shift ;;
      -l|--local) install_type="local"; shift ;;
      -s|--self) self_install=true; shift ;;
      -h|--help) usage; exit 0 ;;
      *) echo "Unknown option: $1"; usage; exit 1 ;;
    esac
  done

  echo "Installing ${SKILL_NAME} skill (${install_type})..."

  local tmp_dir
  if [[ "$self_install" == true ]]; then
    tmp_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    echo "Installing from local source..."
    # Create expected directory structure for self-install
    mkdir -p "${tmp_dir}/skill/${SKILL_NAME}"
    mkdir -p "${tmp_dir}/command"
    if [[ -f "${tmp_dir}/SKILL.md" ]]; then
      cp "${tmp_dir}/SKILL.md" "${tmp_dir}/skill/${SKILL_NAME}/SKILL.md"
    fi
    if [[ -f "${tmp_dir}/README.md" ]]; then
      cp "${tmp_dir}/README.md" "${tmp_dir}/skill/${SKILL_NAME}/README.md"
    fi
    if [[ -d "${tmp_dir}/references" ]]; then
      cp -r "${tmp_dir}/references" "${tmp_dir}/skill/${SKILL_NAME}/"
    fi
    if [[ -d "${tmp_dir}/resources" ]]; then
      cp -r "${tmp_dir}/resources" "${tmp_dir}/skill/${SKILL_NAME}/"
    fi
    if [[ -f "${tmp_dir}/LICENSE.txt" ]]; then
      cp "${tmp_dir}/LICENSE.txt" "${tmp_dir}/skill/${SKILL_NAME}/LICENSE.txt"
    fi
    # Handle command file naming
    if [[ -f "${tmp_dir}/command/load-${SKILL_NAME}.md" ]] && [[ ! -f "${tmp_dir}/command/${SKILL_NAME}.md" ]]; then
      cp "${tmp_dir}/command/load-${SKILL_NAME}.md" "${tmp_dir}/command/${SKILL_NAME}.md"
    fi
  else
    tmp_dir=$(mktemp -d)
    trap "rm -rf '$tmp_dir'" EXIT
    echo "Fetching skill..."
    git clone --depth 1 --quiet "$REPO_URL" "$tmp_dir"
  fi

  if [[ "$install_type" == "global" ]]; then
    install_opencode_global
  else
    install_opencode_local
  fi

  if [[ -d "${HOME}/.gemini" ]]; then
    install_gemini
  fi

  if [[ -d "${HOME}/.factory" ]]; then
    install_factory
  fi

  echo ""
  echo "Usage:"
  echo "  OpenCode: /${SKILL_NAME} <task>"
  echo "  Gemini:   /skill ${SKILL_NAME} <task>"
  echo "  Factory:  /skill ${SKILL_NAME} <task>"
  echo ""
  echo "Done."
}

main "$@"
