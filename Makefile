
build:
	make build-simulator
	make build-ios
	make merge
	make build-framework

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

build-framework:
	mkdir build/TestStatic.framework
	mkdir build/TestStatic.framework/Headers
	mkdir build/TestStatic.framework/Resources
	cp TestStatic/*.h build/TestStatic.framework/Headers
	mv build/libTestStatic.a build/TestStatic.framework/TestStatic
	cp TestStatic/Info.plist build/TestStatic.framework/Resources


merge:
	# xcode12のcarthage buildは内部的にここでバグってる
	# ref https://github.com/Carthage/Carthage/issues/3019
	lipo -output build/libTestStatic.a -create build/Release-iphoneos/libTestStatic.a build/Release-iphonesimulator/libTestStatic.a

clean:
	rm -rf build
