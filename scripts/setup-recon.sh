#!/bin/bash
# setup-recon.sh — Simple setup for recon automation tools
#
# Usage:
#   chmod +x setup-recon.sh
#   ./setup-recon.sh
#
# Description:
#   This script automates installation of Go, configures Go environment paths,
#   removes legacy httpx, installs ProjectDiscovery’s Tool Manager (pdtm),
#   and installs a full suite of recon tools for bug bounty automation.
#
#   It will automatically reload your shell at the end so the new environment
#   variables take effect immediately.

echo "[*] Installing Go..."
sudo apt update -y && sudo apt install -y golang

echo "[*] Setting Go environment in ~/.zshrc..."
{
  echo ''
  echo '# Go environment variables'
  echo 'export GOROOT=/usr/lib/go'
  echo 'export GOPATH=$HOME/go'
  echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH'
} >> ~/.zshrc

echo "[*] Removing old httpx..."
sudo rm -f /usr/bin/httpx

echo "[*] Installing ProjectDiscovery Tool Manager (pdtm) and their dependencies..."
go install -v github.com/projectdiscovery/pdtm/cmd/pdtm@latest
sudo apt install -y libpcap-dev
sudo apt install -y massdns

echo "[*] Installing ProjectDiscovery recon tools..."
# run inside zsh so PATH from .zshrc applies
zsh -i -c "source ~/.zshrc && pdtm -i alterx,chaos-client,dnsx,httpx,katana,mapcidr,naabu,notify,nuclei,shuffledns,subfinder,tldfinder,uncover,urlfinder"

echo "[+] All done!"
echo "[*] Reloading shell to apply Go environment..."
exec "$SHELL" -l