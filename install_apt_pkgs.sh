#!/usr/bin/env bash

# Update and upgrade already-installed formulae
apt update

apt install -y git
apt install -y zsh
apt install -y curl
apt install -y tmux
apt install -y stow
apt install -y ansible
apt install -y neovim
apt install -y fd-find ripgrep zoxide
apt install -y ffmpeg 7zip jq poppler-utils imagemagick

snap install yazi --classic
