import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;

class ColorPicker {
  img.Image _decodedImage;

  Future<Color> fromImage(
    Image image,
    Offset offset, {
    bool cacheBytes = false,
  }) async {
    final _imageByteData = await image.toByteData(format: ImageByteFormat.png);

    final _imageBuffer = _imageByteData.buffer;

    final _uint8List = _imageBuffer.asUint8List();

    return fromBytes(
      _uint8List,
      offset,
      cache: cacheBytes,
    );
  }

  Future<Color> fromBytes(
    Uint8List bytes,
    Offset pixelPosition, {
    bool cache = false,
  }) async {
    if (cache) {
      _decodedImage ??= img.decodeImage(bytes);
    } else {
      _decodedImage = img.decodeImage(bytes);
    }

    final _abgrPixel = _decodedImage.getPixelSafe(
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
