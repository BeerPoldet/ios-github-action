xcode:
	xcodegen generate && open iOSGithubCI.xcodeproj

build:
	xcodebuild -project iOSGithubCI.xcodeproj \
             -scheme App \
             -destination platform=iOS\ Simulator,OS=14.3,name=iPhone\ 12\ Pro\ Max  \
             clean test | xcpretty
