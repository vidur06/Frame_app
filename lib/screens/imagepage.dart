// ignore_for_file: unnecessary_statements

import 'package:festival_frame/models/unit.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../models/model.dart';
import '../models/sqlhelper.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late Future<List<Storage>> fetchdata;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: const Text(
          " Your Story",
          style: TextStyle(),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: fetchdata,
        builder: (context, snapshot) {
          print('snapshot.data: ${snapshot.data}');
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
              return GridView.builder(
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          'compress_image',
                          arguments: data[i].image,
                        );
                      },
                      onDoubleTap: () async {
                        Navigator.of(context).pushNamed(
                          'image_show',
                          arguments: data[i].image,
                        );
                      },
                      onLongPress: () {
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
                                        await DBHelper.dbHelper
                                            .delete(data[i].id);
                                        setState(() {
                                          fetchdata =
                                              DBHelper.dbHelper.fetchAllData();
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Container(
                        child: Image.memory(
                          data[i].image,
                        ),
                      ),
                    );
                  });
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
