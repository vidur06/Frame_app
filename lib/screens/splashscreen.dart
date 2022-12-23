// ignore_for_file: unnecessary_statements

import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
    });
    navigatorObservers:
    [FirebaseAnalyticsObserver(analytics: analytics)];
  }

  @override
  Widget build(BuildContext context) {
    final dynamic height = MediaQuery.of(context).size.height;
    final dynamic width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            color: Colors.white,
            child: Image.asset(
              "assets/images/splash.png",
              fit: BoxFit.fill,
              key: const ValueKey('image'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.83, left: width * 0.45),
            child:const CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
