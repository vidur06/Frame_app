
import 'package:flutter/material.dart';

class FrameImage {
  final String img;
  final String val;

  FrameImage({
    required this.img,
    required this.val,
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

class FrameData {
  final String name;
  final List list;
  final String img;

  FrameData({
    required this.name,
    required this.list,
    required this.img,
  });
}

class StickerData {
  final String img;

  StickerData({
    required this.img,
  });
}
