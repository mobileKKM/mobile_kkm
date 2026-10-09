#!/bin/sh
# Renders the launcher icons, the in-app logo and the splash logo from the
# SVGs in assets/branding. They use SVG filters, which neither Android vector
# drawables nor flutter_svg can render, so every target is a PNG.
# Needs Google Chrome and macOS sips.
#
#   sh tool/render_branding.sh && dart run flutter_native_splash:create
set -e
cd "$(dirname "$0")/../assets/branding"
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
RES=../../android/app/src/main/res
IOS=../../ios/Runner/Assets.xcassets/AppIcon.appiconset
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# Every target is downscaled from an oversized master: rendered straight at
# the target size, the filter edges come out stair-stepped.
master() { # <name> <size> <body html>
  printf '<body style="margin:0">%s</body>' "$3" > "$TMP/$1.html"
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars \
    --force-device-scale-factor=1 --default-background-color=00000000 \
    --window-size="$2,$2" --screenshot="$TMP/$1.png" "file://$TMP/$1.html" >/dev/null 2>&1
}
scale() { # <master name> <size> <out>
  sips -z "$2" "$2" "$TMP/$1.png" --out "$3" >/dev/null
}

# A square of <size> px showing the adaptive icon's visible 72dp centre (288
# of the 432 units), filled with <content>, which is laid out on the full
# canvas (1.5x the square).
crop() { # <size> <content html>
  printf '<div style="width:%spx;height:%spx;overflow:hidden;position:relative">' "$1" "$1"
  printf '<div style="position:absolute;left:-%spx;top:-%spx;width:%spx;height:%spx">%s</div></div>' \
    $(($1 / 4)) $(($1 / 4)) $(($1 * 3 / 2)) $(($1 * 3 / 2)) "$2"
}
layer() { # <svg>
  printf '<img src="file://%s/%s" style="position:absolute;width:100%%;height:100%%">' "$PWD" "$1"
}
full() { # <size>: background + foreground
  crop "$1" "$(layer app_icon_bg.svg)$(layer app_icon_fg.svg)"
}

# Adaptive icon layers: the full 108dp canvas.
master fg 1728 "<div style=\"width:1728px;height:1728px;position:relative\">$(layer app_icon_fg.svg)</div>"
master mono 1728 "<div style=\"width:1728px;height:1728px;position:relative\">$(layer app_icon_mono.svg)</div>"

# Full icon (iOS, Play Store, in-app logo).
master icon 2048 "$(full 2048)"
scale icon 1024 "$IOS/Icon-App-1024x1024@1x.png"
scale icon 512 ../../android/app/src/main/ic_launcher-playstore.png
scale icon 512 ../images/app_logo.png

# iOS dark icon: the coloured logo on the background the system supplies.
master dark 2048 "$(crop 2048 "$(layer app_icon_white_fg.svg)")"
scale dark 1024 "$IOS/Icon-App-Dark-1024x1024@1x.png"

# iOS tinted icon: the regular foreground in greyscale, also without a
# background. Its full-canvas gloss is meant for the blue background and would
# show as a haze here, so it is hidden.
GLOSS='rect[fill^="url(#paint3_radial"]'
grep -q '<rect width="432" height="432" fill="url(#paint3_radial' app_icon_fg.svg || {
  echo "render_branding.sh: gloss layer not found in app_icon_fg.svg" >&2
  exit 1
}
master tinted 2048 "<style>svg{position:absolute;width:100%;height:100%;filter:grayscale(1)}$GLOSS{display:none}</style>$(
  crop 2048 "$(cat app_icon_fg.svg)"
)"
scale tinted 1024 "$IOS/Icon-App-Tinted-1024x1024@1x.png"

# Legacy icons (before API 26): the full icon on a 48dp canvas (32px per dp),
# shaped and shadowed like the ones Android Studio generates.
legacy() { # <shape size> <border radius>
  printf '<div style="width:1536px;height:1536px;display:flex;align-items:center;justify-content:center">'
  printf '<div style="filter:drop-shadow(0 16px 12px rgba(0,0,0,.4))">'
  printf '<div style="border-radius:%s;overflow:hidden">%s</div></div></div>' "$2" "$(full "$1")"
}
master legacy 1536 "$(legacy 1216 96px)"
master legacy_round 1536 "$(legacy 1408 50%)"

# Android: <density>:<legacy icon px>:<adaptive layer px>
for spec in mdpi:48:108 hdpi:72:162 xhdpi:96:216 xxhdpi:144:324 xxxhdpi:192:432; do
  IFS=: read -r density legacy_px layer_px <<SPEC
$spec
SPEC
  scale legacy "$legacy_px" "$RES/mipmap-$density/ic_launcher.png"
  scale legacy_round "$legacy_px" "$RES/mipmap-$density/ic_launcher_round.png"
  scale fg "$layer_px" "$RES/mipmap-$density/ic_launcher_foreground.png"
  scale mono "$layer_px" "$RES/mipmap-$density/ic_launcher_monochrome.png"
done

# Splash logo: the coloured ticket (176 of the 432 units wide), centred and
# filling 3/4 of a <logo> px box in the middle of a <canvas> px image.
splash() { # <canvas> <logo>
  printf '<div style="width:%spx;height:%spx;overflow:hidden;position:relative">' "$1" "$1"
  printf '<img src="file://%s/app_icon_white_fg.svg" style="position:absolute;--u:calc(%spx * 3 / 704);' "$PWD" "$2"
  printf 'width:calc(432 * var(--u));left:calc(%spx / 2 - 216 * var(--u));top:calc(%spx / 2 - 216 * var(--u))"></div>' \
    "$1" "$1"
}
master splash 2048 "$(splash 2048 2048)"
scale splash 512 ../images/splash_logo.png

# Android 12+ splash icon: a 288dp canvas that the system masks to a circle of
# 2/3 of it. The logo takes 128dp of it (512 of 1152px), the size SplashScreen
# and the other native splashes draw it at, so the hand-over does not jump.
master splash_android12 2304 "$(splash 2304 1024)"
scale splash_android12 1152 splash_android12.png

# Cover for the app switcher while the ticket code is on the screen
# (no_screenshot's image overlay; see ScreenSecurity): the launch screen, i.e.
# the splash logo at its 128dp on the splash background. The plugin stretches
# the image to fill the screen, so it is a whole phone screen (390x844dp at
# 3x), rendered at twice that like the other masters.
cover() { # <name> <background> <out>...
  printf '<body style="margin:0"><div style="width:2340px;height:5064px;background:%s;display:flex;align-items:center;justify-content:center">%s</div></body>' \
    "$2" "$(splash 768 768)" > "$TMP/$1.html"
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars \
    --force-device-scale-factor=1 --window-size=2340,5064 \
    --screenshot="$TMP/$1.png" "file://$TMP/$1.html" >/dev/null 2>&1
  name="$1"
  shift 2
  for out in "$@"; do
    mkdir -p "$(dirname "$out")"
    sips -z 2532 1170 "$TMP/$name.png" --out "$out" >/dev/null
  done
}
COVER=../../ios/Runner/Assets.xcassets/NoScreenshotImage.imageset
# Colours as in flutter_native_splash (pubspec.yaml).
cover cover '#FFFFFF' "$COVER/NoScreenshotImage@3x.png" "$RES/drawable-nodpi/no_screenshot_image.png"
cover cover_dark '#121318' "$COVER/NoScreenshotImageDark@3x.png" "$RES/drawable-night-nodpi/no_screenshot_image.png"
