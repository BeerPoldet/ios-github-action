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
