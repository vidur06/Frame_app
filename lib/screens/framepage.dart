// ignore_for_file: unnecessary_statements, avoid_print, sized_box_for_whitespace

import 'dart:io';
import 'dart:typed_data';
import 'dart:math' as math;

import 'package:festival_frame/models/images.dart';
import 'package:festival_frame/models/unit.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:screenshot/screenshot.dart';
import '../text_edit/edit_photo_cubit.dart';
import 'package:on_image_matrix/on_image_matrix.dart';

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
List mycolors = <Color>[
  Colors.transparent,
  Colors.white,
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.purple,
  Colors.orange,
  Colors.indigo,
  Colors.cyan,
  Colors.pink,
  Colors.teal,
  Colors.lime,
];
Color primaryColor = mycolors[0];

class _PhotoFramePageState extends State<PhotoFramePage> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  late int color;
  @override
  void initState() {
    super.initState();
    color = 0;
    navigatorObservers:
    [FirebaseAnalyticsObserver(analytics: analytics)];
  }

  PhotoViewController controller1 = PhotoViewController();
  final controller = ScreenshotController();
  dynamic frame;
  String filterData = '';
  bool trueColor = false;
  File? _image;
  double bright = 0;

  double brightnessAndContrast = 0.0;
  double exposure = 0.0;
  double saturation = 1.0;
  double visibility = 1.0;

  List<ColorFilter> filters = [
    OnImageFilters.normal,
    OnImageFilters.blueSky,
    OnImageFilters.gray,
    OnImageFilters.grayHighBrightness,
    OnImageFilters.grayHighExposure,
    OnImageFilters.grayLowBrightness,
    OnImageFilters.hueRotateWith2,
    OnImageFilters.invert,
    OnImageFilters.kodachrome,
    OnImageFilters.protanomaly,
    OnImageFilters.random,
    OnImageFilters.sepia,
    OnImageFilters.sepium,
    OnImageFilters.technicolor,
    OnImageFilters.vintage,
  ];
  ColorFilter currentFilter = OnImageFilters.normal;

  BlendMode blendMode = BlendMode.color;
  Shader Function(Rect) shaderCallback = (rect) => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.transparent,
          Colors.transparent,
        ],
      ).createShader(rect);

  @override
  Widget build(BuildContext context) {
    final dynamic res = ModalRoute.of(context)!.settings.arguments;
    final dynamic height = MediaQuery.of(context).size.height;
    final dynamic width = MediaQuery.of(context).size.width;

    return BlocListener<EditPhotoCubit, EditPhotoState>(
      listener: (context, state) {},
      child: Scaffold(
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
            IconButton(
              onPressed: () {
                controller
                    .capture(delay: const Duration(milliseconds: 10))
                    .then((capturedImage) async {
                  Navigator.of(context).pushNamed("text_page",
                      arguments: [capturedImage, res[3]]);
                }).catchError((onError) {
                  // ignore: avoid_print
                  print(onError);
                });
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
              ),
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            res[0] != null
                ? Screenshot(
                  controller: controller,
                  child: OnImageMatrixWidget(
                      colorFilter: OnImageMatrix.matrix(
                        brightnessAndContrast: brightnessAndContrast,
                        saturation: saturation,
                      ),
                      child: ShaderMask(
                        blendMode: blendMode,
                        shaderCallback: shaderCallback,
                        child: Container(
                          decoration: const BoxDecoration(),
                          child: Container(
                            height: 450,
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                OnImageMatrixWidget(
                                  colorFilter: OnImageMatrix.matrix(
                                    exposure: exposure,
                                    visibility: visibility,
                                  ),
                                  child: ColorFiltered(
                                    colorFilter: (trueColor == false)
                                        ? currentFilter
                                        : ColorFilter.mode(
                                            primaryColor, BlendMode.hue),
                                    child: PhotoView(
                                      backgroundDecoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      enablePanAlways: true,
                                      enableRotation: true,
                                      imageProvider: FileImage(
                                        (_image != null) ? _image : res[0],
                                      ),
                                    ),
                                  ),
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
                              ],
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
                padding: const EdgeInsets.only(top: 450),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 400),
              child: Column(
                children: [
                  const Spacer(),
                  (filterData == 'Bright')
                      ? _buildBrightness()
                      : (filterData == 'Filters')
                          ? _buildFilter(res[0])
                          : (filterData == 'Opacity')
                              ? _buildOpacity()
                              : (filterData == 'Sat')
                                  ? _buildSaturation()
                                  : (filterData == 'Expose')
                                      ? _buildExposure()
                                      : (filterData == 'Shade')
                                          ? _buildGradientColor(res[0])
                                          : (filterData == 'Color')
                                              ? _buildColor(res[0])
                                              : Container(),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 80,
                    color: Colors.blue[300],
                    child: Expanded(
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
                                final pickedFile = await Imagepick.imagepic();
                                setState(() {
                                  _image = File(pickedFile!.path);
                                });
                                (context as Element).markNeedsBuild();
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
                                        borderRadius: BorderRadius.circular(50),
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
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBrightness() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Column(
          children: const <Widget>[
            Icon(
              Icons.brightness_4,
              color: Colors.blue,
            ),
            Text(
              "Brightness",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Slider(
            max: 5.0,
            min: -5.0,
            value: brightnessAndContrast,
            onChanged: (brightnessAndContrast) {
              setState(() {
                this.brightnessAndContrast = brightnessAndContrast;
              });
            },
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.08),
          child: Text(brightnessAndContrast.toStringAsFixed(2)),
        ),
      ],
    );
  }

  Widget _buildOpacity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Column(
          children: const <Widget>[
            Icon(
              Icons.opacity,
              color: Colors.blue,
            ),
            Text(
              "Opacity",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Slider(
            max: 1.0,
            min: 0.0,
            value: visibility,
            onChanged: (visibility) {
              setState(() {
                this.visibility = visibility;
              });
            },
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.08),
          child: Text(visibility.toStringAsFixed(2)),
        ),
      ],
    );
  }

  Widget _buildExposure() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Column(
          children: const <Widget>[
            Icon(
              Icons.exposure,
              color: Colors.blue,
            ),
            Text(
              "Exposure",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Slider(
            max: 5.0,
            min: 0.0,
            value: exposure,
            onChanged: (exposure) {
              setState(() {
                this.exposure = exposure;
              });
            },
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.08),
          child: Text(exposure.toStringAsFixed(2)),
        ),
      ],
    );
  }

  Widget _buildSaturation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Column(
          children: const <Widget>[
            Icon(
              Icons.satellite,
              color: Colors.blue,
            ),
            Text(
              "Saturation",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Slider(
            max: 5.0,
            min: 1.0,
            value: saturation,
            onChanged: (saturation) {
              setState(() {
                this.saturation = saturation;
              });
            },
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.08),
          child: Text(saturation.toStringAsFixed(2)),
        ),
      ],
    );
  }

  Widget _buildFilter(dynamic res) {
    setState(() {
      trueColor = false;
    });
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

  Widget _buildColor(dynamic res) {
    setState(() {
      trueColor = true;
    });
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mycolors.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  primaryColor = mycolors[i];
                });
              },
              child: Container(
                height: 50,
                width: 80,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(mycolors[i], BlendMode.hue),
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

  Widget _buildGradientColor(dynamic res) {
    setState(() {});
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: shadeFilterImage.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  blendMode = shadeFilterImage[i].blendMode;
                  shaderCallback = shadeFilterImage[i].shaderCallback;
                });
              },
              child: Container(
                height: 50,
                width: 80,
                child: ShaderMask(
                  blendMode: shadeFilterImage[i].blendMode,
                  shaderCallback: shadeFilterImage[i].shaderCallback,
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
