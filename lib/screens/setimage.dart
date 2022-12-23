// ignore_for_file: unnecessary_statements, avoid_print

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
          "Set Image",
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              'frames',
              (route) => false,
              arguments: [res[2], res[3]],
            );
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 400,
            child:
                imagefile != null ? Image.file(imagefile!) : Image.file(res[0]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      cropImage(res[0].path);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.white70,
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.crop_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Text(
                      'Crop Image',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: (){
                       Navigator.of(context).pushNamed(
                      "framepage",
                      arguments: [
                        (imagefile != null) ? imagefile : res[0],
                        res[1],
                        res[2],
                        res[3],
                      ],
                    );
                
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.white70,
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.filter_frames,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Text(
                      'Add Frame',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
        print(imagefile);
      });
    } else {
      print("Image is not cropped.");
    }
  }
}
