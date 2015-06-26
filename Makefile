SRCROOT=LinuxOrgRu
TESTSROOT=LinuxOrgRuTests
PODSROOT=Pods
WORKSPACE=LinuxOrgRu
SCHEME=LinuxOrgRu

XCTOOL_REPORTER=-reporter json-compilation-database:compile_commands.json
XCODEBUILD=xcodebuild -workspace $(WORKSPACE).xcworkspace -scheme $(SCHEME) -configuration Debug -sdk iphonesimulator


format:
	find $(SRCROOT) $(TESTSROOT) -name '*.m' -o -name '*.h' | xargs clang-format -i

static-analysis:
	xctool $(XCTOOL_REPORTER) clean build
	oclint-json-compilation-database -e $(PODSROOT) -- -max-priority-1 1000 -max-priority-2 1000 -max-priority-3 1000

clean:
	xctool clean

infer:
	infer -i -- $(XCODEBUILD)
