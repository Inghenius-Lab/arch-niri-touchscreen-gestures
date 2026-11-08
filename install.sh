#!/bin/sh
# install.sh — Instala niri con gestos táctiles de 4 dedos en Arch Linux.
# Uso: ./install.sh
set -eu

echo "==> Instalando dependencias..."
sudo pacman -S --needed --noconfirm base-devel rust cargo git \
  wayland-protocols libinput libxkbcommon mesa cairo pango pixman seatd \
  pipewire systemd-libs libdisplay-info clang

echo "==> Construyendo e instalando niri-tablet..."
makepkg -si

echo "==> Hecho. Ahora añade el bloque de gestos a ~/.config/niri/config.kdl:"
echo "    cat config/gestures.kdl >> ~/.config/niri/config.kdl  (o edita a mano)"
echo ""
echo "==> Reinicia la sesión de niri (logout/login) para activar los gestos de 4 dedos."
