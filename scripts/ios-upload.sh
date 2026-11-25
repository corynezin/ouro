#!/bin/zsh
# Uploads a signed package to App Store Connect, where it becomes a TestFlight build: ios-upload.sh <path to .ipa>
# Uses an App Store Connect API key, given by the environment; no key material is committed:
#   ASC_KEY_ID     the key's ID (its file is AuthKey_<ASC_KEY_ID>.p8)
#   ASC_ISSUER_ID  the issuer ID shown beside the key in App Store Connect
#   ASC_KEYS_DIR   the folder holding the .p8 (default ~/.appstoreconnect/private_keys, where altool looks)
set -euo pipefail
ipa=${1:?usage: ios-upload.sh <ipa>}
key_id=${ASC_KEY_ID:?set ASC_KEY_ID to your App Store Connect API key ID}
issuer=${ASC_ISSUER_ID:?set ASC_ISSUER_ID to your App Store Connect issuer ID}
keys_dir=${ASC_KEYS_DIR:-$HOME/.appstoreconnect/private_keys}
API_PRIVATE_KEYS_DIR=$keys_dir xcrun altool --upload-app -f "$ipa" -t ios --apiKey "$key_id" --apiIssuer "$issuer"
