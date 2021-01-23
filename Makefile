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
	./.github/scripts/decrypt-secrets.sh
