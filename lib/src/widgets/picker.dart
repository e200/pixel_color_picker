import 'dart:ui' as ui;

import 'package:after_layout/after_layout.dart';
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

class _PixelColorPickerState extends State<PixelColorPicker>
    with AfterLayoutMixin {
  final _colorPicker = ColorPicker();

  final _repaintBoundaryKey = GlobalKey();
  final _interactiveViewerKey = GlobalKey();

  ui.Image _snapshot;

  final _cachingSnapshot = ValueNotifier<bool>(false);

  Future<void> _loadSnapshot() async {
    final RenderRepaintBoundary _repaintBoundary =
        _repaintBoundaryKey.currentContext.findRenderObject();

    _snapshot = await _repaintBoundary.toImage();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _cachingSnapshot.value = true;

    _loadSnapshot().whenComplete(() {
      _cachingSnapshot.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RepaintBoundary(
          key: _repaintBoundaryKey,
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
      ],
    );
  }

  _onInteract(Offset offset) async {
    final _localOffset = _findLocalOffset(offset);

    final _color = await _colorPicker.fromImage(
      _snapshot,
      _localOffset,
      cacheBytes: true,
    );

    widget.onChanged(_color);
  }

  _findLocalOffset(Offset offset) {
    final RenderBox _interactiveViewerBox =
        _interactiveViewerKey.currentContext.findRenderObject();

    final _localOffset = _interactiveViewerBox.globalToLocal(offset);

    return _localOffset;
  }
}
