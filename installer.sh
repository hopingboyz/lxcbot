#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════════
#   ██╗  ██╗ ██████╗ ██████╗ ██╗███╗   ██╗ ██████╗ ██████╗  ██████╗ ██╗   ██╗███████╗
#   ██║  ██║██╔═══██╗██╔══██╗██║████╗  ██║██╔════╝ ██╔══██╗██╔═══██╗╚██╗ ██╔╝╚══███╔╝
#   ███████║██║   ██║██████╔╝██║██╔██╗ ██║██║  ███╗██████╔╝██║   ██║ ╚████╔╝   ███╔╝
#   ██╔══██║██║   ██║██╔═══╝ ██║██║╚██╗██║██║   ██║██╔══██╗██║   ██║  ╚██╔╝   ███╔╝
#   ██║  ██║╚██████╔╝██║     ██║██║ ╚████║╚██████╔╝██████╔╝╚██████╔╝   ██║   ███████╗
#   ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝
#
#              >>>  HOPINGBOYZ  LXC  BOT  INSTALLER  <<<
#                    Powered by HOPINGBOYZ | v2.1 PRO
# ═══════════════════════════════════════════════════════════════════════════

set -e

# ─────────────── COLORS ───────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
DIM='\033[2m'
BLINK='\033[5m'
NC='\033[0m'

# ─────────────── WATERMARK ───────────────
watermark() {
    echo -e "${MAGENTA}${DIM}    ─────────── HOPINGBOYZ ───────────${NC}"
}

watermark_inline() {
    echo -e "${MAGENTA}${DIM}HOPINGBOYZ${NC}"
}

