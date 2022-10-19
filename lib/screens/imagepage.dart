// ignore_for_file: unnecessary_statements

import 'dart:typed_data';

import 'package:festival_frame/models/unit.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../models/model.dart';
import '../models/sqlhelper.dart';

class AlbumPage extends StatefulWidget {
  static const String id = 'LocalStorage';
  const AlbumPage({Key? key}) : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  late Future<List<Storage>> fetchdata;
  @override
  void initState() {
    super.initState();
    fetchdata = DBHelper.dbHelper.fetchAllData();
    checkDB();
    navigatorObservers:
    [FirebaseAnalyticsObserver(analytics: analytics)];
  }

  Future<void> checkDB() async {
    await DBHelper.dbHelper.initDB();
  }

  List image = [];

  Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        title: const Text(
          "Storage",
          style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: fetchdata,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              final List<Storage> data = snapshot.data as List<Storage>;
              return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 5.0,
                children: List.generate(data.length, (i) {
                  // itemCount: data.length,
                  // itemBuilder: (context, i) {
                  return GestureDetector(
                    onLongPress: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('This is Peremently delete'),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Close',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () async {
                                    DeleteDB.Deletedb(data[i].id);
                                    setState(() {
                                      fetchdata =
                                          DBHelper.dbHelper.fetchAllData();
                                    });
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed("setting", arguments: data[i].image);
                    },
                    child: SizedBox(
                      height: 300,
                      width: 300,
                      child: Image.memory(
                        data[i].image,
                      ),
                    ),
                  );
                }),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
