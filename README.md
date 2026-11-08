# niri-touchscreen-gestures

Gestos táctiles de pantalla (touchscreen) con **3 dedos** para cambiar de workspace en **niri** (Wayland), sobre Arch Linux.

Incluye: parches aplicados sobre niri 26.04, `PKGBUILD` de Arch, configuración de `config.kdl` y un workflow de GitHub Actions para compilar en remoto.

---

## ¿Por qué 3 dedos?

- **2 dedos** = pellizcar/expandir (zoom en navegador y mapas). No se toca.
- **3 dedos** = cambiar de workspace. Cómodo y sin conflictos.
- **4 dedos** = incómodo para navegar entre workspaces; se reserva para otras acciones.

niri mainline **no soporta gestos táctiles en pantalla** (solo en trackpad vía libinput). Este proyecto aplica un set de parches (derivado de [GGEZUS/niri-tablet](https://github.com/GGEZUS/niri-tablet)) sobre niri 26.04 para añadir:

- Swipe de 3 dedos arriba/abajo → cambiar de workspace
- Swipe de 3 dedos izquierda/derecha → navegar columnas
- Taps y hold-swipe táctiles

---

## Requisitos

- Arch Linux con **niri 26.04** (o instalar este paquete que lo reemplaza)
- Rust toolchain (`cargo`, `rustc`)
- `base-devel`, `wayland-protocols`, `libinput`, `libxkbcommon`, `mesa`, `cairo`, `pango`, `pixman`, `seatd`, `pipewire`, `systemd-libs`, `libdisplay-info`
- `git`, `makepkg`

---

## Instalación rápida (Arch, local)

```bash
# 1. Instalar dependencias
sudo pacman -S --needed base-devel rust cargo git wayland-protocols \
  libinput libxkbcommon mesa cairo pango pixman seatd pipewire \
  systemd-libs libdisplay-info clang

# 2. Clonar este repo
git clone https://github.com/Inghenius-Lab/arch-niri-touchscreen-gestures.git
cd arch-niri-touchscreen-gestures

# 3. Compilar e instalar (reemplaza niri oficial)
makepkg -si   # usa PKGBUILD incluido

# 4. Añadir gestos a ~/.config/niri/config.kdl
# Copiar el bloque de config/gestures.kdl dentro de gestures {}
```

---

## Configuración de niri

Añade (o edita) el bloque `gestures` en `~/.config/niri/config.kdl`:

```kdl
gestures {
    hot-corners {
        off

        bottom-right
        bottom-left
        top-right
        top-left
    }
    touchscreen-swipe {
        fingers 4
    }
}
```

- `fingers 3` → activa gestos de 3 dedos para cambiar de workspace (recomendado)
- Cambia a `fingers 4` si prefieres 4 dedos
- Añade `off` para desactivar

Después de editar, reinicia la sesión de niri (logout/login).

---

## Compilación en remoto (GitHub Actions)

Incluye `.github/workflows/build-release.yml`. Al hacer push a `main` o disparar el workflow manualmente, se compila el binario `niri` y se sube como artefacto descargable de GitHub Actions.

El binario resultante se instala en `/usr/sbin/niri` (reemplazando el de Arch oficial).

---

## Estructura

```
.
├── PKGBUILD                 # Construye niri-tablet (niri 26.04 + parches táctiles)
├── install.sh               # Script de instalación rápida
├── config/gestures.kdl      # Bloque gestures para copiar en config.kdl
├── .github/workflows/
│   └── build-release.yml    # CI: compila y sube artefacto
└── README.md                # Este archivo
```

---

## Créditos

Parches base: [GGEZUS/niri-tablet](https://github.com/GGEZUS/niri-tablet) (derivado de [pir0c0pter0/niri-touch-gestures](https://github.com/pir0c0pter0/niri-touch-gestures)).

---

## Licencia

GPL-3.0-only (misma que niri).
