# impaste - Clipboard image saver

A command-line application for macOS that saves the clipboard image to a file or
outputs the raw bytes to stdout.

## How it works

It saves the clipboard image to a specified file path, or to stdout if it is
redirected.

## Requirements

- macOS
- Xcode Command Line Tools

## Installation

1. Clone the repository or download the source code.
2. Compile the Swift code using the following command:

```sh
swiftc impaste.swift
```

## Usage

To save the clipboard image to a file:

```sh
impaste <file_path>
```

To output the raw bytes of the clipboard image to stdout:

```sh
impaste > <file_path>
```

To force output the raw bytes to stdout even if stdout is a terminal. Note that
this might cause your terminal to enter an odd state.

```sh
impaste [-f | --force]
```

## License

This project is licensed under the [MIT No Attribution License](COPYING).
