#!/bin/sh
# Fails when the release build still depends on Google Play Services, for the
# build without GMS (tool/fdroid/strip_gms.sh). It reads Gradle's dependency
# graph rather than the APK: R8 renames or drops the GMS classes there, so a
# GMS build can look clean.
#
#   sh tool/ci/check_no_gms.sh   # after strip_gms.sh and a build (android/local.properties must exist)
set -eu
cd "$(dirname "$0")/../../android"
DEPS=$(./gradlew -q :app:dependencies --configuration releaseRuntimeClasspath)
FOUND=$(printf '%s\n' "$DEPS" | grep -oE 'com\.google\.android\.gms:[a-z-]+' | sort -u || true)
if [ -n "$FOUND" ]; then
  echo "check_no_gms.sh: the release build still depends on:" >&2
  echo "$FOUND" >&2
  exit 1
fi
echo "check_no_gms.sh: no GMS in the release dependencies"
