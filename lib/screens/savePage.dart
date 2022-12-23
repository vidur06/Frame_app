// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  BannerAd? bannerAd;
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    // ignore: unused_label
    navigatorObservers:
    // ignore: unnecessary_statements
    [FirebaseAnalyticsObserver(analytics: analytics)];
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-6380676578937457/2423832529',
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isLoaded = true;
          });
          print('Banner Ad Loaded...');
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
        onAdOpened: (ad) {
          print('Ad Opened');
        },
        onAdClosed: (ad) {
          print('AD Closed');
        },
      ),
      request: const AdRequest(),
    );
    bannerAd!.load();

  }


  @override
  Widget build(BuildContext context) {
    final dynamic arg = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saved Data',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: Container(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: 500,
              width: 380,
              child: Image(image: MemoryImage(arg[0])),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                Share.shareFiles(
                  [arg[1].path],
                );
              },
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ),
              label: const Text(
                'Share',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Spacer(),
            isLoaded
                ? Container(
                    height: 50,
                    child: AdWidget(
                      ad: bannerAd!,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
