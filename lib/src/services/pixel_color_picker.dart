import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;

class ColorPicker {
  final Uint8List? bytes;

  img.Image? _decodedImage;

  ColorPicker({this.bytes});

  Future<Color> getColor({required Offset pixelPosition}) async {
    _decodedImage ??= img.decodeImage(bytes!);

    final _abgrPixel = _decodedImage!.getPixelSafe(
      pixelPosition.dx.toInt(),
      pixelPosition.dy.toInt(),
    );

    final _rgba = abgrToRgba(_abgrPixel);

    final _color = Color(_rgba);

    return _color;
  }

  int abgrToRgba(int argb) {
    int r = (argb >> 16) & 0xFF;
    int b = argb & 0xFF;

    final _rgba = (argb & 0xFF00FF00) | (b << 16) | r;

    return _rgba;
  }
}
