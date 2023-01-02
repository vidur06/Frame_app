// ignore_for_file: unnecessary_statements, avoid_print, sized_box_for_whitespace, use_named_constants, require_trailing_commas, avoid_unnecessary_containers, use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:festival_frame/models/frame_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screenshot/screenshot.dart';
import '../models/sqlhelper.dart';
import '../text_edit/add_text_layout.dart';
import '../text_edit/confirmation_dialog.dart';
import '../text_edit/dragable_widget.dart';
import '../text_edit/dragable_widget_child.dart';
import '../text_edit/edit_photo_cubit.dart';
import 'package:festival_frame/models/images.dart';
import 'package:festival_frame/models/unit.dart';
import 'package:photo_view/photo_view.dart';
import 'package:on_image_matrix/on_image_matrix.dart';

import '../widgets/slider.dart';
import '../widgets/stickerImage.dart';

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

class _PhotoFramePageState extends State<PhotoFramePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  late int color;
  String filterData = '';
  late Size _viewport;
  @override
  void initState() {
    super.initState();
    _viewport = const Size(0, 0);
    color = 0;
    // ignore: unused_label
    navigatorObservers:
    [FirebaseAnalyticsObserver(analytics: analytics)];

    interstitialAds();
  }

  final List<StickerImage> _attachedList = [];
  PhotoViewController controller1 = PhotoViewController();
  final controller = ScreenshotController();
  dynamic frame;
  File? _image;
  double bright = 0;

  double brightnessAndContrast = 0.0;
  double exposure = 0.0;
  double saturation = 1.0;
  double visibility = 1.0;
  bool isTextShowable = false;
  bool isSheetShow = false;

  List<ColorFilter> filters = filterList;
  ColorFilter currentFilter = OnImageFilters.normal;

  late InterstitialAd interstitialAd;
  bool isLoaded = true;

  void interstitialAds() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-6380676578937457/8956369719',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            isLoaded = true;
            interstitialAd = ad;
          });
          print('ad loaded...');
        },
        onAdFailedToLoad: (error) {
          print('Interstitial Ad failed...');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dynamic res = ModalRoute.of(context)!.settings.arguments;
    final dynamic height = MediaQuery.of(context).size.height;
    final dynamic width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Add Frame"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              'setimage',
              (route) => false,
              arguments: [
                (_image != null) ? _image : res[0],
                res[1],
                res[2],
                res[3],
              ],
            );
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          (filterData == 'Text' || filterData == 'Sticker')
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      filterData = '';
                      isTextShowable = false;
                    });
                  },
                  icon: const Icon(Icons.done),
                )
              : IconButton(
                  onPressed: () {
                    controller
                        .capture(delay: const Duration(milliseconds: 10))
                        .then((capturedImage) async {
                      final img = await testComporessList(capturedImage!);
                      final date = DateTime.now().millisecondsSinceEpoch;
                      final directory =
                          Directory('/storage/emulated/0/Download');
                      final dirPath =
                          Directory('${directory.path}/FESTIVAL_FRAME')
                              .create();
                      final directoryPath = Directory(
                          '/storage/emulated/0/Download/FESTIVAL_FRAME');
                      final file = await File('${directoryPath.path}/$date.jpg')
                          .create();
                      final fileSend = File('${directoryPath.path}/$date.jpg');
                      print('file : $file');
                      file.writeAsBytes(capturedImage);

                      final Map<String, dynamic> data = {
                        'image': img,
                      };
                      final Storage s = Storage.fromMap(data);
                      await DBHelper.dbHelper.insert(s);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Successfully download ${file.path}"),
                          backgroundColor: Colors.blue,
                          duration: const Duration(seconds: 1),
                        ),
                      );

                      interstitialAds();
                      if (isLoaded) {
                        interstitialAd.show();
                      }
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        'savePage',
                        (route) => false,
                        arguments: [capturedImage, file],
                      );
                    }).catchError((onError) {
                      print(onError);
                    });
                  },
                  icon: const Icon(
                    Icons.download,
                  ),
                ),
        ],
      ),
      body: BlocBuilder<EditPhotoCubit, EditPhotoState>(buildWhen: (p, c) {
        return p.opacityLayer != c.opacityLayer || p.widgets != c.widgets;
      }, builder: (context, state) {
        return Stack(
          children: [
            res[0] != null
                ? SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: (filterData.isEmpty || filterData == 'Sticker')
                            ? height * 0.09
                            : 0,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (filterData == 'Text' || filterData == 'Sticker') {
                          } else {
                            setState(() {
                              filterData = '';
                            });
                          }
                        },
                        child: Container(
                          height: height * 0.57,
                          width: double.infinity,
                          child: Screenshot(
                            controller: controller,
                            child: OnImageMatrixWidget(
                              colorFilter: OnImageMatrix.matrix(
                                brightnessAndContrast: brightnessAndContrast,
                                saturation: saturation,
                              ),
                              child: LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  if (_viewport == const Size(0.0, 0.0)) {
                                    _viewport = Size(constraints.maxWidth,
                                        constraints.maxHeight);
                                  }
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      OnImageMatrixWidget(
                                        colorFilter: OnImageMatrix.matrix(
                                          exposure: exposure,
                                          visibility: visibility,
                                        ),
                                        child: ColorFiltered(
                                          colorFilter: currentFilter,
                                          child: PhotoView(
                                            backgroundDecoration:
                                                const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            enablePanAlways: true,
                                            enableRotation: true,
                                            imageProvider: FileImage(
                                              (_image != null)
                                                  ? _image
                                                  : res[0],
                                            ),
                                          ),
                                        ),
                                      ),
                                      IgnorePointer(
                                        child: Container(
                                          height: height * 0.57,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(res[1]),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Stack(
                                        children: _attachedList,
                                      ),
                                      for (var i = 0;
                                          i < state.widgets.length;
                                          i++)
                                        Align(
                                          key: UniqueKey(),
                                          alignment: Alignment.center,
                                          child: state.widgets[i],
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
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
                padding: EdgeInsets.only(
                    top: (filterData.isEmpty || filterData == 'Sticker')
                        ? height * 0.66
                        : height * 0.57),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color:const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            (filterData.isEmpty || filterData == "Sticker")
                ? IgnorePointer(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: height * 0.8),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  )
                : Container(),
            (isTextShowable == true)
                ? Padding(
                    padding:
                        EdgeInsets.only(top: height * 0.7, left: width * 0.45),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              isTextShowable = false;
                            });
                            context
                                .read<EditPhotoCubit>()
                                .changeEditState(EditState.addingText);

                            final result = await addText(context);

                            if (result == null ||
                                result is! DragableWidgetTextChild &&
                                    filterData == 'Text') {
                              setState(() {
                                isTextShowable = true;
                              });
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
                                setState(() {
                                  isSheetShow = true;
                                });
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
                                    setState(() {
                                      isSheetShow = false;
                                    });
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
                                  Timer(const Duration(milliseconds: 200), () {
                                    setState(() {
                                      isSheetShow = false;
                                    });
                                  });
                                }
                              },
                              onLongPress: (id) async {
                                final result = await showConfirmationDialog(
                                  context,
                                  title: "Delete Text ?",
                                  desc:
                                      "Are you sure want to Delete this text ?",
                                  rightText: "Delete",
                                );
                                if (result == null) return;

                                if (result) {
                                  if (!mounted) return;
                                  context
                                      .read<EditPhotoCubit>()
                                      .deleteWidget(id);
                                }
                              },
                            );

                            if (!mounted) return;
                            context.read<EditPhotoCubit>().addWidget(widget);
                            setState(() {
                              isTextShowable = true;
                            });
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
                              Icons.text_fields,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(
                            'Text',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.only(top: height * 0.5),
              child: Column(
                children: [
                  const Spacer(),
                  (filterData == 'Bright')
                      ? SliderData(
                          icon: Icons.brightness_4,
                          name: 'Brightness',
                          max: 5.0,
                          min: -5.0,
                          value: brightnessAndContrast,
                          onChanged: (valueData) {
                            setState(() {
                              this.brightnessAndContrast = valueData;
                            });
                          },
                        )
                      : (filterData == 'Filters')
                          ? _buildFilter(res[0])
                          : (filterData == 'Opacity')
                              ? SliderData(
                                  icon: Icons.opacity,
                                  name: 'Opacity',
                                  max: 1.0,
                                  min: 0.0,
                                  value: visibility,
                                  onChanged: (visibility) {
                                    setState(() {
                                      this.visibility = visibility;
                                    });
                                  },
                                )
                              : (filterData == 'Sat')
                                  ? SliderData(
                                      icon: Icons.satellite,
                                      name: 'Saturation',
                                      max: 5.0,
                                      min: 1.0,
                                      value: saturation,
                                      onChanged: (saturation) {
                                        setState(() {
                                          this.saturation = saturation;
                                        });
                                      },
                                    )
                                  : (filterData == 'Expose')
                                      ? SliderData(
                                          icon: Icons.exposure,
                                          name: 'Exposure',
                                          max: 5.0,
                                          min: 0.0,
                                          value: exposure,
                                          onChanged: (exposure) {
                                            setState(() {
                                              this.exposure = exposure;
                                            });
                                          },
                                        )
                                      : Container(),
                  const SizedBox(
                    height: 10,
                  ),
                  (filterData == 'Text' ||
                          filterData == 'Sticker' ||
                          isSheetShow == true)
                      ? Container()
                      : Container(
                          height: 80,
                          color: Colors.blue[300],
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: filterImg.length,
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    filterData = filterImg[i].name;
                                  });

                                  if (filterData == 'Gallery') {
                                    final pickedFile =
                                        await Imagepick.imagepic();
                                    setState(() {
                                      _image = File(pickedFile!.path);
                                    });
                                    (context as Element).markNeedsBuild();
                                  }

                                  if (filterData == 'Text') {
                                    setState(() {
                                      isTextShowable = true;
                                    });
                                  }

                                  if (filterData == 'Frames') {
                                    setState(() {});  
                                    Navigator.of(context).pushNamed(
                                      're_frames',
                                      arguments: [
                                        (_image != null) ? _image : res[0],
                                        res[2],
                                        res[3],
                                      ],
                                    );
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 50,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              width: 1,
                                            ),
                                          ),
                                          child: filterImg[i].img,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: Text(
                                            filterImg[i].name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
            (filterData == 'Sticker')
                ? Padding(
                    padding: EdgeInsets.only(top: height * 0.66),
                    child: DragTarget(
                      builder: (
                        BuildContext context,
                        candidateData,
                        List<dynamic> rejectedData,
                      ) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          color: Colors.transparent,
                          // ignore: sort_child_properties_last
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: res[3].length,
                            itemBuilder: (BuildContext context, int i) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      _attachSticker(res[3][i]);
                                    },
                                    child: res[3][i],
                                  ),
                                ),
                              );
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 1,
                            ),
                          ),
                          height: 200,
                        );
                      },
                    ),
                  )
                : Container(),
          ],
        );
      }),
    );
  }

  void _attachSticker(Image image) {
    setState(() {
      _attachedList.add(
        StickerImage(
          image,
          height: 100,
          key: Key("sticker_${_attachedList.length}"),
          maxScale: 2,
          minScale: 0.5,
          onTapRemove: (sticker) {
            this._onTapRemoveSticker(sticker);
          },
          rotatable: true,
          viewport: _viewport,
          width: 100,
        ),
      );
    });
  }

  void _onTapRemoveSticker(sticker) {
    setState(() {
      this._attachedList.removeWhere((s) => s.key == sticker.key);
    });
  }

  Widget _buildFilter(dynamic res) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentFilter = filters[i];
                });
              },
              child: Container(
                height: 50,
                width: 80,
                child: ColorFiltered(
                  colorFilter: filters[i],
                  child: Image(
                    image: FileImage((_image != null) ? _image : res),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
