
import 'dart:typed_data';

import 'package:flutter/material.dart';


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
class DrawerFilter {
  final String img;
  final String name;

  DrawerFilter({
    required this.img,
    required this.name,
  });
}

class SelectFrameField {
  final String img;
  final String name;
  final Color color;

  SelectFrameField({
    required this.img,
    required this.name,
    required this.color,
  });
}


