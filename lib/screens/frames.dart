// ignore_for_file: unnecessary_statements, avoid_print, use_build_context_synchronously, require_trailing_commas

import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/unit.dart';

class Frames extends StatefulWidget {
  const Frames({Key? key}) : super(key: key);
  @override
  State<Frames> createState() => _FramesState();
}

class _FramesState extends State<Frames> {
  late InterstitialAd interstitialAd;
  bool isLoaded = true;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  void initState() {
    super.initState();
    [FirebaseAnalyticsObserver(analytics: analytics)];
    interstitialAds();
  }

  void interstitialAds() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-6380676578937457/8956369719',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            isLoaded = true;
            interstitialAd = ad;
          });
          print('ad loaded...');
        },
        onAdFailedToLoad: (error) {
          print('Interstitial Ad failed...');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dynamic res = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "select frame",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil('select_frame', (route) => false);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 3,
        itemCount: res[0].length,
        itemBuilder: (context, i) {
          return Card(
            elevation: 2,
            child: InkWell(
              onTap: () async {
                final pickedFile = await Imagepick.imagepic();
                // ignore: unnecessary_null_comparison
                if (pickedFile.path != null) {
                  Navigator.of(context).pushNamed("setimage", arguments: [
                    File(pickedFile.path),
                    res[0][i],
                    res[0],
                    res[1],
                  ]);
                }
                interstitialAds();
                if (isLoaded) {
                  interstitialAd.show();
                }
              },
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        res[0][i],
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        staggeredTileBuilder: (int index) =>
            StaggeredTile.count(1, index.isEven ? 1.5 : 01),
      ),
    );
  }
}
