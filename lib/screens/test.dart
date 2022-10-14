import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stick_it/stick_it.dart';

import '../models/model.dart';
import '../models/sqlhelper.dart';

class StickerPage extends StatefulWidget {
  const StickerPage({Key? key}) : super(key: key);
  @override
  State<StickerPage> createState() => _StickerPageState();
}

class _StickerPageState extends State<StickerPage> {
  ScreenshotController screenshotController = ScreenshotController();
  late StickIt _stickIt;
  late Future<List<Storage>> fetchdata;
  @override
  void initState() {
    super.initState();
    fetchdata = DBHelper.dbHelper.fetchAllData();
    checkDB();
  }

  Future<void> checkDB() async {
    await DBHelper.dbHelper.initDB();
  }

  @override
  Widget build(BuildContext context) {
    final dynamic arg = ModalRoute.of(context)!.settings.arguments;
    _stickIt = StickIt(
      stickerList: [
        Image.asset("assets/sticker/s1.png"),
        Image.asset("assets/sticker/s2.png"),
        Image.asset("assets/sticker/s3.png"),
        Image.asset("assets/sticker/s4.png"),
        Image.asset("assets/sticker/s5.png"),
        Image.asset("assets/sticker/s6.png"),
        Image.asset("assets/sticker/s7.png"),
        Image.asset("assets/sticker/s8.png"),
        Image.asset("assets/sticker/s9.png"),
      ],
      child: Container(color: Colors.white, child: Image.memory(arg)),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:
            const Text('Sticker Select', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final image = await _stickIt.exportImage();

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
              setState(() {
                fetchdata = DBHelper.dbHelper.fetchAllData();
              });

              await ImageGallerySaver.saveImage(image);
              // ignore: use_build_context_synchronously
              ShowCapturedWidget(context, image);

              // Navigator.of(context).pushNamedAndRemoveUntil(
              //     'savePage', (route) => false,
              //     arguments: image);
            },
            icon: const Icon(
              Icons.done,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: _stickIt,
    );
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> ShowCapturedWidget(
    BuildContext context,
    Uint8List capturedImage,
  ) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: const Text("saved image"),
        ),
        body: Center(
          // ignore: unnecessary_null_comparison
          child: capturedImage != null
              ? Column(
                  children: [
                    Image.memory(capturedImage),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/',
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text("Done"),
                    )
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
