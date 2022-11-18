// ignore_for_file: unnecessary_statements, avoid_print

import 'dart:typed_data';

import 'package:festival_frame/models/images.dart';
import 'package:festival_frame/models/unit.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:screenshot/screenshot.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart' show Vector3;

import '../models/model.dart';
import '../models/sqlhelper.dart';

double ballRadius = 7.5;

class FramePage extends StatefulWidget {
  const FramePage({Key? key}) : super(key: key);

  @override
  State<FramePage> createState() => _FramePageState();
}

List<Uint8List> data = [];
int i = 0;

class _FramePageState extends State<FramePage> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  late Future<List<Storage>> fetchdata;
  Future<void> checkDB() async {
    await DBHelper.dbHelper.initDB();
  }

  @override
  void initState() {
    super.initState();
    fetchdata = DBHelper.dbHelper.fetchAllData();
    checkDB();
    navigatorObservers:
    [FirebaseAnalyticsObserver(analytics: analytics)];
  }

  PhotoViewController controller1 = PhotoViewController();
  final controller = ScreenshotController();
  String frame = "";
  double top = 0;
  double left = 0;
  List<String> store = [];
  List<String> list = [];
  bool frm = true;
  bool stk = false;
  String sticker = "";
  // ignore: non_constant_identifier_names
  List us_list = [];
  // ignore: non_constant_identifier_names
  List s_list = frameImage;
  
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

  Offset centerOfGestureDetector = Offset(ballRadius, ballRadius);

  double height = 30;
  double width = 30;

  @override
  Widget build(BuildContext context) {
    final dynamic res = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Frame"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          res[0] != null
              ? Container(
                  // height: 300,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    border: Border.all(width: 3),
                  ),
                  child: Screenshot(
                    controller: controller,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          child: Transform(
                            transform: Matrix4.rotationZ(0),
                            alignment: FractionalOffset.center,
                            child: SizedBox(
                              height: 370,
                              width: 333,
                              child: InteractiveViewer(
                                child: Image.file(
                                  res[0],
                                ),
                              ),
                            ),
                          ),
                        ),

                        IgnorePointer(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 400,
                            width: 400,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(res[1]),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),

                        (sticker.isNotEmpty)
                            ? Positioned(
                                left: offset.dx,
                                top: offset.dy,
                                child: GestureDetector(
                                  onScaleStart: (ScaleStartDetails details) {
                                    print(details);
                                    _previousScale = _scale;
                                    setState(() {});
                                  },
                                  onScaleUpdate: (ScaleUpdateDetails details) {
                                    print(details);
                                    _scale = _previousScale * details.scale;
                                    setState(() {});
                                  },
                                  onScaleEnd: (ScaleEndDetails details) {
                                    print(details);
                                    _previousScale = 1.0;
                                    setState(() {});
                                  },
                                  child: RotatedBox(
                                    quarterTurns: rotation.toInt(),
                                    child: Transform(
                                      alignment: FractionalOffset.center,
                                      transform: Matrix4.diagonal3(
                                        Vector3(_scale, _scale, _scale),
                                      ),
                                      child: Image(
                                        image: AssetImage(sticker),
                                      ),
                                    ),
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd) {
                                    setState(() {
                                      offset = Offset(
                                        offset.dx + dd.delta.dx,
                                        offset.dy + dd.delta.dy,
                                      );
                                    });
                                  },
                                ),
                              )
                            : Container(),
                        // )
                        // .toList()),
                      ],
                    ),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  height: 300,
                  width: 300,
                  color: Colors.white,
                  child: const Text("add Image"),
                ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("frame"),
              ),
              ElevatedButton(
                onPressed: () {
                  ScreenCapture.capturedNav(controller, context);
                },
                child: const Text("sticker"),
              ),
            ],
          )
        ],
      ),
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
          backgroundColor: Colors.grey,
          title: const Text("saved image"),
        ),
        body: Center(
          child:
              // ignore: unnecessary_null_comparison
              capturedImage != null ? Image.memory(capturedImage) : Container(),
        ),
      ),
    );
  }
}
