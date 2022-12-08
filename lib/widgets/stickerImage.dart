// ignore: file_names
// ignore_for_file: avoid_unnecessary_containers, unnecessary_this

import 'dart:math';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart' as vec;

typedef StickerImageRemoveCallback = void Function(StickerImage sticker);

class StickerImage extends StatefulWidget {
  StickerImage(
    this.image, {
    Key? key,
    required this.width,
    required this.height,
    required this.viewport,
    required this.minScale,
    required this.maxScale,
    required this.rotatable,
    required this.onTapRemove,
  }) : super(key: key);
  final Image image;
  final double height;
  final double minScale;
  final double maxScale;
  final bool rotatable;
  final Size viewport;
  final double width;
  final StickerImageRemoveCallback onTapRemove;
  final _StickerImageState _stickerImageState = _StickerImageState();

  void prepareExport() {
    _stickerImageState._hideRemoveButton();
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return "FlutterSimpleStickerImage-$key-${_stickerImageState._offset}";
  }

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _StickerImageState createState() => _stickerImageState;
}

class _StickerImageState extends State<StickerImage> {
  _StickerImageState();

  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _previousOffset = Offset.zero;
  Offset _startingFocalPoint = Offset.zero;
  Offset _offset = Offset.zero;
  double _rotation = 0.0;

  @override
  void dispose() {
    super.dispose();
    _offset = Offset.zero;
    _scale = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: Rect.fromPoints(
        Offset(_offset.dx, _offset.dy),
        Offset(_offset.dx + widget.width, _offset.dy + widget.height),
      ),
      child: Container(
        child: Stack(
          children: <Widget>[
            Center(
              child: Transform(
                transform: Matrix4.diagonal3(vec.Vector3(_scale, _scale, _scale)),
                // ..setRotationZ(_rotation),
                alignment: FractionalOffset.center,
                child: Transform.rotate(
                  angle: _rotation,
                  child: GestureDetector(
                    onScaleStart: (ScaleStartDetails details) {
                      _startingFocalPoint = details.focalPoint;
                      _previousOffset = _offset;
                      _previousScale = _scale;
                    },

                    onScaleUpdate: (ScaleUpdateDetails details) {
                      _scale = min(max(_previousScale * details.scale, widget.minScale), widget.maxScale);
                      if (details.rotation != 0.0 && widget.rotatable) {
                        _rotation = details.rotation;
                      }
                      final Offset normalizedOffset = (_startingFocalPoint - _previousOffset) / _previousScale;
                      // ignore: no_leading_underscores_for_local_identifiers
                      Offset __offset = details.focalPoint - (normalizedOffset * _scale);
                      __offset = Offset(max(__offset.dx, -widget.width), max(__offset.dy, -widget.height));
                      __offset =
                          Offset(min(__offset.dx, widget.viewport.width), min(__offset.dy, widget.viewport.height));
                      setState(() {
                        _offset = __offset;
                        // print("move - $_offset, scale : $_scale");
                      });
                    },

                    onScaleEnd: (details){
                      if(_offset.dy <= 550 && _offset.dy >= 390 && _offset.dx >= 120 && _offset.dx <= 200){
                        setState(() {
                          this.widget.onTapRemove(this.widget);
                        });
                      }
                    },
                    onDoubleTap: () {
                      setState(() {
                        _scale = 1.0;
                      });
                    },
                    child: Container(child: widget.image),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _hideRemoveButton() {
    setState(() {
    });
  }
}
