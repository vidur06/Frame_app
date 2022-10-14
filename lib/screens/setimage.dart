// ignore_for_file: unnecessary_statements

import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class SetImage extends StatefulWidget {
  const SetImage({Key? key}) : super(key: key);

  @override
  State<SetImage> createState() => _SetImageState();
}

class _SetImageState extends State<SetImage> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigatorObservers:
    [FirebaseAnalyticsObserver(analytics: analytics)];
  }

  File? imagefile;
  @override
  Widget build(BuildContext context) {
    final dynamic res = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Set Iamge",
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 400,
            child:
                imagefile != null ? Image.file(imagefile!) : Image.file(res[0]),
          ),
          Container(
            height: 50,
            width: 400,
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    cropImage(res[0].path);
                  },
                  child: const Text("crop image"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      "frames",
                      arguments: [
                        (imagefile != null) ? imagefile : res[0],
                        res[1]
                      ],
                    );
                  },
                  child: const Text("Add Frame"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> cropImage(String image) async {
    final CroppedFile? croppedfile = await ImageCropper().cropImage(
      sourcePath: image,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Image Cropper',
          toolbarColor: Colors.deepPurpleAccent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
      ],
    );

    if (croppedfile != null) {
      imagefile = File(croppedfile.path);
      setState(() {
        // ignore: avoid_print
        print(imagefile);
      });
    } else {
      // ignore: avoid_print
      print("Image is not cropped.");
    }
  }
}
