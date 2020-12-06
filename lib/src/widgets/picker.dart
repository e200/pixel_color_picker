import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pixel_color_picker/src/services/pixel_color_picker.dart';

class PixelColorPicker extends StatefulWidget {
  final Widget child;
  final Function(Color color) onChanged;

  const PixelColorPicker({
    Key key,
    this.child,
    this.onChanged,
  }) : super(key: key);

  @override
  _PixelColorPickerState createState() => _PixelColorPickerState();
}

class _PixelColorPickerState extends State<PixelColorPicker> {
  final _colorPicker = ColorPicker();

  final _repaintBoundaryKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RepaintBoundary(
          key: _repaintBoundaryKey,
          child: InteractiveViewer(
            onInteractionEnd: (details) {
              _onInteract();
            },
            child: widget.child,
          ),
        ),
        Center(
          child: Icon(Icons.add_circle_outline),
        )
      ],
    );
  }

  _onInteract() async {
    final RenderRepaintBoundary _repaintBoundary =
        _repaintBoundaryKey.currentContext.findRenderObject();

    final _image = await _repaintBoundary.toImage();

    final _color = await _colorPicker.fromImage(_image);

    widget.onChanged(_color);
  }
}
