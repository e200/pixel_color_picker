import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;

class ColorPicker {
  Future<Color> fromImage(Image image) async {
    final _offsetCenter = Offset(image.width / 2, image.height / 2);

    final _imageByteData = await image.toByteData(format: ImageByteFormat.png);

    final _imageBuffer = _imageByteData.buffer;

    final _decodedImage = img.decodeImage(_imageBuffer.asUint8List());

    final _abgrPixel = _decodedImage.getPixelSafe(
      _offsetCenter.dx.toInt(),
      _offsetCenter.dy.toInt(),
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
