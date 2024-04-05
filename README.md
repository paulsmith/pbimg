# pbimg - Clipboard image saver

A command-line application for macOS that saves the clipboard image to a file or
outputs the raw bytes to stdout. It works similarly to `pbpaste`, but that utility
is limited to textual data.

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
swift build
```

Then copy the build artifact `./.build/arm64-apple-macosx/debug/pbimg` to your
$PATH.

Example:

```sh
install -m 0755 ./.build/arm64-apple-macosx/debug/pbimg $HOME/.local/bin
```

## Usage

To save the clipboard image to a file:

```sh
pbimg <file_path>
```

To output the raw bytes of the clipboard image to stdout:

```sh
pbimg > <file_path>
```

To force output the raw bytes to stdout even if stdout is a terminal. Note that
this might cause your terminal to enter an odd state.

```sh
pbimg [-f | --force]
```

## Example

For example, use the screenshot utility to copy a screenshot to the clipboard:
`⌘`+`⌃`+`⇧`+`4`

```sh
pbimg output.png
```

https://github.com/paulsmith/pbimg/assets/1210/8b3a32b4-33d8-4e5a-a9ec-cb67a5ed1681

### Convert format

With ImageMagick (or GraphicsMagick) installed, convert between formats with a
pipeline:

```sh
pbimg | convert - output.gif
```

```sh
pbimg | convert - -quality 65 output.jpg
```

### Resize

```sh
pbimg | convert - -resize 25% thumbnail.png
```

### Get info about image on pasteboard

```sh
pbimg | identify -
-=>/var/folders/mc/p59f_1dd1w9b9tfc1zc6f1gr0000gn/T/magick-7LMqLeLrxmEOVvX3zBqn_VF8y2ouyaVO PNG 3248x2080 3248x2080+0+0 8-bit sRGB 970964B 0.010u 0:00.000
```

### Upload to web service

```sh
pbimg | curl --data-binary @- https://example.com/upload
```

## Credit

[Simon Willison](https://til.simonwillison.net/macos/impaste) for the idea.

## License

This project is licensed under the [MIT No Attribution License](COPYING).
