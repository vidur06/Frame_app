// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// import '../models/model.dart';
// import '../models/sqlhelper.dart';

// class StoredImage extends StatefulWidget {
//   const StoredImage({Key? key}) : super(key: key);

//   @override
//   State<StoredImage> createState() => _StoredImageState();
// }

// List data = [];

// int j = 0;

// class _StoredImageState extends State<StoredImage> {
//   List image = [];
//   late Future<List<Storage>> fetchdata;

//   @override
//   void initState() {
//     super.initState();
//     fetchdata = DBHelper.dbHelper.fetchAllData();
//     checkDB();

//   }

//   checkDB() async {
//     await DBHelper.dbHelper.initDB();
//   }

//   // getdata() async {
//   //   SharedPreferences spref = await SharedPreferences.getInstance();
//   //   Uint8List? bytes;
//   //   data.addAll(spref.getStringList("image${j + 1}") ?? []);

//   //   for (int i = 0; i < data.length; i++) {
//   //     bytes = base64Decode(data[i]);
//   //   }
//   //   j++;
//   //   print(j);
//   //   return bytes;
//   // }

//   List store = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "your fhoto gallery",
//           ),
//           backgroundColor: Colors.grey,
//           centerTitle: true,
//         ),
//         body: FutureBuilder(
//           future: fetchdata,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Text(
//                     '${snapshot.error} occurred',
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                 );
//               } else if (snapshot.hasData) {
//                 List<Storage> data = snapshot.data as List<Storage>;
//                 return ListView.builder(
//                     itemCount: data.length,
//                     itemBuilder: (context, i) {
//                       return GestureDetector(
//                         onTap: () async {
//                           showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return AlertDialog(
//                                   title:
//                                       const Text('This is Peremently delete'),
//                                   content: Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       OutlinedButton(
//                                         onPressed: () {
//                                           Navigator.of(context).pop();
//                                         },
//                                         child: const Text(
//                                           'Close',
//                                           style: TextStyle(color: Colors.blue),
//                                         ),
//                                       ),
//                                       const SizedBox(width: 10),
//                                       ElevatedButton(
//                                         onPressed: () async {
//                                           await DBHelper.dbHelper
//                                               .delete(data[i].id);
//                                           setState(() {
//                                             fetchdata = DBHelper.dbHelper
//                                                 .fetchAllData();
//                                           });
//                                           Navigator.of(context).pop();
//                                         },
//                                         child: const Text('Delete'),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               });
//                         },
//                         child: Container(
//                           height: 300,
//                           width: 300,
//                           child: Image.memory(
//                             data[i].image,
//                           ),
//                         ),
//                       );
//                     });
//               }
//             }
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         )

//  FutureBuilder(
//   future: fetchdata,
//   builder: (ctx, snapshot) {
//     if (snapshot.connectionState == ConnectionState.done) {
//       if (snapshot.hasError) {
//         return Center(
//           child: Text(
//             '${snapshot.error} occurred',
//             style: const TextStyle(fontSize: 18),
//           ),
//         );
//       } else if (snapshot.hasData) {
//         var data = snapshot.data;
//         image.add(data);
// return GridView.count(
//     crossAxisCount: 2,
//     crossAxisSpacing: 4.0,
//     mainAxisSpacing: 5.0,
//     children: List.generate(image.length, (i) {
//       return InkWell(
//         onTap: () {
//           Navigator.of(context).pushNamed(
//             "setting",
//             arguments: image[i],
//           );
//         },
//         child: SizedBox(
//           height: 400,
//           width: 400,
//           // color: Colors.amber,
//           child: Image.memory(
//             image[i],
//           ),
//         ),
//       );
//             }));
// ListView.builder(
//     itemCount: image.length,
//     itemBuilder: (context, i) {
// return Container(
//   height: 300,
//   width: 300,
//   child: Image.memory(
//     image[i],
//   ),
// );
//     });
//   }
// }
// return const Center(
//   child: CircularProgressIndicator(),
// );
// },
// ),
//         );
//   }
// }

import 'dart:typed_data';

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
  late Future<List<Storage>> fetchdata;
  @override
  void initState() {
    super.initState();
    fetchdata = DBHelper.dbHelper.fetchAllData();
    checkDB();
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
                                    await DBHelper.dbHelper.delete(data[i].id);
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
