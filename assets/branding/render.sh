#!/bin/sh
# Rasterises the icon SVGs (they use SVG filters, which neither Android
# vector drawables nor flutter_svg can render). Needs Google Chrome.
#
#   sh assets/branding/render.sh && dart run flutter_launcher_icons
set -e
cd "$(dirname "$0")"
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

shot() { # <html> <size> <out>
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars \
    --force-device-scale-factor=1 --default-background-color=00000000 \
    --window-size="$2,$2" --screenshot="$PWD/$3" "file://$1" >/dev/null 2>&1
}

# Adaptive icon foreground: the full 108dp canvas at 4x (432 -> 1728).
cat > "$TMP/fg.html" <<HTML
<body style="margin:0"><img src="file://$PWD/app_icon_fg.svg" width="1728" height="1728"></body>
HTML
shot "$TMP/fg.html" 1728 icon_fg.png

# Full icon (iOS, Android legacy, in-app logo): background + foreground,
# cropped to the adaptive icon's visible 72dp centre (288 of 432 units).
cat > "$TMP/icon.html" <<HTML
<body style="margin:0"><div style="width:1024px;height:1024px;overflow:hidden;position:relative;background:#303F9F">
<img src="file://$PWD/app_icon_fg.svg" width="1536" height="1536" style="position:absolute;left:-256px;top:-256px">
</div></body>
HTML
shot "$TMP/icon.html" 1024 icon.png
sips -Z 512 icon.png --out ../images/app_logo.png >/dev/null

# Android 12+ splash icon: the system masks it to a circle of 2/3 of the
# canvas, so the logo is centred with padding (1152px canvas, 620px logo).
cat > "$TMP/splash.html" <<HTML
<body style="margin:0"><div style="width:1152px;height:1152px;display:flex;align-items:center;justify-content:center">
<img src="file://$PWD/../images/splash_logo.png" width="620" height="620">
</div></body>
HTML
shot "$TMP/splash.html" 1152 splash_android12.png
