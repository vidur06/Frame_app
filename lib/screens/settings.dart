import 'dart:io';

import 'package:festival_frame/widgets/rate_dialog.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:screenshot/screenshot.dart';

import '../models/unit.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  int _value = 20;
  Uint8List? result;
  final controller = ScreenshotController();
  @override
  void initState() {
    super.initState();
    navigatorObservers:
    [FirebaseAnalyticsObserver(analytics: analytics)];
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Settings",
          key: ValueKey('appbar text'),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.compress),
            title: const Text('Compress Image'),
            textColor: Colors.black,
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
            onTap: () async {
                Navigator.of(context).pushNamed(
                  'imagepage',
                );
            },
          ),
          Divider(
            color: Colors.black,
            height: 2,
            indent: width * 0.03,
            endIndent: width * 0.03,
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Abouts'),
            textColor: Colors.black,
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
            onTap: () {
              Navigator.of(context).pushNamed('about_app');
            },
          ),
          Divider(
            color: Colors.black,
            height: 2,
            indent: width * 0.03,
            endIndent: width * 0.03,
          ),
          ListTile(
            leading: const Icon(Icons.rate_review),
            title: const Text('Rate'),
            textColor: Colors.black,
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
            onTap: () {
              showDialog(context: context, builder: (context) => const RateDialog());
            },
          ),
          Divider(
            color: Colors.black,
            height: 2,
            indent: width * 0.03,
            endIndent: width * 0.03,
          ),
        ],
      ),
      // : SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         Screenshot(
      //           controller: controller,
      //           child: InteractiveViewer(
      //             child: SizedBox(
      //               width: 400,
      //               height: 500,
      //               child: Image.memory(
      //                 (result != null) ? result : res,
      //                 filterQuality: FilterQuality.high,
      //               ),
      //             ),
      //           ),
      //         ),
      //         Slider(
      //           value: _value.toDouble(),
      //           min: 0,
      //           max: 100.0,
      //           divisions: 100,
      //           label: "$_value",
      //           onChanged: (double newValue) async {
      //             setState(() {
      //               _value = newValue.round();
      //             });
      //             res = await FlutterImageCompress.compressWithList(
      //               res,
      //               quality: _value,
      //             );
      //             setState(() {
      //               result = res;
      //             });
      //           },
      //           onChangeEnd: (double newValue) async {
      //             setState(() {
      //               _value = newValue.round();
      //             });
      //             res = await FlutterImageCompress.compressWithList(
      //               res,
      //               quality: _value,
      //               rotate: 20,
      //             );
      //           },
      //           semanticFormatterCallback: (double newValue) {
      //             return '${newValue.round()} ';
      //           },
      //         ),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: const [
      //             Text(
      //               "Low",
      //               style: TextStyle(
      //                 fontSize: 17,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //             Text(
      //               "medium",
      //               style: TextStyle(
      //                 fontSize: 17,
      //                 fontWeight: FontWeight.w600,
      //               ),
      //             ),
      //             Text(
      //               "high",
      //               style: TextStyle(
      //                 fontSize: 17,
      //                 fontWeight: FontWeight.w600,
      //               ),
      //             ),
      //           ],
      //         ),
      //         const SizedBox(
      //           height: 20,
      //         ),
      //         ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Colors.blueAccent,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(32.0),
      //             ),
      //             minimumSize: const Size(300, 45),
      //           ),
      //           onPressed: () {
      //             ScreenCapture.Capture(context, controller);
      //           },
      //           child: const Text("Export"),
      //         ),
      //       ],
      //     ),
      //   ),
    );
  }
}
