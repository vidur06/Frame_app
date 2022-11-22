// ignore_for_file: unnecessary_statements

import 'dart:io';

import 'package:festival_frame/models/unit.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/images.dart';

class SelectFrame extends StatefulWidget {
  const SelectFrame({Key? key}) : super(key: key);

  @override
  State<SelectFrame> createState() => _SelectFrameState();
}

class _SelectFrameState extends State<SelectFrame> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  void initState() {
    super.initState();
    navigatorObservers:
    [FirebaseAnalyticsObserver(analytics: analytics)];
  }

  List frames = frameImage;
  List allframe = fImage;
  List name = festivleName;
  List colors = imageColors;

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Frame"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
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
                    var argument;
                    allframe.forEach((e) {
                      (e.name == name[i]) ? argument = e.list : argument;
                    });
                    Navigator.of(context).pushNamed(
                      "frames",
                      arguments: argument,
                    );
                  },
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 154,
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
