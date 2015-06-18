SRCROOT=LinuxOrgRu
TESTSROOT=LinuxOrgRuTests
PODSROOT=Pods

XCTOOL_REPORTER=-reporter json-compilation-database:compile_commands.json

format:
	find $(SRCROOT) $(TESTSROOT) -name '*.m' -o -name '*.h' | xargs clang-format -i

static-analysis:
	xctool $(XCTOOL_REPORTER) clean build
	oclint-json-compilation-database -e $(PODSROOT) -- -max-priority-1 1000 -max-priority-2 1000 -max-priority-3 1000

clean:
	xctool clean
