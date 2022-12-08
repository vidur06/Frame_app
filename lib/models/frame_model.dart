
import 'package:flutter/material.dart';

class FrameData {
  final String name;
  final List list;
  final String img;
  final List<Image> sticker;

  FrameData({
    required this.name,
    required this.list,
    required this.img,
    required this.sticker,
  });
}
class FilterImg {
  final Icon img;
  final String name;

  FilterImg({
    required this.img,
    required this.name,
  });
}
class ShadeFilterImg {
  final BlendMode blendMode;
  final Shader Function(Rect) shaderCallback;

  ShadeFilterImg({
    required this.blendMode,
    required this.shaderCallback,
  });
}

