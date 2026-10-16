#!/bin/sh
# Fails unless an APK is signed with the release key, so a build that fell back
# to the debug key (no android/key.properties) is never published.
#
#   sh tool/ci/check_signer.sh <apk> <certificate SHA-256>
#
# The fingerprint may be written as keytool prints it (upper case, colons) or
# as apksigner does (lower case, no colons).
set -eu
APK="$1"
EXPECTED=$(printf '%s' "$2" | tr -d ': ' | tr '[:upper:]' '[:lower:]')
[ -n "$EXPECTED" ] || { echo "check_signer.sh: no expected fingerprint given" >&2; exit 1; }

APKSIGNER=$(ls -d "$ANDROID_HOME"/build-tools/* | sort -V | tail -n 1)/apksigner
ACTUAL=$("$APKSIGNER" verify --print-certs "$APK" | sed -n 's/^.*ertificate SHA-256 digest: //p' | head -n 1)

if [ "$ACTUAL" != "$EXPECTED" ]; then
  echo "check_signer.sh: $APK is signed with ${ACTUAL:-nothing}, expected $EXPECTED" >&2
  exit 1
fi
echo "check_signer.sh: $APK is signed with the release key"
