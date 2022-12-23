import 'package:festival_frame/widgets/common_list_tile.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  void initState() {
    super.initState();
    // ignore: unused_label
    navigatorObservers:
    // ignore: unnecessary_statements
    [FirebaseAnalyticsObserver(analytics: analytics)];
  }
  @override
  Widget build(BuildContext context) {
    final dynamic height = MediaQuery.of(context).size.height;
    final dynamic width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abouts'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonListTile(
              title: 'About this app',
              content:
                  '-- All In One Photo Frames And Photo Editor help you to create various types of photos with predesign photo frames. Enjoy all the unlimited features in One photo editor app.\n\n-- All Occasion photo editor is a collection of photo frames app with best image editor tool to keep your memorable picture in frames.',
              height: height * 0.5,
              width: width * 0.9,
            ),
            Divider(
              color: Colors.black,
              height: 2,
              indent: width * 0.03,
              endIndent: width * 0.03,
            ),
            CommonListTile(
              title: 'Features',
              content:
                  '-- Different categories frames collections\n-- create post by editing existing image\n-- text to frame with multiple text style (fonts, text border, colors)\n-- Brush on customized photo\n-- category wise stickers\n-- simply flip(horizontally or vertically) your image\n-- overlay or effect to selected image\n-- single touch to rotate, flip, delete and resize text or sticker or image\n-- scale, rotate, zoom in/zoom out or drag the photo to fit the frame as needed.\n-- Easily save and view your decorated photo to gallery.\n-- Share this decorated photo on Social Network.',
              height: height * 0.8,
              width: width * 0.9,
            ),
            Divider(
              color: Colors.black,
              height: 2,
              indent: width * 0.03,
              endIndent: width * 0.03,
            ),
            CommonListTile(
              title: 'Frame Categories',
              content:
                  '-- Janmashtami Photo Frame\n-- Independence day Photo Frame\n-- Rakshabandhan Photo Frame\n-- Diwali Photo Frame\n-- Christmas Photo Frame\n-- Kite Photo Frame\n-- Navratri Photo Frame\n-- Holi Photo Frame\n-- Ganesh Chaturthi Photo Frame',
              height: height * 0.5,
              width: width * 0.9,
            ),
            Divider(
              color: Colors.black,
              height: 2,
              indent: width * 0.03,
              endIndent: width * 0.03,
            ),
            CommonListTile(
              title: 'How to use?',
              content:
                  '-- Select Photo Frame category\n-- Select Picture from your Gallery or Camera\n-- Adjust photo to fit the frame\n-- Apply Text\n-- Select sticker\n-- Add more photo From Gallery And also adjust Opacity\n-- Click on save\n-- Easily share your decorated photo with your friends',
              height: height * 0.5,
              width: width * 0.9,
            ),
            Divider(
              color: Colors.black,
              height: 2,
              indent: width * 0.03,
              endIndent: width * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
