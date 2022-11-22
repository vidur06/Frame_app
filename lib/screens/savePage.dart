// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  BannerAd? bannerAd;
  bool isLoaded = false;
  RewardedAd? rewardedAd;
  bool isRewarded = false;
  @override
  void initState() {
    super.initState();
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

   rewardedAds() {
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
    dynamic arg = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.black,
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
                  rewardedAds();
              if (isRewarded) {
                rewardedAd!.show(
                  onUserEarnedReward: (ad, reward) {},
                );
              }
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
              child: Image(image: MemoryImage(arg)),
            ),
            ElevatedButton.icon(
              onPressed: () {
                rewardedAds();
                if (isRewarded) {
                  rewardedAd!.show(
                    onUserEarnedReward: (ad, reward) {},
                  );
                }
              },
              // style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
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
