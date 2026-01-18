#!/bin/bash
# Claude Config Helper - 多模型配置脚本

set -e

MODEL_DIR="$HOME/claude-model"
BIN_DIR="$MODEL_DIR/bin"

RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
NC='\033[0m'

log() { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[✗]${NC} $1" >&2; }
info() { echo -e "${BLUE}[i]${NC} $1"; }

print_header() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "         Claude Config Helper"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
}

confirm() {
    local prompt="$1"
    local default="${2:-y}"
    local answer

    if [ "$default" = "y" ]; then
        read -p "$prompt [Y/n]: " answer
        answer=${answer:-y}
    else
        read -p "$prompt [y/N]: " answer
        answer=${answer:-n}
    fi

    [[ "$answer" =~ ^[Yy]$ ]]
}

check_dependencies() {
    if ! command -v npm &> /dev/null; then
        error "未检测到 npm，请先安装 Node.js"
        echo ""
        exit 1
    fi
}

usage() {
    print_header
    echo "用法: $0 <命令> [参数]"
    echo ""
    echo "命令:"
    echo "  i              安装 Claude Code"
    echo "  add <名称>     添加新模型配置"
    echo "  ls             列出已配置模型"
    echo "  rm <名称>      删除模型配置"
    echo ""
    echo "示例:"
    echo "  $0 i              # 安装 Claude Code"
    echo "  $0 add doubao     # 添加豆包模型"
    echo "  $0 add openai     # 添加 OpenAI 模型"
    echo "  $0 ls             # 查看已配置模型"
    echo ""
    exit 0
}

init() {
    mkdir -p "$BIN_DIR"
}

install_claude() {
    print_header
    echo "安装 Claude Code"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    check_dependencies

    if [ ! -d "$MODEL_DIR" ]; then
        info "创建目录: $MODEL_DIR"
        mkdir -p "$MODEL_DIR"
        cd "$MODEL_DIR"
        npm init -y > /dev/null 2>&1
    fi

    cd "$MODEL_DIR"

    if [ -d "node_modules/@anthropic-ai/claude-code" ]; then
        warn "Claude Code 已安装"
        if confirm "是否重新安装" n; then
            rm -rf node_modules package-lock.json
        else
            echo ""
            return
        fi
    fi

    info "正在安装 Claude Code..."
    echo ""

    if npm install @anthropic-ai/claude-code; then
        log "Claude Code 安装成功"
        echo ""
    else
        error "安装失败，请检查网络连接"
        exit 1
    fi

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "将以下内容添加到 ~/.bashrc 或 ~/.zshrc:"
    echo ""
    echo "  export PATH=\"$BIN_DIR:\$PATH\""
    echo ""
    echo "然后执行: source ~/.bashrc"
    echo ""
}

add_model() {
    [ -z "$1" ] && { error "请指定模型名称"; exit 1; }

    local name="$1"
    local wrapper_file="$BIN_DIR/claude-$name"
    local config_dir="$MODEL_DIR/.claude-$name"
    local settings_file="$config_dir/settings.json"

    print_header
    echo "添加模型配置: $name"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    if [ -f "$wrapper_file" ]; then
        warn "模型 '$name' 已存在"
        if ! confirm "是否覆盖" n; then
            echo ""
            return
        fi
    fi

    echo "请提供以下配置信息:"
    echo ""

    # API URL
    while true; do
        read -p "▸ API URL: " api_url
        if [ -z "$api_url" ]; then
            error "URL 不能为空"
        elif [[ ! "$api_url" =~ ^https?:// ]]; then
            error "URL 必须以 http:// 或 https:// 开头"
        else
            break
        fi
    done

    # Model ID
    while true; do
        read -p "▸ Model ID: " model
        if [ -z "$model" ]; then
            error "Model ID 不能为空"
        else
            break
        fi
    done

    # API Key
    while true; do
        read -p "▸ API Key: " api_key
        if [ -z "$api_key" ]; then
            error "API Key 不能为空"
        else
            break
        fi
    done

    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "配置摘要:"
    echo ""
    echo "  模型名称: $name"
    echo "  API URL:  $api_url"
    echo "  Model:    $model"
    echo "  Key:      ${api_key:0:8}...${api_key: -4}"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    if ! confirm "确认创建" y; then
        info "已取消"
        echo ""
        return
    fi

    # 创建配置目录
    mkdir -p "$config_dir"

    # 创建空 settings.json（占位用）
    echo "{}" > "$settings_file"

    # 创建 wrapper 脚本
    cat > "$wrapper_file" << WRAPPER
#!/usr/bin/env bash
# Wrapper for Claude Code CLI using $name API

CLAUDE_BIN="\$HOME/claude-model/node_modules/.bin/claude"

# Inject API credentials
export ANTHROPIC_AUTH_TOKEN="$api_key"
export ANTHROPIC_BASE_URL="$api_url"
export ANTHROPIC_MODEL="$model"
export API_TIMEOUT_MS=3000000

# Keep a separate config dir
export CLAUDE_CONFIG_DIR="$config_dir"

exec "\$CLAUDE_BIN" "\$@"
WRAPPER

    chmod +x "$wrapper_file"

    log "已创建命令: claude-$name"
    echo ""
    info "配置文件: $settings_file"
    echo ""
    info "使用方式: claude-$name"
    echo ""
}

list_models() {
    print_header
    echo "已配置模型"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    local count=0

    for f in "$BIN_DIR"/claude-*; do
        [ -f "$f" ] || continue
        count=$((count + 1))
    done

    if [ "$count" -eq 0 ]; then
        echo "  (暂无配置)"
        echo ""
        info "运行 '$0 add <名称>' 添加模型"
        echo ""
        return
    fi

    for f in "$BIN_DIR"/claude-*; do
        [ -f "$f" ] || continue
        local name=$(basename "$f" | sed 's/claude-//')
        local config_dir="$MODEL_DIR/.claude-$name"
        if [ -f "$config_dir/settings.json" ]; then
            echo "  ○ claude-$name (已配置)"
        else
            echo "  ○ claude-$name (未配置)"
        fi
    done
    echo ""
}

rm_model() {
    [ -z "$1" ] && { error "请指定模型名称"; exit 1; }

    local name="$1"
    local wrapper_file="$BIN_DIR/claude-$name"
    local config_dir="$MODEL_DIR/.claude-$name"

    if [ ! -f "$wrapper_file" ]; then
        error "模型 '$name' 不存在"
        echo ""
        exit 1
    fi

    print_header
    echo "删除模型配置: $name"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    warn "此操作将删除以下内容:"
    echo "  • $wrapper_file"
    echo "  • $config_dir/"
    echo ""

    if ! confirm "确认删除" n; then
        info "已取消"
        echo ""
        return
    fi

    rm -f "$wrapper_file"
    rm -rf "$config_dir"

    log "已删除: claude-$name"
    echo ""
}

[ $# -eq 0 ] && { usage; }

init

case "$1" in
    i|install)  install_claude ;;
    a|add)      shift; add_model "$@" ;;
    ls|list)    list_models ;;
    rm|remove)  shift; rm_model "$@" ;;
    h|-h|--help) usage ;;
    *)          error "未知命令: $1"; usage ;;
esac
