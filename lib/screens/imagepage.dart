// ignore_for_file: unnecessary_statements

import 'package:festival_frame/models/frame_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import '../models/sqlhelper.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late Future<List<Storage>> fetchdata;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  Future<void> checkDB() async {
    await DBHelper.dbHelper.initDB();
  }

  @override
  void initState() {
    super.initState();
    checkDB();
    fetchdata = DBHelper.dbHelper.fetchAllData();
    navigatorObservers:
    [FirebaseAnalyticsObserver(analytics: analytics)];
  }

  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: (res != null)
            ? IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              )
            : Container(),
        title: const Text(" Your Story"),
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
              final dataList = data.reversed.toList();
              return GridView.builder(
                itemCount: dataList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        'compress_image',
                        arguments: dataList[i].image,
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
                                        .delete(dataList[i].id);
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
                        },
                      );
                    },
                    child: Container(
                      child: Image.memory(
                        dataList[i].image,
                      ),
                    ),
                  );
                },
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