# ─────────────── TYPEWRITER ───────────────
typewriter() {
    local text="$1"
    local delay="${2:-0.02}"
    for (( i=0; i<${#text}; i++ )); do
        echo -ne "${text:$i:1}"
        sleep "$delay"
    done
    echo ""
}

# ─────────────── SPINNER ───────────────
spinner() {
    local pid=$1
    local message="$2"
    local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0
    while kill -0 "$pid" 2>/dev/null; do
        i=$(( (i+1) % 10 ))
        printf "\r${CYAN}  ${spin:$i:1} ${WHITE}${message}${NC}   "
        sleep 0.1
    done
    printf "\r${GREEN}  ✔ ${WHITE}${message} ${GREEN}[DONE]${NC}              \n"
}

# ─────────────── PROGRESS BAR ───────────────
progress_bar() {
    local duration=$1
    local message="$2"
    local bar_width=40
    echo -e "${CYAN}  ${message}${NC}"
    for (( i=0; i<=bar_width; i++ )); do
        local filled=$(printf "█%.0s" $(seq 1 $i 2>/dev/null))
        local empty=$(printf "░%.0s" $(seq 1 $((bar_width - i)) 2>/dev/null))
        local percent=$(( i * 100 / bar_width ))
        printf "\r  ${GREEN}[${filled}${DIM}${empty}${GREEN}]${NC} ${YELLOW}${percent}%%${NC}"
        sleep 0.02
    done
    echo ""
}

# ─────────────── BOX LINE ───────────────
box_line() {
    echo -e "${CYAN}  ══════════════════════════════════════════════════════${NC}"
}

# ─────────────── SECTION HEADER ───────────────
section() {
    local num="$1"
    local title="$2"
    echo ""
    echo -e "${CYAN}  ┌──────────────────────────────────────────────────────┐${NC}"
    printf "${CYAN}  │${NC} ${BLUE}${BOLD}[STEP %s]${NC} ${WHITE}${BOLD}%-46s${NC}${CYAN}│${NC}\n" "$num" "$title"
    echo -e "${CYAN}  └──────────────────────────────────────────────────────┘${NC}"
    watermark
    echo ""
}

# ─────────────── CLEAR & BANNER ───────────────
clear
echo ""
echo -e "${CYAN}${BOLD}"
cat << "EOF"
    ╔═══════════════════════════════════════════════════════════════╗
    ║                                                               ║
    ║   ██╗  ██╗ ██████╗ ██████╗ ██╗███╗   ██╗ ██████╗             ║
    ║   ██║  ██║██╔═══██╗██╔══██╗██║████╗  ██║██╔════╝             ║
    ║   ███████║██║   ██║██████╔╝██║██╔██╗ ██║██║  ███╗            ║
    ║   ██╔══██║██║   ██║██╔═══╝ ██║██║╚██╗██║██║   ██║            ║
    ║   ██║  ██║╚██████╔╝██║     ██║██║ ╚████║╚██████╔╝            ║
    ║   ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═══╝ ╚═════╝             ║
    ║                                                               ║
    ║   ██████╗  ██████╗ ██╗   ██╗███████╗                         ║
    ║   ██╔══██╗██╔═══██╗╚██╗ ██╔╝╚══███╔╝                         ║
    ║   ██████╔╝██║   ██║ ╚████╔╝   ███╔╝                          ║
    ║   ██╔══██╗██║   ██║  ╚██╔╝   ███╔╝                           ║
    ║   ██████╔╝╚██████╔╝   ██║   ███████╗                         ║
    ║   ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝                         ║
    ║                                                               ║
    ║              >>>  LXC BOT INSTALLER v2.1  <<<                 ║
    ║                                                               ║
    ╚═══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo -e "${YELLOW}${BOLD}"
typewriter "         ⚡ ATYRO CLOUD BOT — AUTO SETUP WIZARD ⚡" 0.02
echo -e "${NC}"
watermark
echo ""

# ─────────────── ROOT CHECK ───────────────
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}  ✖ Bhai, root user se run kar!${NC}"
    echo -e "${YELLOW}  → sudo bash installer.sh${NC}"
    exit 1
fi

echo -e "${GREEN}  ✔ Root access confirmed${NC}"
watermark
sleep 0.5

# ═════════════════════════════════════════════════════════════
#  STEP 1: SYSTEM DEPENDENCIES
# ═════════════════════════════════════════════════════════════
section "1/7" "Installing System Dependencies"

(apt update -y > /dev/null 2>&1) &
spinner $! "Updating apt packages"

(apt install -y git python3 python3-pip curl nano wget uidmap > /dev/null 2>&1) &
spinner $! "Installing git, python3, pip "

echo -e "${GREEN}  ✔ System ready${NC}"
watermark

# ═════════════════════════════════════════════════════════════
#  STEP 2: CLONE REPOSITORY
# ═════════════════════════════════════════════════════════════
section "2/7" "Cloning HOPINGBOYZ Repository"

if [ -d "lxcbot" ]; then
    echo -e "${YELLOW}  ⚠ Existing 'lxcbot' folder found. Removing...${NC}"
    rm -rf lxcbot
fi

(git clone https://github.com/hopingboyz/lxcbot.git > /dev/null 2>&1) &
spinner $! "Cloning hopingboyz/lxcbot"

if [ ! -d "lxcbot" ]; then
    echo -e "${RED}  ✖ Clone failed! Check repo URL or internet.${NC}"
    exit 1
fi

cd lxcbot
echo -e "${GREEN}  ✔ Repository cloned successfully${NC}"
echo -e "${CYAN}  ℹ Working dir: ${WHITE}$(pwd)${NC}"
watermark

# ═════════════════════════════════════════════════════════════
#  STEP 3: PYTHON PACKAGES
# ═════════════════════════════════════════════════════════════
section "3/7" "Installing Python Packages"

PACKAGES=("discord.py" "python-dotenv" "PyNaCl" "paramiko" "flask" "flask-cors" "psutil" "aiohttp" "requests")
TOTAL=${#PACKAGES[@]}
COUNT=0

for pkg in "${PACKAGES[@]}"; do
    COUNT=$((COUNT + 1))
    (pip install "$pkg" --break-system-packages --ignore-installed --quiet > /dev/null 2>&1) &
    spinner $! "[$COUNT/$TOTAL] Installing $pkg"
done

echo -e "${GREEN}  ✔ All Python packages installed${NC}"
watermark

# ═════════════════════════════════════════════════════════════
#  STEP 4: ENV FILE SETUP (INTERACTIVE)
# ═════════════════════════════════════════════════════════════
section "4/7" "Configuring .env File"

if [ -f "test.env" ]; then
    cp test.env .env
    echo -e "${GREEN}  ✔ Copied test.env → .env${NC}"
else
    touch .env
    echo -e "${YELLOW}  ⚠ test.env not found, creating new .env${NC}"
fi

echo ""
echo -e "${CYAN}  ┌────────────────────────────────────────────────────────┐${NC}"
echo -e "${CYAN}  │${NC}   ${BOLD}${WHITE}⚙️   ENVIRONMENT VARIABLE WIZARD${NC}                      ${CYAN}│${NC}"
echo -e "${CYAN}  │${NC}   ${DIM}Press ENTER to keep default value${NC}                  ${CYAN}│${NC}"
echo -e "${CYAN}  └────────────────────────────────────────────────────────┘${NC}"
watermark
echo ""

# ─── Set env var with default ───
# Args: VAR_NAME | PROMPT | DEFAULT | SECRET(yes/no)
set_env_var() {
    local var_name="$1"
    local prompt_text="$2"
    local default_val="$3"
    local is_secret="$4"
    local value=""

    echo -e "${YELLOW}  ➤ ${BOLD}${var_name}${NC}"
    echo -e "${DIM}    ${prompt_text}${NC}"

    if [ -n "$default_val" ]; then
        echo -ne "${WHITE}    ${var_name} ${DIM}[${default_val}]${NC}${WHITE}: ${NC}"
    else
        echo -ne "${WHITE}    ${var_name}: ${NC}"
    fi

    if [ "$is_secret" = "yes" ]; then
        read -s value
        echo ""
    else
        read value
    fi

    # Use default if empty
    if [ -z "$value" ] && [ -n "$default_val" ]; then
        value="$default_val"
        echo -e "${CYAN}    ℹ Using default: ${WHITE}${value}${NC}"
    fi

    if [ -z "$value" ]; then
        echo -e "${RED}    ✖ Skipped (empty)${NC}"
        return
    fi

    # Remove existing line & append
    sed -i "/^${var_name}=/d" .env 2>/dev/null || true
    echo "${var_name}=${value}" >> .env
    echo -e "${GREEN}    ✔ ${var_name} set${NC}"
    watermark
    echo ""
}

# ─── Group 1: Discord Core ───
echo -e "${MAGENTA}${BOLD}  ╭─── 🔑 DISCORD CORE ───╮${NC}"
watermark
echo ""

set_env_var "DISCORD_TOKEN" "Discord bot token (from Developer Portal)" "" "yes"
set_env_var "BOT_NAME" "Bot display name" "AtyroCloud" "no"
set_env_var "PREFIX" "Command prefix" "!" "no"

# ─── Group 2: Server Info ───
echo -e "${MAGENTA}${BOLD}  ╭─── 🌐 SERVER INFO ───╮${NC}"
watermark
echo ""

# Auto-detect public IP
AUTO_IP=$(curl -s --max-time 5 ifconfig.me 2>/dev/null || echo "127.0.0.1")

set_env_var "YOUR_SERVER_IP" "Public VPS IP (auto-detected)" "$AUTO_IP" "no"
set_env_var "MAIN_ADMIN_ID" "Admin Discord user ID" "" "no"
set_env_var "VPS_USER_ROLE_ID" "VPS user role ID" "" "no"
set_env_var "DEFAULT_STORAGE_POOL" "LXC storage pool" "default" "no"

# ─── Group 3: Bot Metadata ───
echo -e "${MAGENTA}${BOLD}  ╭─── 📦 BOT METADATA ───╮${NC}"
watermark
echo ""

set_env_var "BOT_VERSION" "Version string" "8.0-PRO" "no"
set_env_var "BOT_DEVELOPER" "Developer name" "Hopingboyz" "no"
set_env_var "BOT_THUMBNAIL_URL" "Embed thumbnail URL" "https://i.imgur.com/xAx2gRQ.jpeg" "no"
set_env_var "BOT_ICON_URL" "Embed icon URL" "https://i.imgur.com/xAx2gRQ.jpeg" "no"

# ─── Group 4: VPS Expiry ───
echo -e "${MAGENTA}${BOLD}  ╭─── ⏰ EXPIRATION ───╮${NC}"
watermark
echo ""

set_env_var "DEFAULT_VPS_EXPIRATION_DAYS" "Default VPS expiry (days)" "30" "no"
set_env_var "EXPIRATION_WARNING_DAYS" "Warning before expiry (days)" "1" "no"

# ─── Group 5: Host MOTD ───
echo -e "${MAGENTA}${BOLD}  ╭─── 🎨 HOST MOTD ───╮${NC}"
watermark
echo ""

set_env_var "HOST_MOTD" "MOTD script URL" "bash <(curl -fsSL https://raw.githubusercontent.com/hopingboyz/linux/main/atyro-water-mark.sh)" "no"

# ─── Group 6: Public VPS ───
echo -e "${MAGENTA}${BOLD}  ╭─── 🚀 PUBLIC VPS CREATION ───╮${NC}"
watermark
echo ""

set_env_var "PUBLIC_VPS_ENABLED" "Enable public VPS (true/false)" "true" "no"
set_env_var "PUBLIC_VPS_MAX_RAM" "Max RAM per VPS (GB)" "4" "no"
set_env_var "PUBLIC_VPS_MAX_CPU" "Max CPU cores" "2" "no"
set_env_var "PUBLIC_VPS_MAX_DISK" "Max disk (GB)" "50" "no"
set_env_var "PUBLIC_VPS_EXPIRY_DAYS" "Expiry days" "30" "no"
set_env_var "PUBLIC_VPS_MAX_PER_USER" "Max VPS per user" "1" "no"
set_env_var "PUBLIC_VPS_MAX_PER_IP" "Max VPS per IP" "1" "no"
set_env_var "PUBLIC_VPS_REQUIRE_VERIFICATION" "Require verification (true/false)" "false" "no"

# ─── Group 7: Renewal ───
echo -e "${MAGENTA}${BOLD}  ╭─── 🔄 PUBLIC VPS RENEWAL ───╮${NC}"
watermark
echo ""

set_env_var "PUBLIC_VPS_RENEWAL_ENABLED" "Enable renewal (true/false)" "true" "no"
set_env_var "PUBLIC_VPS_RENEWAL_DAYS" "Renewal days" "30" "no"

# ─── Group 8: WebSSH ───
echo -e "${MAGENTA}${BOLD}  ╭─── 💻 WEB SSH TERMINAL ───╮${NC}"
watermark
echo ""

set_env_var "WEBSSH_ENABLED" "Enable WebSSH (true/false)" "true" "no"
set_env_var "WEBSSH_PORT" "WebSSH port" "5000" "no"
set_env_var "WEBSSH_SERVER_IP" "WebSSH server IP" "$AUTO_IP" "no"
set_env_var "WEBSSH_URL_FORMAT" "URL format" "http://{SERVER_IP}:{PORT}" "no"

echo ""
echo -e "${GREEN}${BOLD}  ✔ .env configuration complete!${NC}"
watermark
echo ""
echo -e "${CYAN}  📄 Preview (secrets hidden):${NC}"
grep -v "TOKEN\|PASSWORD\|SECRET" .env | sed 's/^/    /' | head -30
echo ""
watermark

# ═════════════════════════════════════════════════════════════
#  STEP 5: FIND BOT SCRIPT
# ═════════════════════════════════════════════════════════════
section "5/7" "Locating Bot Entry Point"

BOT_DIR="$(pwd)"
BOT_SCRIPT=""

for candidate in "bot.py" "main.py" "app.py" "index.py" "start.py"; do
    if [ -f "${BOT_DIR}/${candidate}" ]; then
        BOT_SCRIPT="${BOT_DIR}/${candidate}"
        break
    fi
done

if [ -z "$BOT_SCRIPT" ]; then
    BOT_SCRIPT=$(find "$BOT_DIR" -maxdepth 2 -type f \( -name "bot.py" -o -name "main.py" \) 2>/dev/null | head -n 1)
fi

if [ -z "$BOT_SCRIPT" ]; then
    echo -e "${RED}  ✖ Could not find bot entry script!${NC}"
    echo -e "${YELLOW}  → Place your bot.py in ${BOT_DIR}${NC}"
    exit 1
fi

echo -e "${GREEN}  ✔ Found entry point: ${WHITE}${BOT_SCRIPT}${NC}"
watermark

# ═════════════════════════════════════════════════════════════
#  STEP 6: SYSTEMD SERVICE
# ═════════════════════════════════════════════════════════════
section "6/7" "Creating systemd Service"

progress_bar 1.0 "Writing /etc/systemd/system/bot.service"

cat > /etc/systemd/system/bot.service << EOF
# ═══════════════════════════════════════════════════════════════
#   HOPINGBOYZ — AtyroCloud LXC Bot Service
#   Auto-generated by installer.sh
# ═══════════════════════════════════════════════════════════════
[Unit]
Description=HOPINGBOYZ VPS Deploy Bot
After=network.target
Wants=network-online.target

[Service]
Type=simple
User=root
WorkingDirectory=${BOT_DIR}
ExecStart=/usr/bin/python3 ${BOT_SCRIPT}
Restart=always
RestartSec=5
Environment=PYTHONUNBUFFERED=1
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target

# ─── Powered by HOPINGBOYZ ───
EOF

echo -e "${GREEN}  ✔ Service file created${NC}"
watermark

# ═════════════════════════════════════════════════════════════
#  STEP 7: ENABLE & START SERVICE
# ═════════════════════════════════════════════════════════════
section "7/7" "Enabling & Starting Service"

(systemctl daemon-reload > /dev/null 2>&1) &
spinner $! "Reloading systemd daemon"

(systemctl enable bot > /dev/null 2>&1) &
spinner $! "Enabling bot service"

(systemctl restart bot > /dev/null 2>&1) &
spinner $! "Starting bot service"

sleep 3

echo ""
if systemctl is-active --quiet bot; then
    echo -e "${GREEN}${BOLD}  ✔ Bot service is RUNNING 🎉${NC}"
    STATUS="✅ RUNNING"
else
    echo -e "${RED}${BOLD}  ✖ Bot service failed to start${NC}"
    echo -e "${YELLOW}  → Check logs: journalctl -u bot -e --no-pager${NC}"
    STATUS="❌ FAILED"
fi

# ═════════════════════════════════════════════════════════════
#  FINAL BANNER
# ═════════════════════════════════════════════════════════════
echo ""
echo -e "${GREEN}${BOLD}"
cat << "EOF"
    ╔═══════════════════════════════════════════════════════════════╗
    ║                                                               ║
    ║              ✅   I N S T A L L A T I O N                     ║
    ║                     C O M P L E T E !                         ║
    ║                                                               ║
    ║              ▸  HOPINGBOYZ  ×  ATYRO CLOUD  ◂                 ║
    ║                                                               ║
    ╚═══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

watermark
echo ""
echo -e "${CYAN}  📊 ${BOLD}STATUS:${NC} ${STATUS}"
echo -e "${CYAN}  📁 ${BOLD}DIR:${NC}    ${WHITE}${BOT_DIR}${NC}"
echo -e "${CYAN}  📄 ${BOLD}ENV:${NC}    ${WHITE}${BOT_DIR}/.env${NC}"
echo -e "${CYAN}  ⚙️  ${BOLD}SERVICE:${NC} ${WHITE}bot.service${NC}"
echo ""
watermark
echo ""
echo -e "${YELLOW}${BOLD}  📌 USEFUL COMMANDS${NC}"
watermark
echo -e "     ${CYAN}systemctl status bot${NC}      ${DIM}→ Check status${NC}"
echo -e "     ${CYAN}systemctl restart bot${NC}     ${DIM}→ Restart bot${NC}"
echo -e "     ${CYAN}systemctl stop bot${NC}        ${DIM}→ Stop bot${NC}"
echo -e "     ${CYAN}systemctl disable bot${NC}     ${DIM}→ Disable autostart${NC}"
echo -e "     ${CYAN}journalctl -u bot -f${NC}      ${DIM}→ Live logs${NC}"
echo -e "     ${CYAN}journalctl -u bot -n 100${NC}  ${DIM}→ Last 100 lines${NC}"
echo -e "     ${CYAN}nano ${BOT_DIR}/.env${NC}      ${DIM}→ Edit env vars${NC}"
echo ""
watermark
echo ""
echo -e "${MAGENTA}${BOLD}        💜 Thanks for using HOPINGBOYZ Installer 💜${NC}"
echo -e "${MAGENTA}${DIM}              © HOPINGBOYZ • All Rights Reserved${NC}"
watermark
echo ""
