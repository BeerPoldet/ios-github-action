xcode:
	xcodegen generate && open iOSGithubCI.xcodeproj

test:
	xcodebuild -project iOSGithubCI.xcodeproj \
             -scheme App \
             -destination platform=iOS\ Simulator,OS=14.3,name=iPhone\ 12\ Pro\ Max  \
             clean test | xcpretty

archive:
	xcodebuild -project iOSGithubCI.xcodeproj \
             -scheme App \
             -sdk iphoneos \
             -configuration AppStoreDistribution \
             -archivePath $PWD/build/iOSGithubCI.xcarchive \
             clean archive | xcpretty

decrypt-secrets:
	openssl enc -d -k "$DECRYPT_KEY" -aes-256-cbc \
    -in .github/secrets/certs.p12.enc \
    -out .github/secrets/certs.p12
	openssl enc -d -k "$DECRYPT_KEY" -aes-256-cbc \
    -in .github/secrets/provision_profile.mobileprovision.enc \
    -out .github/secrets/provision_profile.mobileprovision

	mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
	
	cp ./.github/secrets/provision_profile.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/
	
	security create-keychain -p "" build.keychain
	security import ./.github/secrets/certs.p12 -t agg -k ~/Library/Keychains/build.keychain -P "" -A
	
	security list-keychains -s ~/Library/Keychains/build.keychain
	security default-keychain -s ~/Library/Keychains/build.keychain
	security unlock-keychain -p "" ~/Library/Keychains/build.keychain
	
	security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain

