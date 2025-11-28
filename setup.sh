#!/usr/bin/env bash

# installing nix package manager
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon
. /home/vscode/.nix-profile/etc/profile.d/nix.sh

# enabling nix flakes
mkdir "$HOME"/.config/nix
touch "$HOME"/.config/nix/nix.conf
echo "experimental-features = nix-command flakes" >> "$HOME"/.config/nix/nix.conf
echo "access-tokens = github.com=$NIX_ACCESS_TOKEN" >> "$HOME"/.config/nix/nix.conf

# installing packages
nix_packages=(
  "neovim"
  "nodejs_24"
  "luarocks_bootstrap"
  "ripgrep"
  "lua"
  "fd"
  "lazygit"
  "fzf"
  )
for package in "${nix_packages[@]}"; do
  nix profile add nixpkgs#$package
done

# copiing dotfiles
ln -sf "$PWD/nvim" "$HOME"/.config/nvim
