import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class CompressImage extends StatefulWidget {
  const CompressImage({super.key});

  @override
  State<CompressImage> createState() => _CompressImageState();
}

class _CompressImageState extends State<CompressImage> {
  bool compress = false;
  Uint8List? _compressedFile;
  double compressKb = 0;
  double averageKb = 0;
  double originalKb = 0;
  File? imageFile;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  void initState() {
    super.initState();
    navigatorObservers:
    [FirebaseAnalyticsObserver(analytics: analytics)];
  }

  @override
  Widget build(BuildContext context) {
    final dynamic res = ModalRoute.of(context)!.settings.arguments;
    final dynamic size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final bytes = res.lengthInBytes;
    originalKb = bytes / 1024;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compress Image'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          (compress == true)
              ? IconButton(
                  onPressed: () async {
                    final date = DateTime.now().millisecondsSinceEpoch;
                    final directory = Directory('/storage/emulated/0/Download');
                    final dirPath =
                        Directory('${directory.path}/FESTIVAL_FRAME').create();
                    print('path: $dirPath');
                    final directoryPath =
                        Directory('/storage/emulated/0/Download/FESTIVAL_FRAMEp');
                    final file =
                        await File('${directoryPath.path}/$date.jpg').create();
                    print('file : $file');
                    file.writeAsBytes(_compressedFile!);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Successfully download ${file.path}"),
                        backgroundColor: Colors.blue,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.download_outlined,
                  ),
                )
              : Container(),
        ],
      ),
      body: (compress == false)
          ? Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: height * 0.04),
                    child: const Text(
                      'Original File',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                SizedBox(
                  height: height * 0.5,
                  width: width * 0.9,
                  child: Image.memory(res),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.01),
                  child: Text(
                    'Original file size: ${originalKb.toInt()} kb',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.02),
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        compress = true;
                      });
                      testComporessList(res);
                    },
                    child: Container(
                      height: height * 0.07,
                      width: width * 0.95,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Compress',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: height * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          'Original File',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Compressed File',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: width * 0.4,
                      child: Image.memory(
                        res,
                      ),
                    ),
                    (_compressedFile != null)
                        ? SizedBox(
                            width: width * 0.4,
                            child: Image.memory(
                              _compressedFile!,
                            ),
                          )
                        : SizedBox(
                            width: width * 0.4,
                          ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.05),
                      child: Text(
                        'Original file size: ${originalKb.toInt()} kb',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.03),
                      child: Text(
                        'Compress file size: ${compressKb.toInt()} kb',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.02),
                      child: Text(
                        'You saved: ${averageKb.toInt()} kb',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Future<Uint8List> testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      quality: (originalKb.toInt() < 1000) ? 70 : 98,
    );
    setState(() {
      _compressedFile = result;
      final bytes = _compressedFile!.lengthInBytes;
      compressKb = bytes / 1024;
      averageKb = originalKb - compressKb;
    });
    print(list.length);
    print(result.length);
    return result;
  }
}
