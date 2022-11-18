// ignore_for_file: avoid_classes_with_only_static_members, parameter_assignments

import 'dart:async';

import 'package:festival_frame/models/model.dart';
import 'package:festival_frame/models/sqlhelper.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class Imagepick {
  static imagepic() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    return pickedFile;
  }
}

class Navigation {
  static Select_Frame(BuildContext context) async {
    final navigate = Navigator.of(context).pushNamed("select_frame");

    return "success";
  }

  static ImagePage(BuildContext context) async {
    final navigate = Navigator.of(context).pushNamed("imagepage");

    return "success";
  }

  static Ratepage(BuildContext context) async {
    final navigate = Navigator.of(context).pushNamed("ratepage");

    return "success";
  }
}

class ScreenCapture {
  static Capture(BuildContext context, controller) {
    controller
        .capture(
      delay: const Duration(milliseconds: 10),
    )
        .then((capturedImage) async {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("image Exported"),
          backgroundColor: Colors.green,
        ),
      );
      if (capturedImage != null) {
        await ImageGallerySaver.saveImage(capturedImage);
      }
    }).catchError((onError) {
      // ignore: avoid_print
      print(onError);
    });
    return "captured success";
  }

  static capturedNav(controller, BuildContext context) {
    controller
        .capture(delay: const Duration(milliseconds: 10))
        .then((capturedImage) async {
      Navigator.of(context).pushNamed("sticker", arguments: capturedImage);
    }).catchError((onError) {
      // ignore: avoid_print
      print(onError);
    });
  }
}

class SaveDB {
  static Store(BuildContext context, image, fetchdata) async {
    final Map<String, dynamic> data = {
      'image': image,
    };
    final Storage s = Storage.fromMap(data);
    await DBHelper.dbHelper.insert(s);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Image saved successfully"),
        backgroundColor: Colors.green,
      ),
    );

    fetchdata = DBHelper.dbHelper.fetchAllData();

    await ImageGallerySaver.saveImage(image);
    return "success";
  }
}

class DeleteDB {
  static Deletedb(data) async {
    await DBHelper.dbHelper.delete(data);
    return "success";
  }
}

class Duration_Time {
  static duration(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    });
  }
}
