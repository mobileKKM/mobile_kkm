#!/bin/sh
# Removes Google Play Services from the two plugins that pull it in, for the
# F-Droid build (its scanner rejects com.google.android.gms). Both already run
# without it: geolocator_android then uses LocationManagerClient, maplibre_gl
# its MapLibreGPSLocationEngine. Only the GMS branch and the dependency go.
#
#   sh tool/fdroid/strip_gms.sh [pub cache]   # default: $PUB_CACHE or ~/.pub-cache
#
# Run after `flutter pub get`; the plugin versions come from pubspec.lock. It
# fails when a plugin update moved the code it patches, or when anything of
# GMS is left, so such an update stops the build instead of shipping GMS.
set -eu
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
CACHE="${1:-${PUB_CACHE:-$HOME/.pub-cache}}/hosted/pub.dev"

plugin() { # <package>: its android/ folder in the pub cache
  version=$(awk -v p="  $1:" '$0 == p { found = 1 } found && $1 == "version:" { gsub(/"/, "", $2); print $2; exit }' \
    "$ROOT/pubspec.lock")
  dir="$CACHE/$1-$version/android"
  [ -n "$version" ] && [ -d "$dir" ] || { echo "strip_gms.sh: $1 ${version:-?} not in $CACHE" >&2; exit 1; }
  echo "$dir"
}

patch() { # <file> <perl substitution>: must change the file
  before=$(cksum < "$1")
  perl -0pi -e "$2" "$1"
  [ "$(cksum < "$1")" != "$before" ] || { echo "strip_gms.sh: no match in $1" >&2; exit 1; }
}

GEO=$(plugin geolocator_android)
patch "$GEO/build.gradle" 's/^.*play-services.*\n//mg'
rm "$GEO/src/main/java/com/baseflow/geolocator/location/FusedLocationClient.java"
MANAGER="$GEO/src/main/java/com/baseflow/geolocator/location/GeolocationManager.java"
patch "$MANAGER" 's/^import com\.google\.android\.gms\..*\n//mg'
patch "$MANAGER" 's/return isGooglePlayServicesAvailable\(context\)\s*\?\s*new FusedLocationClient\(context, locationOptions\)\s*:\s*(new LocationManagerClient\(context, locationOptions\);)/return $1/'
patch "$MANAGER" 's/\n  private boolean isGooglePlayServicesAvailable\(Context context\) \{.*?\n  \}\n//s'

MAP=$(plugin maplibre_gl)
patch "$MAP/build.gradle" 's/^.*play-services.*\n//mg'
rm "$MAP/src/main/java/org/maplibre/maplibregl/GMSLocationEngine.java"
FACTORY="$MAP/src/main/java/org/maplibre/maplibregl/LocationEngineFactory.kt"
patch "$FACTORY" 's/^import com\.google\.android\.gms\..*\n//mg'
patch "$FACTORY" 's/if \(isGooglePlayServicesAvailable\(context\)\) \{\s*GMSLocationEngine\(context\)\s*\} else \{\s*(MapLibreGPSLocationEngine\(context\))\s*\}/$1/'
patch "$FACTORY" 's/\n    private fun isGooglePlayServicesAvailable\(context: Context\): Boolean \{.*?\n    \}\n//s'

if grep -rIlE 'com\.google\.android\.gms|GoogleApiAvailability|FusedLocation|GMSLocationEngine' "$GEO" "$MAP"; then
  echo "strip_gms.sh: GMS still referenced in the files above" >&2
  exit 1
fi

echo "strip_gms.sh: removed GMS from geolocator_android and maplibre_gl"
