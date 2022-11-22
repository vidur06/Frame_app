import 'package:festival_frame/screens/frames.dart';
import 'package:festival_frame/screens/final.dart';
import 'package:festival_frame/screens/ratepage.dart';
import 'package:festival_frame/screens/re_frames.dart';
import 'package:festival_frame/screens/savePage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:festival_frame/screens/allscreen.dart';
import 'package:festival_frame/screens/framepage.dart';
import 'package:festival_frame/screens/frameselect.dart';
import 'package:festival_frame/screens/setimage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
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
        'ratepage': (contrxt) => const RatePage(),
        're_frames': (context)=> const ReFrames(),
        'savePage': (context) => const SavePage(),
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
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TabBarView(
          physics:
              const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: const <Widget>[
            DashBoard(),
            AlbumPage(),
            Setting(),
          ],
        ),
      ),
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Dashboard",
        labels: const ["Dashboard", "Story", "Settings"],
        icons: const [
          Icons.dashboard,
          Icons.auto_mode_rounded,
          Icons.settings
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.blue[600],
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.blue,
        tabIconSelectedColor: Colors.white,
        tabBarColor: const Color.fromRGBO(255,255,255,1),
        onTabItemSelected: (int value) {
          setState(() {
            _tabController.index = value;
          });
        },
      ),
      // bottomNavigationBar:
      // BottomNavyBar(
      //   selectedIndex: _selectedPage,
      //   showElevation: true,
      //   itemCornerRadius: 24,
      //   onItemSelected: (index) {
      //     setState(() {
      //       _selectedPage = index;
      //     });
      //   },
      //   curve: Curves.easeIn,
      //   items: <BottomNavyBarItem>[
      //     BottomNavyBarItem(
      //       icon: const Icon(Icons.dashboard),
      //       title: const Text("Dash Board"),
      //       activeColor: Colors.blue,
      //       textAlign: TextAlign.center,
      //     ),
      //     BottomNavyBarItem(
      //       icon: const Icon(Icons.auto_mode_rounded),
      //       title: const Text("Story"),
      //       activeColor: Colors.blue,
      //       textAlign: TextAlign.center,
      //     ),
      //     BottomNavyBarItem(
      //       icon: const Icon(Icons.settings),
      //       title: const Text("Settings"),
      //       activeColor: Colors.blue,
      //       textAlign: TextAlign.center,
      //     ),
      //   ],
      // ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // import 'package:widget_size_example/widget/button_widget.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   static final String title = 'Widget Size & Position';

//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: title,
//         theme: ThemeData(primaryColor: Colors.blue),
//         home: MainPage(title: title),
//       );
// }

// class MainPage extends StatefulWidget {
//   final String title;

//   const MainPage({
//     required this.title,
//   });

//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   final keyText = GlobalKey();
//   Size? size;
//   Offset position = Offset.zero;

//   @override
//   void initState() {
//     super.initState();

//     calculateSizeAndPosition();
//   }

//   void calculateSizeAndPosition() =>
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//          final RenderBox box = keyText.currentContext!.findRenderObject() as RenderBox;

//         setState(() {
//           position = box.localToGlobal(Offset.zero);
//           size = box.size;
//         });
//       });

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: Padding(
//           padding:const EdgeInsets.all(32),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               buildText(),
//               const SizedBox(height: 32),
//               TextButton(
//                 onPressed: calculateSizeAndPosition,
//                 child:const Text('Calculate'),
//               ),
//               const SizedBox(height: 32),
//               buildResult(),
//             ],
//           ),
//         ),
//       );

//   Widget buildText() => Text(
//         'What is my Widget Size & Position?',
//         key: keyText,
//         style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//         textAlign: TextAlign.center,
//       );

//   Widget buildResult() {
//     if (size == null || position == null) return Container();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Width: ${size!.width.toInt()}',
//           style: TextStyle(fontSize: 32),
//         ),
//         Text(
//           'Height: ${size!.height.toInt()}',
//           style: TextStyle(fontSize: 32),
//         ),
//         Text(
//           'X: ${position.dx.toInt()}',
//           style: TextStyle(fontSize: 32),
//         ),
//         Text(
//           'Y: ${position.dy.toInt()}',
//           style: TextStyle(fontSize: 32),
//         ),
//       ],
//     );
//   }
// }