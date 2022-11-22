import 'dart:io';
// ignore_for_file: unnecessary_statements

import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:festival_frame/models/frame_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:screenshot/screenshot.dart';

import '../models/images.dart';
import '../models/unit.dart';
import '../widgets/widgets.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  List image = [
    "assets/images/ad1.png",
    "assets/images/ad2.png",
    "assets/images/ad3.jpg",
    "assets/images/ad4.jpg",
    "assets/images/ad5.jpg",
    "assets/images/ad6.jpg",
    "assets/images/ad7.jpg",
    "assets/images/ad8.jpg",
    "assets/images/ad9.jpg",
    "assets/images/ad10.jpg",
    "assets/images/ad11.jpg",
  ];

  List framesImage = fImage;
  List iconImage = icons;

  @override
  void initState() {
    super.initState();
    items.addAll(drawer);
    navigatorObservers:
    [FirebaseAnalyticsObserver(analytics: analytics)];
  }

  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      GlobalKey<ScaffoldState>();

  TextEditingController editingController = TextEditingController();
  List items = [];

  String userImage = "";
  List<String> drawer = festivleName;

  void filterSearchResults(String query) {
    final List<String> dummySearchList = [];
    dummySearchList.addAll(drawer);
    if (query.isNotEmpty) {
      final List<String> dummyListData = [];
      for (final item in dummySearchList) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(drawer);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: const Text("Dashboard"),
        leading: IconButton(
          onPressed: () {
            if (_drawerscaffoldkey.currentState!.isDrawerOpen) {
              Navigator.pop(context);
            } else {
              _drawerscaffoldkey.currentState!.openDrawer();
            }
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      body: Scaffold(
        key: _drawerscaffoldkey,
        drawer: Opacity(
          opacity: 0.95,
          child: Drawer(
            backgroundColor: Colors.white,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Festivals",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 20,
                    left: 10,
                    right: 10,
                  ),
                  child: TextField(
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    controller: editingController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 10.0,
                      ),
                      hintText: "Search",
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: ListTile(
                              onTap: () async {
                                var argument;
                                print('items[i] : ${items[i]}');
                                framesImage.forEach((e) {
                                  (e.name == items[i])
                                      ? argument = e.list
                                      : argument;
                                  // print('e.name: ${e.list}');
                                });
                                print('argument: $argument');
                                //   final pickedFile = await Imagepick.imagepic();
                                // if (pickedFile.path != null) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pushNamed(
                                  "frames",
                                  arguments: argument,
                                );
                              },
                              title: Text(
                                items[i],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              leading: SizedBox(
                                height: 30,
                                width: 30,
                                child: Image(
                                  image: AssetImage(iconImage[i]),
                                ),
                              ),
                              minVerticalPadding: 20,
                              style: ListTileStyle.list,
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.8,
                            indent: 4,
                            endIndent: 4,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                items: image.map((e) {
                  return Builder(
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: 385,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("$e"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  autoPlay: true,
                  reverse: true,
                  height: 170,
                  viewportFraction: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigation.Select_Frame(context);
                      },
                      child: LableWidget(
                        text: "Frame",
                        color1: Colors.lightBlue.shade300,
                        color2: Colors.blue.shade800,
                        icon: const Icon(
                          Icons.filter_frames,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigation.ImagePage(context);
                      },
                      child: LableWidget(
                        text: "Album",
                        color1: Colors.pink.shade600,
                        color2: const Color.fromARGB(255, 251, 71, 248),
                        icon: const Icon(
                          Icons.photo,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigation.Ratepage(context);
                      },
                      child: LableWidget(
                        text: "Rate",
                        color1: Colors.orange,
                        color2: Colors.yellow.shade700,
                        icon: const Icon(
                          Icons.star_sharp,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(
      () {
        if (pickedFile != null) {
          userImage = pickedFile.path;
        } else {
          // ignore: avoid_print
          print('No image selected.');
        }
      },
    );
  }
}

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  int _value = 20;
  Uint8List? result;
  final controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "settings",
          key: ValueKey('appbar text'),
        ),
      ),
      body: (res == null)
          ? Center(
              key: const ValueKey("center"),
              child: Column(
                key: const ValueKey("column"),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    key: const ValueKey("inkwell"),
                    onTap: () {
                      Navigation.ImagePage(context);
                    },
                    child: const CircleAvatar(
                      key: ValueKey("circle avtar"),
                      radius: 50,
                      child: Icon(
                        key: ValueKey("icon"),
                        Icons.add,
                        size: 70,
                      ),
                    ),
                  ),
                  const Text(
                    "Tap to select image",
                    key: ValueKey("text"),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Screenshot(
                    controller: controller,
                    child: InteractiveViewer(
                      child: SizedBox(
                        width: 400,
                        height: 500,
                        child: Image.memory(
                          (result != null) ? result : res,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
                  ),
                  Slider(
                    value: _value.toDouble(),
                    min: 0,
                    max: 100.0,
                    divisions: 100,
                    label: "$_value",
                    onChanged: (double newValue) async {
                      setState(() {
                        _value = newValue.round();
                      });
                      res = await FlutterImageCompress.compressWithList(
                        res,
                        quality: _value,
                      );
                      setState(() {
                        result = res;
                      });
                    },
                    onChangeEnd: (double newValue) async {
                      setState(() {
                        _value = newValue.round();
                      });
                      res = await FlutterImageCompress.compressWithList(
                        res,
                        quality: _value,
                        rotate: 20,
                      );
                    },
                    semanticFormatterCallback: (double newValue) {
                      return '${newValue.round()} ';
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text(
                        "Low",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "medium",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "high",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      minimumSize: const Size(300, 45),
                    ),
                    onPressed: () {
                      ScreenCapture.Capture(context, controller);
                    },
                    child: const Text("Export"),
                  ),
                ],
              ),
            ),
    );
  }
}
