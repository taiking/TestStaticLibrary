
build:
	make build-simulator
	make build-ios
	make merge

build-simulator:
	xcodebuild \
		-target TestStatic \
		-project TestStatic.xcodeproj \
		-configuration Release \
		-sdk iphonesimulator \
		build \
		| bundle exec xcpretty

build-ios:
	xcodebuild \
		-target TestStatic \
		-project TestStatic.xcodeproj \
		-configuration Release \
		-sdk iphoneos \
		build \
		| bundle exec xcpretty

merge:
	lipo -output build/libTestStatic.a -create build/Release-iphoneos/libTestStatic.a build/Release-iphonesimulator/libTestStatic.a


clean:
	rm -rf build
