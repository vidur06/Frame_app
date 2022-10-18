// ignore_for_file: unnecessary_statements

import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectFrame extends StatefulWidget {
  const SelectFrame({Key? key}) : super(key: key);

  @override
  State<SelectFrame> createState() => _SelectFrameState();
}

class _SelectFrameState extends State<SelectFrame> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigatorObservers:
    [FirebaseAnalyticsObserver(analytics: analytics)];
  }
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
  List colors = const [
    Color.fromARGB(255, 208, 197, 206),
    Color.fromARGB(255, 208, 197, 206),
    Color.fromARGB(255, 208, 197, 206),
    Color.fromARGB(255, 208, 197, 206),
    Color.fromARGB(255, 208, 197, 206),
    Color.fromARGB(255, 208, 197, 206),
    Color.fromARGB(255, 208, 197, 206),
  ];
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Frame"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 12.0,
              children: List.generate(frames.length, (i) {
                return GestureDetector(
                  onTap: () async {
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
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
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 170,
                            width: 170,
                            color: colors[i],
                          ),
                          Container(
                            height: 145,
                            width: 145,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("${frames[i]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "${name[i]}",
                        style: const TextStyle(fontSize: 19),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}