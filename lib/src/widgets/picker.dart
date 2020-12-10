import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pixel_color_picker/src/services/pixel_color_picker.dart';

class PixelColorPicker extends StatefulWidget {
  final Widget child;
  final Function(Color color) onChanged;

  const PixelColorPicker({
    Key key,
    @required this.child,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _PixelColorPickerState createState() => _PixelColorPickerState();
}

class _PixelColorPickerState extends State<PixelColorPicker> {
  ColorPicker _colorPicker;

  final _repaintBoundaryKey = GlobalKey();
  final _interactiveViewerKey = GlobalKey();

  Future<ui.Image> _loadSnapshot() async {
    final RenderRepaintBoundary _repaintBoundary =
        _repaintBoundaryKey.currentContext.findRenderObject();

    final _snapshot = await _repaintBoundary.toImage();

    return _snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RepaintBoundary(
          key: _repaintBoundaryKey,
          child: ClipRRect(
            child: InteractiveViewer(
              key: _interactiveViewerKey,
              maxScale: 10,
              onInteractionUpdate: (details) {
                final _offset = details.focalPoint;

                _onInteract(_offset);
              },
              child: widget.child,
            ),
          ),
        ),
      ],
    );
  }

  _onInteract(Offset offset) async {
    if (_colorPicker == null) {
      final _snapshot = await _loadSnapshot();

      final _imageByteData =
          await _snapshot.toByteData(format: ui.ImageByteFormat.png);

      final _imageBuffer = _imageByteData.buffer;

      final _uint8List = _imageBuffer.asUint8List();

      _colorPicker = ColorPicker(bytes: _uint8List);

      _snapshot.dispose();
    }

    final _localOffset = _findLocalOffset(offset);

    final _color = await _colorPicker.getColor(pixelPosition: _localOffset);

    widget.onChanged(_color);
  }

  _findLocalOffset(Offset offset) {
    final RenderBox _interactiveViewerBox =
        _interactiveViewerKey.currentContext.findRenderObject();

    final _localOffset = _interactiveViewerBox.globalToLocal(offset);

    return _localOffset;
  }
}
