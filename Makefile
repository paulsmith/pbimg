pbimg: pbimg.swift
	swiftc -o $@ $<

clean:
	rm -f pbimg

.PHONY: clean
