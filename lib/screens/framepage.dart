import 'dart:typed_data';

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
  late Future<List<Storage>> fetchdata;
  Future<void> checkDB() async {
    await DBHelper.dbHelper.initDB();
  }

  @override
  void initState() {
    super.initState();
    fetchdata = DBHelper.dbHelper.fetchAllData();
    checkDB();
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
  List s_list = [
    "assets/images/navratri.png",
    "assets/images/diwali.jpg",
    "assets/images/rakhi.jpg",
    "assets/images/mkr.jpg",
    "assets/images/holi.png",
    "assets/images/janmashtmi.jpg",
    "assets/images/chrismas.jpg",
  ];
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
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              controller
                  .capture(delay: const Duration(milliseconds: 10))
                  .then((capturedImage) async {
                ShowCapturedWidget(context, capturedImage!);

                final Map<String, dynamic> data = {
                  'image': capturedImage,
                };
                final Storage s = Storage.fromMap(data);
                final int id = await DBHelper.dbHelper.insert(s);

                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Record Insert Successfully With id = $id"),
                    backgroundColor: Colors.green,
                  ),
                );
                setState(() {
                  fetchdata = DBHelper.dbHelper.fetchAllData();
                });
                // final result = await ImageGallerySaver.saveImage(capturedImage);
              }).catchError((onError) {
                // ignore: avoid_print
                print(onError);
              });
            },
          ),
        ],
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
                        // (frame.isNotEmpty)
                        //     ?
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
                            // child: Image.asset(
                            //   frame,
                            //   fit: BoxFit.contain,
                            // ),
                          ),
                        ),
                        // : Container(),
                        // Column(
                        //     children: us_list
                        //         .map(
                        //           (e) =>
                        (sticker.isNotEmpty)
                            ?
                            // DragImage(
                            //     const Offset(0, 0),
                            //     sticker,
                            //   )
                            Positioned(
                                left: offset.dx,
                                top: offset.dy,
                                child: GestureDetector(
                                  // onDoubleTap: () {
                                  //   setState(() {
                                  //     height = height + 20;
                                  //     width = width + 20;
                                  //   });
                                  // },
                                  // onTap: () {
                                  //   if (height != 30) {
                                  //     setState(() {
                                  //       height = height - 20;
                                  //       width = width - 20;
                                  //     });
                                  //   }
                                  // },
                                  onScaleStart: (ScaleStartDetails details) {
                                    // ignore: avoid_print
                                    print(details);
                                    _previousScale = _scale;
                                    setState(() {});
                                  },
                                  onScaleUpdate: (ScaleUpdateDetails details) {
                                    // ignore: avoid_print
                                    print(details);
                                    _scale = _previousScale * details.scale;
                                    setState(() {});
                                  },
                                  onScaleEnd: (ScaleEndDetails details) {
                                    // ignore: avoid_print
                                    print(details);
                                    _previousScale = 1.0;
                                    setState(() {});
                                  },
                                  // onPanUpdate: (details) {
                                  //   setState(() {
                                  //     offset = Offset(
                                  //         offset.dx + details.delta.dx,
                                  //         offset.dy + details.delta.dy);
                                  //   });
                                  // },

                                  child: RotatedBox(
                                    quarterTurns: rotation.toInt(),
                                    child: Transform(
                                      alignment: FractionalOffset.center,
                                      transform: Matrix4.diagonal3(
                                        Vector3(_scale, _scale, _scale),
                                      ),
                                      child: Image(
                                        image: AssetImage(sticker),
                                        // height: height,
                                        // width: width,
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
                                  // onHorizontalDragUpdate: (dd) {
                                  //   setState(() {
                                  //     top = dd.localPosition.dy;
                                  //     left = dd.localPosition.dx;
                                  //   });
                                  // },
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
          // (res[0] != null && frm == true)
          //     ? Expanded(
          //         flex: 2,
          //         child: ListView.builder(
          //           scrollDirection: Axis.horizontal,
          //           itemCount: res[1].length,
          //           itemBuilder: (context, i) {
          //             return Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 Row(
          //                   children: [
          //                     InkWell(
          //                       onTap: () {
          //                         setState(() {
          //                           frame = res[1][i];
          //                         });
          //                       },
          //                       child: Container(
          //                         height: 150,
          //                         width: 150,
          //                         margin: const EdgeInsets.all(6.0),
          //                         decoration: BoxDecoration(
          //                           color: Colors.white,
          //                           border: Border.all(width: 2),
          //                           borderRadius: BorderRadius.circular(10.0),
          //                           image: DecorationImage(
          //                             image: AssetImage("${res[1][i]}"),
          //                             fit: BoxFit.cover,
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //             );
          //           },
          //         ),
          //       )
          //     : Container(),
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
                  // setState(() {
                  //   frm = false;
                  //   showModalBottomSheet(
                  //       context: context,
                  //       builder: (context) {
                  //         return SizedBox(
                  //           // height: 200,
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               Expanded(
                  //                 child: GridView.count(
                  //                     crossAxisCount: 4,
                  //                     crossAxisSpacing: 4.0,
                  //                     mainAxisSpacing: 5.0,
                  //                     children:
                  //                         List.generate(s_list.length, (i) {
                  //                       return GestureDetector(
                  //                         onTap: () {
                  //                           setState(() {
                  //                             sticker = s_list[i];
                  //                             us_list.add(s_list[i]);
                  //                           });
                  //                           Navigator.pop(context);
                  //                         },
                  //                         child: Container(
                  //                           height: 300,
                  //                           width: 300,
                  //                           child: Image.asset(
                  //                             s_list[i],
                  //                           ),
                  //                         ),
                  //                       );
                  //                     })),
                  //               ),
                  //             ],
                  //           ),
                  //         );
                  //       });
                  // });
                  controller
                      .capture(delay: const Duration(milliseconds: 10))
                      .then((capturedImage) async {
                    Navigator.of(context)
                        .pushNamed("sticker", arguments: capturedImage);
                  }).catchError((onError) {
                    // ignore: avoid_print
                    print(onError);
                  });
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
