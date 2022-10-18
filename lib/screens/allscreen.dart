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
    "Diwali",
    "Holi",
    "Navratri",
    "Chrismas",
    "Rakhi",
    "Janmashtmi",
    "Makar Sankratri",
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
                      // focusedBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.redAccent),
                      // ),
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
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            "frames",
                            arguments: items[i],
                          );
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
                            // borderRadius: BorderRadius.circular(8.0),
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

                        // final pickedFile =
                        //     await picker.pickImage(source: ImageSource.gallery);
                        // if (pickedFile!.path != null) {
                        //   Navigator.of(context).pushNamed("setimage",
                        //       arguments: File(pickedFile.path));
                        // }
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
        title: const Text("settings"),
      ),
      body: (res == null)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed("imagepage");
                    },
                    child: const CircleAvatar(
                      radius: 50,
                      child: Icon(
                        Icons.add,
                        size: 70,
                      ),
                    ),
                  ),
                  const Text(
                    "Tap to select image",
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