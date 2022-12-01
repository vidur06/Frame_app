// ignore_for_file: unnecessary_statements, avoid_print, sized_box_for_whitespace

import 'dart:typed_data';

import 'package:festival_frame/models/unit.dart';
import 'package:festival_frame/text_edit/component_layer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:screenshot/screenshot.dart';
import '../models/model.dart';
import '../models/sqlhelper.dart';
import '../text_edit/add_text_layout.dart';
import '../text_edit/confirmation_dialog.dart';
import '../text_edit/dragable_widget.dart';
import '../text_edit/dragable_widget_child.dart';
import '../text_edit/edit_photo_cubit.dart';

// double ballRadius = 7.5;
class FramePage extends StatelessWidget {
  const FramePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditPhotoCubit(),
      child: const PhotoFramePage(),
    );
  }
}

class PhotoFramePage extends StatefulWidget {
  const PhotoFramePage({Key? key}) : super(key: key);

  @override
  State<PhotoFramePage> createState() => _PhotoFramePageState();
}

List<Uint8List> data = [];
int i = 0;

class _PhotoFramePageState extends State<PhotoFramePage> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // late Future<List<Storage>> fetchdata;
  // Future<void> checkDB() async {
  //   await DBHelper.dbHelper.initDB();
  // }

  @override
  void initState() {
    super.initState();
    // fetchdata = DBHelper.dbHelper.fetchAllData();
    // checkDB();
    // ignore: unused_label
    navigatorObservers:
    [FirebaseAnalyticsObserver(analytics: analytics)];
  }

  PhotoViewController controller1 = PhotoViewController();
  final controller = ScreenshotController();
  dynamic frame;
  // final _imageKey = GlobalKey<ImagePainterState>();
  bool show = false;

  @override
  Widget build(BuildContext context) {
    final dynamic res = ModalRoute.of(context)!.settings.arguments;

    return BlocListener<EditPhotoCubit, EditPhotoState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Frame"),
          centerTitle: true,
          leading: (show == false)
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      'setimage',
                      (route) => false,
                      arguments: res,
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      show = false;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            res[0] != null
                ? Container(
                    decoration: const BoxDecoration(),
                    child: Screenshot(
                      controller: controller,
                      child: Container(
                        height: 450,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            PhotoView(
                              backgroundDecoration:
                                  const BoxDecoration(color: Colors.white),
                              enablePanAlways: true,
                              enableRotation: true,
                              imageProvider: FileImage(res[0]),
                            ),
                            IgnorePointer(
                              child: Container(
                                height: 450,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(res[1]),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            (show == true)
                                ? const ComponentLayer()
                                : IgnorePointer(child: Container()),
                          ],
                        ),
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
            IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.only(top: 450),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 500),
              child: Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(10),
                  //   child: Row(
                  //     children: [
                  //       GestureDetector(
                  //         onTap: () {},
                  //         child: Container(
                  //           alignment: Alignment.center,
                  //           height: 50,
                  //           width: 80,
                  //           decoration: BoxDecoration(
                  //             color: Colors.black,
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: const Text(
                  //             'Image',
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 20,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       const SizedBox(
                  //         width: 10,
                  //       ),
                  //       GestureDetector(
                  //         onTap: () {},
                  //         child: Container(
                  //           alignment: Alignment.center,
                  //           height: 50,
                  //           width: 80,
                  //           decoration: BoxDecoration(
                  //             color: Colors.black,
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: const Text(
                  //             'Text',
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 20,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            're_frames',
                            arguments: [res[0], res[2]],
                          );
                        },
                        child: const Text("frame"),
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       show = false;
                      //     });
                      //   },
                      //   icon: const Icon(Icons.image),
                      // ),
                      (show == true)?IconButton(
                        onPressed: () async {
                          context
                              .read<EditPhotoCubit>()
                              .changeEditState(EditState.addingText);

                          final result = await addText(context);

                          if (result == null ||
                              result is! DragableWidgetTextChild) {
                            if (!mounted) return;
                            context
                                .read<EditPhotoCubit>()
                                .changeEditState(EditState.idle);
                            return;
                          }

                          final widget = DragableWidget(
                            widgetId: DateTime.now().millisecondsSinceEpoch,
                            child: result,
                            onPress: (id, widget) async {
                              if (widget is DragableWidgetTextChild) {
                                context
                                    .read<EditPhotoCubit>()
                                    .changeEditState(EditState.addingText);

                                final result = await addText(
                                  context,
                                  widget,
                                );

                                if (result == null ||
                                    result is! DragableWidgetTextChild) {
                                  if (!mounted) return;
                                  context
                                      .read<EditPhotoCubit>()
                                      .changeEditState(EditState.idle);
                                  return;
                                }

                                if (!mounted) return;
                                context
                                    .read<EditPhotoCubit>()
                                    .editWidget(id, result);
                              }
                            },
                            onLongPress: (id) async {
                              final result = await showConfirmationDialog(
                                context,
                                title: "Delete Text ?",
                                desc: "Are you sure want to Delete this text ?",
                                rightText: "Delete",
                              );
                              if (result == null) return;

                              if (result) {
                                if (!mounted) return;
                                context.read<EditPhotoCubit>().deleteWidget(id);
                              }
                            },
                          );

                          if (!mounted) return;
                          context.read<EditPhotoCubit>().addWidget(widget);
                        },
                        icon: const Icon(Icons.text_fields_rounded),
                      ):Container(),
                      (show == true)
                          ? ElevatedButton(
                              onPressed: () {
                                ScreenCapture.capturedNav(controller, context);
                              },
                              child: const Text("sticker"),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  show = true;
                                });
                              },
                              child: const Text("Text"),
                            ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //   Row(
  //   children: [
  //     GestureDetector(
  //       onTap: () {
  //         setState(() {
  //           frame = '';
  //         });
  //       },
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Container(
  //           width: 100,
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(10),
  //             border: Border.all(
  //               color:
  //                   const Color.fromRGBO(0, 0, 0, 1),
  //               width: 1,
  //             ),
  //           ),
  //           // ignore: prefer_const_constructors
  //           child: Center(
  //             child: const Text(
  //               'No\nEditPage',
  //               style: TextStyle(
  //                 color: Colors.black,
  //               ),
  //               textAlign: TextAlign.center,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //     Expanded(
  //       child: ListView.builder(
  //           scrollDirection: Axis.horizontal,
  //           itemCount: res[2].length,
  //           itemBuilder: (context, i) {
  //             return GestureDetector(
  //               onTap: () {
  //                 setState(() {
  //                   frame = res[2][i];
  //                 });
  //               },
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     image: DecorationImage(image: AssetImage(res[2][i])),
  //                     borderRadius:
  //                         BorderRadius.circular(10),
  //                     border: Border.all(
  //                       color: const Color.fromRGBO(
  //                           0, 0, 0, 1),
  //                       width: 1,
  //                     ),
  //                   ),
  //                   width: 100,
  //                   // height: 100,
  //                   // child: Image(
  //                   //   image: AssetImage(
  //                   //     res[2][i],
  //                   //   ),
  //                   // ),
  //                 ),
  //               ),
  //             );
  //           }),
  //     ),
  //   ],
  // ),
}
