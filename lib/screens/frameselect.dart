// ignore_for_file: unnecessary_statements

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
    items.addAll(festivleList);
    navigatorObservers:
    [FirebaseAnalyticsObserver(analytics: analytics)];
  }

  List allframe = fImage;
  List items = [];
  List festivleList = selectFrameField;
  bool isSearch = false;

  final picker = ImagePicker();

  TextEditingController textEditingController = TextEditingController();

  void filterSearchResult(String query) {
    final List dummySearchList = [];
    dummySearchList.addAll(festivleList);
    if (query.isNotEmpty) {
      final List dummyListData = [];
      for (final item in dummySearchList) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
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
        items.addAll(festivleList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dynamic height = MediaQuery.of(context).size.height;
    final dynamic width = MediaQuery.of(context).size.width;
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
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearch = !isSearch;
              });
            },
            icon: isSearch
                ? const Icon(Icons.search_off_outlined)
                : const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          isSearch
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 10,
                    right: 10,
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      filterSearchResult(value);
                    },
                    controller: textEditingController,
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
                )
              : Container(),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 1.3,
              mainAxisSpacing: 12.0,
              children: List.generate(items.length, (i) {
                return GestureDetector(
                  onTap: () async {
                    var argument;
                    allframe.forEach((e) {
                      (e.name == items[i].name)
                          ? argument = [e.list, e.sticker]
                          : argument;
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
                            height: height * 0.2,
                            width: width * 0.41,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[300],
                            ),
                          ),
                          Container(
                            height: height * 0.18,
                            width: width * 0.37,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: AssetImage("${items[i].img}"),
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
                        "${items[i].name}",
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
