#!/bin/bash
# Ubuntu tools that are missing or stale in apt. Idempotent; safe to re-run.
set -euo pipefail
USER="${USER:-$(id -un)}"   # unset under sudo -u and in containers
BIN="$HOME/.local/bin"; mkdir -p "$BIN"
ARCH=$(dpkg --print-architecture)   # amd64 | arm64
have() { command -v "$1" >/dev/null 2>&1; }
KEYRINGS=/etc/apt/keyrings; sudo install -m 0755 -d $KEYRINGS
UBU=$(. /etc/os-release && echo "$VERSION_CODENAME")

# gh
if ! have gh; then
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee $KEYRINGS/githubcli-archive-keyring.gpg >/dev/null
  echo "deb [arch=$ARCH signed-by=$KEYRINGS/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
fi
# docker engine
if ! have docker; then
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o $KEYRINGS/docker.gpg
  echo "deb [arch=$ARCH signed-by=$KEYRINGS/docker.gpg] https://download.docker.com/linux/ubuntu $UBU stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
fi
# cloudflared
if ! have cloudflared; then
  curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee $KEYRINGS/cloudflare-main.gpg >/dev/null
  echo "deb [signed-by=$KEYRINGS/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared $UBU main" | sudo tee /etc/apt/sources.list.d/cloudflared.list >/dev/null
fi
# kubectl
if ! have kubectl; then
  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o $KEYRINGS/kubernetes-apt-keyring.gpg
  echo "deb [signed-by=$KEYRINGS/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list >/dev/null
fi
sudo apt-get update -q
sudo apt-get install -y -q gh docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin cloudflared kubectl
sudo usermod -aG docker "$USER" || true

# neovim: apt lags badly, use the release tarball
if ! have nvim || [ "$(nvim --version | head -1 | grep -oE '[0-9]+\.[0-9]+' | head -1 | cut -d. -f2)" -lt 10 ]; then
  NV_ARCH=$([ "$ARCH" = arm64 ] && echo arm64 || echo x86_64)
  curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$NV_ARCH.tar.gz" | sudo tar -C /opt -xzf -
  sudo ln -sf "/opt/nvim-linux-$NV_ARCH/bin/nvim" /usr/local/bin/nvim
fi
# rclone (apt is old; official script installs to /usr/bin)
have rclone || curl -fsSL https://rclone.org/install.sh | sudo bash
# duckdb
if ! have duckdb; then
  curl -fsSL "https://github.com/duckdb/duckdb/releases/latest/download/duckdb_cli-linux-$ARCH.zip" -o /tmp/duckdb.zip
  unzip -oq /tmp/duckdb.zip -d "$BIN" && rm /tmp/duckdb.zip
fi
# yq
have yq || sudo curl -fsSL "https://github.com/mikefarah/yq/releases/latest/download/yq_linux_$ARCH" -o /usr/local/bin/yq && sudo chmod +x /usr/local/bin/yq
# himalaya (mail cli)
if ! have himalaya; then
  H_ARCH=$([ "$ARCH" = arm64 ] && echo aarch64 || echo x86_64)
  curl -fsSL "https://github.com/pimalaya/himalaya/releases/latest/download/himalaya.$H_ARCH-linux.tgz" | tar -C "$BIN" -xzf - himalaya 2>/dev/null || echo "   ! himalaya download failed; install with: cargo install himalaya"
fi
# aws cli v2
if ! have aws; then
  A_ARCH=$([ "$ARCH" = arm64 ] && echo aarch64 || echo x86_64)
  curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-$A_ARCH.zip" -o /tmp/awscliv2.zip
  unzip -oq /tmp/awscliv2.zip -d /tmp && sudo /tmp/aws/install --update && rm -rf /tmp/aws /tmp/awscliv2.zip
fi
# helm
have helm || curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
# zsh as login shell
[ "$(basename "$SHELL")" = zsh ] || sudo chsh -s "$(command -v zsh)" "$USER"
