pbimg: Sources/main.swift
	swift build

test:
	swift test

clean:
	swift package clean

.PHONY: clean
