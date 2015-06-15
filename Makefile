SRCROOT=LinuxOrgRu

format:
	find $(SRCROOT) -name '*.m' -o -name '*.h' | xargs clang-format -i
