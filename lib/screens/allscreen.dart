import 'dart:io';
// ignore_for_file: unnecessary_statements

import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:screenshot/screenshot.dart';

import '../widgets/widgets.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  List image = [
    "assets/images/ad1.jpg",
    "assets/images/ad2.jpg",
    "assets/images/ad3.jpg",
  ];

  List frames = [
    "assets/images/navratri.png",
    "assets/images/diwali.jpg",
    "assets/images/rakhi.jpg",
    "assets/images/mkr.jpg",
    "assets/images/holi.png",
    "assets/images/janmashtmi.jpg",
    "assets/images/chrismas.jpg",
  ];
  List allframe = [
    //navratri :-
    [
      "assets/images/n1.png",
      "assets/images/n2.png",
      "assets/images/n3.png",
      "assets/images/n4.png",
      "assets/images/n5.png",
      "assets/images/n6.png",
      "assets/images/n7.png",
    ],
    //diwali :-
    [
      "assets/images/d1.png",
      "assets/images/d2.png",
      "assets/images/d3.png",
      "assets/images/d4.png",
      "assets/images/d5.png",
    ],
    //rakhi:-
    [
      "assets/images/r1.png",
      "assets/images/r2.png",
      "assets/images/r3.png",
      "assets/images/r4.png",
    ],
    //Makar Sankranti:-
    [
      "assets/images/m1.png",
      "assets/images/m2.png",
      "assets/images/m3.png",
      "assets/images/m5.png",
    ],
    //holi:-
    [
      "assets/images/h1.png",
      "assets/images/h2.png",
      "assets/images/h3.png",
      "assets/images/h4.png",
      "assets/images/h5.png",
    ],
    //janmastmi:-
    [
      "assets/images/j1.png",
      "assets/images/j2.png",
      "assets/images/j3.png",
      "assets/images/j4.png",
      "assets/images/j5.png",
    ],
    //chrishmas:-
    [
      "assets/images/c1.png",
      "assets/images/c2.png",
      "assets/images/c3.png",
      "assets/images/c4.png",
      "assets/images/c5.png",
    ],
  ];

  List name = [
    "Navratri",
    "Diwali",
    "Rakhi",
    "Makar Sankranti",
    "Holi",
    "Janmashtmi",
    "marry Chrishmas"
  ];

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
  List<String> drawer = [
    "Navratri",
    "Diwali",
    "Rakhi",
    "Makar Sankranti",
    "Holi",
    "Janmashtmi",
    "marry Chrishmas"
  ];
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
            backgroundColor: Colors.grey[200],
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Festivals",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
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
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () async {
                          final pickedFile = await picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          // ignore: unnecessary_null_comparison
                          if (pickedFile!.path != null) {
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushNamed(
                              "setimage",
                              arguments: [
                                File(pickedFile.path),
                                allframe[i],
                              ],
                            );
                          }
                        },
                        child: ListTile(
                          shape: (i == 0)
                              ? Border(
                                  top: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1.5,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1.5,
                                  ),
                                )
                              : Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1.5,
                                  ),
                                ),
                          title: Text(
                            items[i],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          minVerticalPadding: 20,
                          style: ListTileStyle.list,
                        ),
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
                        Navigator.of(context).pushNamed("select_frame");
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
                        Navigator.of(context).pushNamed("imagepage");
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
                      onTap: (){
                        Navigator.of(context).pushNamed('ratepage');
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
              key: const ValueKey("column"),
              child: Column(
                key: const ValueKey("column"),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    key: const ValueKey("inkwell"),
                    onTap: () {
                      Navigator.of(context).pushNamed("imagepage");
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
                      primary: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      minimumSize: const Size(300, 45),
                    ),
                    onPressed: () {
                      controller
                          .capture(
                        delay: const Duration(milliseconds: 10),
                      )
                          .then((capturedImage) async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("image Exported"),
                            backgroundColor: Colors.green,
                          ),
                        );

                        await ImageGallerySaver.saveImage(capturedImage!);
                      }).catchError((onError) {
                        // ignore: avoid_print
                        print(onError);
                      });
                    },
                    child: const Text("Export"),
                  ),
                ],
              ),
            ),
    );
  }
}