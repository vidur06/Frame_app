import 'package:festival_frame/screens/about_app.dart';
import 'package:festival_frame/screens/compress_image.dart';
import 'package:festival_frame/screens/frames.dart';
import 'package:festival_frame/screens/final.dart';
import 'package:festival_frame/screens/image_show.dart';
import 'package:festival_frame/screens/re_frames.dart';
import 'package:festival_frame/screens/savePage.dart';
import 'package:festival_frame/screens/settings.dart';
import 'package:festival_frame/screens/text_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:festival_frame/screens/allscreen.dart';
import 'package:festival_frame/screens/framepage.dart';
import 'package:festival_frame/screens/frameselect.dart';
import 'package:festival_frame/screens/setimage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'screens/imagepage.dart';
import 'screens/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  //   FirebaseCrashlytics.instance.crash();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  MobileAds.instance.initialize();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splashscreen',
      routes: {
        "/": (context) => const MyHomePage(),
        "splashscreen": (context) => const SplashScreen(),
        "dashboard": (context) => const DashBoard(),
        "setimage": (context) => const SetImage(),
        "framepage": (context) => const FramePage(),
        "select_frame": (context) => const SelectFrame(),
        "imagepage": (context) => const AlbumPage(),
        "setting": (context) => const Setting(),
        "sticker": (context) => const StickerPage(),
        "frames": (context) => const Frames(),
        're_frames': (context) => const ReFrames(),
        'savePage': (context) => const SavePage(),
        'image_show': (context) => const ImageShow(),
        'compress_image': (context) => const CompressImage(),
        'about_app':(context) => const AboutApp(),
        'text_page':(context) => const TextPage(),
      },
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
    ),
  );
  // ignore: unnecessary_statements
  (error, stack) =>
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {

  int currentTab = 0;
  final List<Widget> screens = <Widget>[
    const DashBoard(),
    const AlbumPage(),
    const Setting(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const DashBoard();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentScreen = const DashBoard();
            currentTab = 0;
          });
        },
        child: Icon(
          Icons.dashboard,
          size: (currentTab == 0) ? 30 : 25,
          color: currentTab == 0 ? Colors.white : Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.blue,
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = const AlbumPage();
                      currentTab = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        size: (currentTab == 1) ? 30 : 25,
                        Icons.auto_mode_rounded,
                        color: currentTab == 1 ? Colors.white : Colors.black,
                      ),
                      Text(
                        'Story',
                        style: TextStyle(
                          color: currentTab == 1 ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = const Setting();
                      currentTab = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings,
                        size: (currentTab == 2) ? 30 : 25,
                        color: currentTab == 2 ? Colors.white : Colors.black,
                      ),
                      Text(
                        'Settings',
                        style: TextStyle(
                          color: currentTab == 2 ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
