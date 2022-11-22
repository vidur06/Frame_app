// ignore_for_file: unnecessary_statements, deprecated_member_use

import 'dart:io';
import 'dart:typed_data';

import 'package:festival_frame/models/unit.dart';
import 'package:festival_frame/widgets/stickIt.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../models/model.dart';
import '../models/sqlhelper.dart';

class StickerPage extends StatefulWidget {
  const StickerPage({Key? key}) : super(key: key);
  @override
  State<StickerPage> createState() => _StickerPageState();
}

class _StickerPageState extends State<StickerPage> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  ScreenshotController screenshotController = ScreenshotController();
  late StickIt _stickIt;
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
      stickerList: [
        Image.asset("assets/sticker/s1.png"),
        Image.asset("assets/sticker/s2.png"),
        Image.asset("assets/sticker/s3.png"),
        Image.asset("assets/sticker/s4.png"),
        Image.asset("assets/sticker/s5.png"),
        Image.asset("assets/sticker/s6.png"),
        Image.asset("assets/sticker/s7.png"),
        Image.asset("assets/sticker/s8.png"),
        Image.asset("assets/sticker/s9.png"),
        Image.asset("assets/sticker/s10.png"),
        Image.asset("assets/sticker/s11.png"),
        Image.asset("assets/sticker/s12.png"),
        Image.asset("assets/sticker/s13.png"),
        Image.asset("assets/sticker/s14.png"),
        Image.asset("assets/sticker/s15.png"),
        Image.asset("assets/sticker/s16.png"),
        Image.asset("assets/sticker/s17.png"),
        Image.asset("assets/sticker/s18.png"),
        Image.asset("assets/sticker/s19.png"),
        Image.asset("assets/sticker/s20.png"),
        Image.asset("assets/sticker/s21.png"),
        Image.asset("assets/sticker/s22.png"),
        Image.asset("assets/sticker/s23.png"),
      ],
      child: Container(color: Colors.white, child: Image.memory(arg)),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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

              Navigator.of(context).pushNamedAndRemoveUntil(
                'savePage',
                (route) => false,
                arguments: image,
              );
              // ignore: use_build_context_synchronously
              SaveDB.Store(context, image, fetchdata);

              // ShowCapturedWidget(context, image);
              rewardedAds();
              if (isRewarded) {
                rewardedAd!.show(
                  onUserEarnedReward: (ad, reward) {},
                );
              }
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

  // ignore: non_constant_identifier_names
  Future<dynamic> ShowCapturedWidget(
    BuildContext context,
    Uint8List capturedImage,
  ) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: const Text("saved image"),
          actions: [
            IconButton(
              onPressed: () async {
                // final url = ;
                File s = File.fromRawPath(capturedImage);
                final directory = await getApplicationDocumentsDirectory();
                final image = File('${directory.path}/flutter.png');
                image.writeAsBytesSync(capturedImage);
                Share.shareFiles([image.path]);

                rewardedAds();
                if (isRewarded) {
                  rewardedAd!.show(
                    onUserEarnedReward: (ad, reward) {},
                  );
                }
              },
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Center(
          child: capturedImage != null
              ? Column(
                  children: [
                    Container(
                      height: 500,
                      width: 500,
                      child: Image.memory(capturedImage),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/',
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text("Done"),
                    )
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
