impaste: impaste.swift
	swiftc -o $@ $<

clean:
	rm -f impaste

.PHONY: clean
