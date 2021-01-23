gpg --quiet --batch --yes --decrypt --passphrase "${DECRYPT_KEY}" \
  --output .github/secrets/certs.p12 \
  .github/secrets/certs.p12.gpg
gpg --quiet --batch --yes --decrypt --passphrase "${DECRYPT_KEY}" \
  --output .github/secrets/provision_profile.mobileprovision \
  .github/secrets/provision_profile.mobileprovision.gpg

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

cp ./.github/secrets/provision_profile.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/

security create-keychain -p "" build.keychain
security import ./.github/secrets/certs.p12 -t agg -k ~/Library/Keychains/build.keychain -P "" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain

security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain

