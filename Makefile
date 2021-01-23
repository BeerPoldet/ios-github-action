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
             -archivePath ${PWD}/build/iOSGithubCI.xcarchive \
             clean archive | xcpretty
	xcodebuild -archivePath ${PWD}/build/iOSGithubCI.xcarchive \
             -exportOptionsPlist ${PWD}/App/exportOptions.plist \
             -exportPath ${PWD}/build \
             -allowProvisioningUpdates \
             -exportArchive | xcpretty

upload:
	xcrun altool --upload-app -t ios -f ${PWD}/build/App.ipa \
    -u "${APPLEID_USERNAME}" -p "${APPLEID_PASSWORD}" --verbose

init-deployment-secrets:
	./.github/scripts/init-deployment-secrets.sh
