all: build

build:
	swift build

release-build:
	swift build -c release

test:
	swift test

clean:
	swift package clean

.PHONY: clean
