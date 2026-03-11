#!/bin/bash
# ═══════════════════════════════════════════════════
#  NSUI Web — GitHub Setup Script
#  Crea il repo e fa il deploy su GitHub Pages
# ═══════════════════════════════════════════════════

USERNAME=${1:-""}
REPO=${2:-"nsui-web"}

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${CYAN}"
echo "  ╔═══════════════════════════════════╗"
echo "  ║   NSUI Web — GitHub Setup Tool   ║"
echo "  ╚═══════════════════════════════════╝"
echo -e "${NC}"

# Check args
if [ -z "$USERNAME" ]; then
  echo -e "${YELLOW}Uso: ./setup.sh <github_username> [nome_repo]${NC}"
  echo -e "${YELLOW}Esempio: ./setup.sh mariorossi nsui-web${NC}"
  exit 1
fi

echo -e "${CYAN}[1/5]${NC} Verifica dipendenze..."

# Check git
if ! command -v git &>/dev/null; then
  echo -e "${RED}✗ git non trovato. Installa git: https://git-scm.com${NC}"
  exit 1
fi
echo -e "${GREEN}  ✓ git trovato${NC}"

# Check gh CLI (optional but helpful)
GH_AVAILABLE=false
if command -v gh &>/dev/null; then
  GH_AVAILABLE=true
  echo -e "${GREEN}  ✓ gh CLI trovato${NC}"
else
  echo -e "${YELLOW}  ⚠ gh CLI non trovato (optional) — crea il repo manualmente su github.com${NC}"
fi

echo ""
echo -e "${CYAN}[2/5]${NC} Inizializzazione repository locale..."

cd "$(dirname "$0")"

if [ -d ".git" ]; then
  echo -e "${YELLOW}  ⚠ Repository git già esistente${NC}"
else
  git init
  echo -e "${GREEN}  ✓ Repository inizializzato${NC}"
fi

git add -A
git commit -m "🎮 Initial commit — NSUI Web GBA to CIA Injector" 2>/dev/null || \
git commit --allow-empty -m "🎮 Initial commit — NSUI Web GBA to CIA Injector"
echo -e "${GREEN}  ✓ Commit creato${NC}"

git branch -M main 2>/dev/null || true

echo ""
echo -e "${CYAN}[3/5]${NC} Configurazione remote GitHub..."

REMOTE_URL="https://github.com/${USERNAME}/${REPO}.git"

if git remote get-url origin &>/dev/null; then
  git remote set-url origin "$REMOTE_URL"
  echo -e "${GREEN}  ✓ Remote aggiornato: ${REMOTE_URL}${NC}"
else
  git remote add origin "$REMOTE_URL"
  echo -e "${GREEN}  ✓ Remote aggiunto: ${REMOTE_URL}${NC}"
fi

echo ""
echo -e "${CYAN}[4/5]${NC} Creazione repository su GitHub..."

if [ "$GH_AVAILABLE" = true ]; then
  # Try to create repo with gh CLI
  gh repo create "${USERNAME}/${REPO}" \
    --public \
    --description "GBA to CIA Injector for 3DS Virtual Console — 100% web-based" \
    --homepage "https://${USERNAME}.github.io/${REPO}" 2>/dev/null && \
    echo -e "${GREEN}  ✓ Repository creato su GitHub${NC}" || \
    echo -e "${YELLOW}  ⚠ Repository forse già esistente, continuo...${NC}"
else
  echo -e "${YELLOW}  ⚠ Crea il repository manualmente:${NC}"
  echo -e "     1. Vai su https://github.com/new"
  echo -e "     2. Nome repo: ${REPO}"
  echo -e "     3. Visibilità: Public"
  echo -e "     4. NON inizializzare con README"
  echo -e "     5. Clicca 'Create repository'"
  echo ""
  read -p "  Premi ENTER quando hai creato il repo su GitHub..."
fi

echo ""
echo -e "${CYAN}[5/5]${NC} Push su GitHub..."

git push -u origin main && \
  echo -e "${GREEN}  ✓ Push completato!${NC}" || {
  echo -e "${RED}  ✗ Push fallito. Prova manualmente:${NC}"
  echo -e "     git push -u origin main"
  exit 1
}

echo ""
echo -e "${CYAN}═══════════════════════════════════════════${NC}"
echo -e "${GREEN}  ✓ Deploy completato!${NC}"
echo ""
echo -e "  📋 Prossimi passi:"
echo -e "  1. Vai su: https://github.com/${USERNAME}/${REPO}/settings/pages"
echo -e "  2. Source → seleziona 'GitHub Actions'"
echo -e "  3. Salva — il workflow partirà automaticamente"
echo ""
echo -e "  🌐 Il sito sarà disponibile tra ~2 minuti su:"
echo -e "  ${CYAN}https://${USERNAME}.github.io/${REPO}${NC}"
echo ""
echo -e "  💡 Il workflow GitHub Actions è già configurato in:"
echo -e "     .github/workflows/deploy.yml"
echo -e "${CYAN}═══════════════════════════════════════════${NC}"
