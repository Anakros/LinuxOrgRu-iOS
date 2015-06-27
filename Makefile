SRCROOT=LinuxOrgRu
TESTSROOT=LinuxOrgRuTests
PODSROOT=Pods
WORKSPACE=LinuxOrgRu.xcworkspace
SCHEME=LinuxOrgRu
PROJECT_TARGET=LinuxOrgRu
PODS_TARGET=Pods-LinuxOrgRu

XCTOOL_REPORTER=-reporter json-compilation-database:compile_commands.json

format:
	find $(SRCROOT) $(TESTSROOT) -name '*.m' -o -name '*.h' | xargs clang-format -i

oclint:
	xctool $(XCTOOL_REPORTER) clean build
	oclint-json-compilation-database -e $(PODSROOT) -- -max-priority-1 1000 -max-priority-2 1000 -max-priority-3 1000

build-project:
	xcodebuild -target $(PROJECT_TARGET) -configuration Debug -sdk iphonesimulator

build-pods:
	cd Pods && xcodebuild -target $(PODS_TARGET) -configuration Debug -sdk iphonesimulator

clean:
	xcodebuild -target $(PROJECT_TARGET) -configuration Debug -sdk iphonesimulator clean

clean-pods:
	cd Pods && xcodebuild -target $(PODS_TARGET) -configuration Debug -sdk iphonesimulator clean

infer: clean clean-pods
	cd Pods && xcodebuild -target $(PODS_TARGET) -configuration Debug -sdk iphonesimulator
	infer -- xcodebuild -target $(PROJECT_TARGET) -configuration Debug -sdk iphonesimulator
