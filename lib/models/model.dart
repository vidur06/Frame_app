import 'dart:typed_data';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart' show Vector3;

class Storage {
  int? id;
  final Uint8List image;

  Storage({this.id, required this.image});

  factory Storage.fromMap(Map<String, dynamic> data) {
    return Storage(
      id: data['id'],
      image: data['image'],
    );
  }
}

class DragImage extends StatefulWidget {
  final Offset position;
  final String image;

  // ignore: use_key_in_widget_constructors
  const DragImage(this.position, this.image);

  @override
  DragImageState createState() => DragImageState();
}

class DragImageState extends State<DragImage> {
  late double _zoom;
  late Offset _position;
  late String _image;
  double _scale = 1.0;
  late double _previousScale;
  double yOffset = 400.0;
  double xOffset = 50.0;
  double rotation = 0.0;
  double lastRotation = 0.0;
  double finalAngle = 0.0;
  double oldAngle = 0.0;
  double upsetAngle = 0.0;

  Offset offset = Offset.zero;
  @override
  void initState() {
    _zoom = 1.0;
    _position = widget.position;
    _image = widget.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx, //horizontal
      top: _position.dy, //vertical
      child: Draggable(
        //drag and drop
        // ignore: sort_child_properties_last
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: 350.0,
          height: 450.0,
          child: GestureDetector(
            // onScaleStart: _handleScaleStart,
            // onScaleUpdate: _handleScaleUpdate,
            // onDoubleTap: _handleScaleReset,
            onScaleStart: (ScaleStartDetails details) {
              // ignore: avoid_print
              print(details);
              _previousScale = _scale;
              setState(() {});
            },
            onScaleUpdate: (ScaleUpdateDetails details) {
              // ignore: avoid_print
              print(details);
              _scale = _previousScale * details.scale;
              setState(() {});
            },
            onScaleEnd: (ScaleEndDetails details) {
              // ignore: avoid_print
              print(details);

              _previousScale = 1.0;
              setState(() {});
            },
            child: InteractiveViewer(
              child: Transform(
                transform: Matrix4.diagonal3(Vector3(_zoom, _zoom, _zoom)),
                alignment: FractionalOffset.center,
                child: Image.asset(_image),
              ),
            ),
          ),
        ),
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            _position = offset;
          });
        },
        feedback: SizedBox(
          width: 1.0,
          height: 1.0,
          child: Image.asset(_image),
        ),
      ),
    );
  }
}
