xcode:
	xcodegen generate && open iOSGithubCI.xcodeproj

xcg:
	xcodegen generate

test:
	xcodebuild -resolvePackageDependencies -clonedSourcePackagesDirPath .build
	xcodebuild -project iOSGithubCI.xcodeproj \
             -scheme App \
             -destination platform=iOS\ Simulator,OS=14.3,name=iPhone\ 12\ Pro\ Max  \
             -clonedSourcePackagesDirPath .build \
             test | xcpretty

archive:
	xcodebuild -project iOSGithubCI.xcodeproj \
             -scheme App \
             -sdk iphoneos \
             -configuration Release \
             -archivePath ${PWD}/build/iOSGithubCI.xcarchive \
             -clonedSourcePackagesDirPath .build \
             archive | xcpretty

	xcodebuild -archivePath ${PWD}/build/iOSGithubCI.xcarchive \
             -exportOptionsPlist ${PWD}/App/exportOptions.plist \
             -exportPath ${PWD}/build \
             -allowProvisioningUpdates \
             -exportArchive | xcpretty

upload:
	xcrun altool --upload-app -t ios -f ${PWD}/build/iOSGithubCI.ipa \
    -u "${APPLEID_USERNAME}" -p "${APPLEID_PASSWORD}" --verbose

init-deployment-secrets:
	./.github/scripts/init-deployment-secrets.sh
