// ignore_for_file: unnecessary_statements, deprecated_member_use, avoid_print


import 'dart:io';

import 'package:festival_frame/widgets/stickIt.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../models/model.dart';
import '../models/sqlhelper.dart';

class StickerPage extends StatefulWidget {
  const StickerPage({Key? key}) : super(key: key);
  @override
  State<StickerPage> createState() => _StickerPageState();
}

class _StickerPageState extends State<StickerPage> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  late StickIt _stickIt;

  @override
  void initState() {
    super.initState();
    checkDB();
    // ignore: unused_label
    navigatorObservers:
    [FirebaseAnalyticsObserver(analytics: analytics)];
  }

  Future<void> checkDB() async {
    await DBHelper.dbHelper.initDB();
  }

  RewardedAd? rewardedAd;
  bool isRewarded = false;

  void rewardedAds() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-6380676578937457/8194624838',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;
          setState(() {
            isRewarded = true;
          });
          print('ad reward');
        },
        onAdFailedToLoad: (error) {
          print('reward failed');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dynamic arg = ModalRoute.of(context)!.settings.arguments;
    _stickIt = StickIt(
      panelStickerBackgroundColor: Colors.grey.shade300,
      stickerRotatable: true,
      panelBackgroundColor: Colors.transparent,
      stickerList: arg[1],
      child: Container(color: Colors.white, child: Image.memory(arg[0])),
    );
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Sticker Select', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final image = await _stickIt.exportImage();

              final img = await testComporessList(image);
              final date = DateTime.now().millisecondsSinceEpoch;
              final directory = Directory('/storage/emulated/0/Download');
              final dirPath = Directory('${directory.path}/Demo_app').create();
              final directoryPath = Directory('/storage/emulated/0/Download/Demo_app');
              final file = await File('${directoryPath.path}/$date.jpg').create();
              print('file : $file');
              file.writeAsBytes(img);

              Map<String, dynamic> data = {
                'image': img,
              };
               Storage s = Storage.fromMap(data);
              int id = await DBHelper.dbHelper.insert(s);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Successfully download ${file.path}"),
                  backgroundColor : Colors.green,
                ),
              );

              rewardedAds();
              if (isRewarded) {
                rewardedAd!.show(
                  onUserEarnedReward: (ad, reward) {},
                );
              }
              Navigator.of(context).pushNamedAndRemoveUntil(
                'savePage',
                (route) => false,
                arguments: image,
              );
                        
            },
            icon: const Icon(
              Icons.done,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: _stickIt,
    );
  }

  Future<Uint8List> testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1920, 
      minWidth: 1080,
      quality: 100,
    );
    return result;
  }
}
