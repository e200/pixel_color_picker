# pixel_color_picker

A widget that extracts colors from its childs.

This package lets you basically extract colors from everything in your screen.

![Overview][overview]

## Getting Started

In the pubspec.yaml of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  pixel_color_picker:
```

Import the package in your code:

```dart
import 'package:local_hero/local_hero.dart';
```

## Usage

Wrap the target widget inside `PixelColorPicker`:

```dart
PixelColorPicker(
  child: Image.asset('image.png'),
  onChanged: (color) {
    setState(() {
      this.color = color;
    });
  }
);
```

And whenever the user taps the child, the `onChanged` event will give the color of the pixel on that position.

It's still under development, but you can already play with it.

## Contributions

Any contribution to this project is welcome.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue][issue].
If you fixed a bug or implemented a feature, please send a [pull request][pr].

<!--Links-->
[pub_badge]: https://img.shields.io/pub/v/pixel_color_picker.svg
[pub]: https://pub.dartlang.org/packages/pixel_color_picker
[issues]: https://github.com/e200/pixel_color_picker/issues
[pull_requests]: https://github.com/e200/pixel_color_picker/pulls
[screeshot]: https://raw.githubusercontent.com/e200/pixel_color_picker/master/packages/screenshots/screenshot.gif
