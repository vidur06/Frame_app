// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';
import 'dart:typed_data';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:festival_frame/models/model.dart';
import 'package:festival_frame/models/sqlhelper.dart';
import 'package:festival_frame/screens/allscreen.dart';
import 'package:festival_frame/screens/demo.dart';
import 'package:festival_frame/screens/final.dart';
import 'package:festival_frame/screens/framepage.dart';
import 'package:festival_frame/screens/frameselect.dart';
import 'package:festival_frame/screens/imagepage.dart';
import 'package:festival_frame/screens/splashscreen.dart';
import 'package:festival_frame/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:festival_frame/main.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stick_it/stick_it.dart';

void main() {
  group("Splash screen", () {
    testWidgets('find image', (tester) async {
      final childWidget = find.byKey(const ValueKey("image"));
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Image(
              image: AssetImage("assets/images/splash.jpg"),
              key: ValueKey('image'),
            ),
          ),
        ),
      );
      await tester.pump(
        const Duration(seconds: 5),
      );
      expect(childWidget, findsOneWidget);
    });
  });

  group("Home screen", () {
    testWidgets('find dashboard', (tester) async {
      final childWidget2 = find.byKey(const ValueKey("Dash Board"));

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Text(
              "Dash Board",
              key: ValueKey("Dash Board"),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(childWidget2, findsOneWidget);
    });

    testWidgets('find Story', (tester) async {
      final childWidget2 = find.byKey(const ValueKey("Story"));

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Text(
              "Story",
              key: ValueKey("Story"),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(childWidget2, findsOneWidget);
    });
    testWidgets('find Settings', (tester) async {
      final childWidget2 = find.byKey(const ValueKey("Settings"));

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Text(
              "Settings",
              key: ValueKey("Settings"),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(childWidget2, findsOneWidget);
    });
  });

  group("Dash board", () {
    testWidgets('find appbar text', (tester) async {
      final childWidget = find.byKey(const ValueKey("dash Board"));
      final childWidget1 = find.byKey(const ValueKey("drawer tap"));
      final GlobalKey<ScaffoldState> _drawerscaffoldkey =
          GlobalKey<ScaffoldState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text(
                "dash Board",
                key: ValueKey("dash Board"),
              ),
              leading: IconButton(
                key: const ValueKey("drawer tap"),
                onPressed: () {},
                icon: const Icon(Icons.menu),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pump();
      expect(childWidget, findsOneWidget);
      expect(childWidget1, findsOneWidget);
    });
    testWidgets('find Opacity Widget', (tester) async {
      final childWidget = find.byKey(const ValueKey("Opacity"));
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Opacity(
              key: ValueKey("Opacity"),
              opacity: 0.95,
            ),
          ),
        ),
      );
      await tester.pump();
      expect(childWidget, findsOneWidget);
    });
    testWidgets('find drawer Widget', (tester) async {
      final childWidget = find.byKey(const ValueKey("Drawer"));
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Opacity(
              opacity: 0.95,
              child: Drawer(
                key: ValueKey("Drawer"),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(childWidget, findsOneWidget);
    });
    testWidgets('find padding Widget', (tester) async {
      final childWidget = find.byKey(const ValueKey("Drawer"));
      const childWidget1 = Padding(
        padding: EdgeInsets.all(8.0),
      );
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Opacity(
              opacity: 0.95,
              child: Drawer(
                key: ValueKey("Drawer"),
                child: childWidget1,
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(childWidget, findsOneWidget);
      expect(find.byWidget(childWidget1), findsOneWidget);
    });
    testWidgets('find text Widget', (tester) async {
      final childWidget = find.byKey(const ValueKey("Drawer"));
      const childWidget1 = Text(
        "Festivals",
        style: TextStyle(
          fontSize: 22,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Opacity(
              opacity: 0.95,
              child: Drawer(
                key: ValueKey("Drawer"),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: childWidget1,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(childWidget, findsOneWidget);
      expect(find.byWidget(childWidget1), findsOneWidget);
    });
    testWidgets('find padding Widget', (tester) async {
      final childWidget = find.byKey(const ValueKey("Drawer"));
      const childWidget1 = Padding(
        padding: EdgeInsets.only(
          top: 8,
          bottom: 20,
          left: 10,
          right: 10,
        ),
      );
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Opacity(
              opacity: 0.95,
              child: Drawer(
                key: ValueKey("Drawer"),
                child: childWidget1,
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(childWidget, findsOneWidget);
      expect(find.byWidget(childWidget1), findsOneWidget);
    });
    testWidgets('find padding Widget', (tester) async {
      final childWidget = find.byKey(const ValueKey("Drawer"));
      const childWidget1 = Padding(
        padding: EdgeInsets.only(
          top: 8,
          bottom: 20,
          left: 10,
          right: 10,
        ),
      );
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Opacity(
              opacity: 0.95,
              child: Drawer(
                key: ValueKey("Drawer"),
                child: childWidget1,
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(childWidget, findsOneWidget);
      expect(find.byWidget(childWidget1), findsOneWidget);
    });
    testWidgets('find textfield Widget', (tester) async {
      final childWidget = find.byKey(const ValueKey("Drawer"));
      const icon = Icon(Icons.search);
      const childWidget1 = TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 10.0,
          ),
          hintText: "Search",
          prefixIcon: icon,
        ),
      );
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Opacity(
              opacity: 0.95,
              child: Drawer(
                key: ValueKey("Drawer"),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 20,
                    left: 10,
                    right: 10,
                  ),
                  child: childWidget1,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byIcon(Icons.search));
      await tester.pump();
      expect(childWidget, findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byWidget(childWidget1), findsOneWidget);
      expect(find.byWidget(icon), findsOneWidget);
    });

    testWidgets('find Carosal Slider Widget', (tester) async {
      List image = [
        "assets/images/ad1.jpg",
        "assets/images/ad2.jpg",
        "assets/images/ad3.jpg",
      ];
      final childWidget1 = CarouselSlider(
        items: image.map((e) {
          return Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 385,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("$e"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
        options: CarouselOptions(
          enlargeCenterPage: true,
          autoPlay: true,
          reverse: true,
          height: 170,
          viewportFraction: 1,
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
              body: Column(
            children: [
              childWidget1,
            ],
          )),
        ),
      );
      await tester.pump();
      expect(find.byWidget(childWidget1), findsOneWidget);
    });

    testWidgets('find lable Widget', (tester) async {
      const icon = Icon(
        Icons.filter_frames,
        color: Colors.white,
        size: 45,
      );
      const icon1 = Icon(
        Icons.photo,
        color: Colors.white,
        size: 45,
      );
      const icon2 = Icon(
        Icons.star_sharp,
        color: Colors.white,
        size: 45,
      );

      final lablewidget = LableWidget(
        text: "Frame",
        color1: Colors.lightBlue.shade300,
        color2: Colors.blue.shade800,
        icon: icon,
      );
      final lablewidget2 = LableWidget(
        text: "Album",
        color1: Colors.pink.shade600,
        color2: const Color.fromARGB(255, 251, 71, 248),
        icon: icon1,
      );

      final lablewidget3 = LableWidget(
        text: "Rate",
        color1: Colors.orange,
        color2: Colors.yellow.shade700,
        icon: icon2,
      );
      final childWidget1 = InkWell(
        onTap: () async {
          build(BuildContext context) {
            Navigator.of(context).pushNamed("select_frame");
          }
        },
        child: lablewidget,
      );
      final childWidget2 = InkWell(
        onTap: () async {
          build(BuildContext context) {
            Navigator.of(context).pushNamed("select_frame");
          }
        },
        child: lablewidget2,
      );
      final childWidget3 = InkWell(
        onTap: () async {
          build(BuildContext context) {
            Navigator.of(context).pushNamed("select_frame");
          }
        },
        child: lablewidget3,
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  childWidget1,
                  childWidget2,
                  childWidget3,
                ],
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byIcon(Icons.filter_frames));
      await tester.tap(find.byIcon(Icons.photo));
      await tester.tap(find.byIcon(Icons.star_sharp));
      await tester.pump();
      expect(find.byWidget(childWidget1), findsOneWidget);
      expect(find.byWidget(childWidget2), findsOneWidget);
      expect(find.byWidget(childWidget3), findsOneWidget);
      expect(find.byWidget(lablewidget), findsOneWidget);
      expect(find.byWidget(lablewidget3), findsOneWidget);
      expect(find.byWidget(lablewidget2), findsOneWidget);
      expect(find.byWidget(icon), findsOneWidget);
      expect(find.byWidget(icon1), findsOneWidget);
      expect(find.byWidget(icon2), findsOneWidget);
    });
  });

  group("Settings screen", () {
    testWidgets('add photo widget', (tester) async {
      final center = find.byKey(const ValueKey("center"));
      final column = find.byKey(const ValueKey("column"));
      final inkwell = find.byKey(const ValueKey("inkwell"));
      final circleavtar = find.byKey(const ValueKey("circle avtar"));
      final icon = find.byKey(const ValueKey("icon"));
      final text = find.byKey(const ValueKey("text"));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              key: const ValueKey("center"),
              child: Column(
                key: const ValueKey("column"),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    key: const ValueKey("inkwell"),
                    onTap: () {
                      build(BuildContext context) {
                        Navigator.of(context).pushNamed("imagepage");
                      }
                    },
                    child: const CircleAvatar(
                      key: ValueKey("circle avtar"),
                      radius: 50,
                      child: Icon(
                        key: ValueKey("icon"),
                        Icons.add,
                        size: 70,
                      ),
                    ),
                  ),
                  const Text(
                    "Tap to select image",
                    key: ValueKey("text"),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(center, findsOneWidget);
      expect(column, findsOneWidget);
      expect(inkwell, findsOneWidget);
      expect(circleavtar, findsOneWidget);
      expect(icon, findsOneWidget);
      expect(text, findsOneWidget);
    });
    testWidgets('single child scroll widget', (tester) async {
      final scroll = find.byKey(const ValueKey("scroll"));

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              key: ValueKey("scroll"),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(scroll, findsOneWidget);
    });
    testWidgets('slider lable widgets', (tester) async {
      final scroll = find.byKey(const ValueKey("scroll"));
      final controller = ScreenshotController();
      const text1 = Text(
        "Low",
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      );
      const text2 = Text(
        "medium",
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      );
      const text3 = Text(
        "high",
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      );

      final row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          text1,
          text2,
          text3,
        ],
      );
      final column = Column(
        children: [
          row,
        ],
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              key: const ValueKey("scroll"),
              child: column,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(scroll, findsOneWidget);
      expect(find.byWidget(column), findsOneWidget);
      expect(find.byWidget(row), findsOneWidget);
      expect(find.byWidget(text1), findsOneWidget);
      expect(find.byWidget(text2), findsOneWidget);
      expect(find.byWidget(text3), findsOneWidget);
    });
    testWidgets('screenshot widget', (tester) async {
      final scroll = find.byKey(const ValueKey("scroll"));
      final controller = ScreenshotController();
      final image = Image.asset(
        "assets/images/m1.png",
        filterQuality: FilterQuality.high,
      );
      final sizedbox = SizedBox(
        width: 400,
        height: 500,
        child: image,
      );

      final screenshot = Screenshot(
        controller: controller,
        child: InteractiveViewer(
          child: sizedbox,
        ),
      );
      final column = Column(
        children: [
          screenshot,
        ],
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              key: const ValueKey("scroll"),
              child: column,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(scroll, findsOneWidget);
      expect(find.byWidget(column), findsOneWidget);
      expect(find.byWidget(screenshot), findsOneWidget);
      expect(find.byWidget(sizedbox), findsOneWidget);
      expect(find.byWidget(image), findsOneWidget);
    });

    testWidgets('slider widget', (tester) async {
      int _value = 20;
      final slider = Slider(
        value: _value.toDouble(),
        min: 0,
        max: 100.0,
        divisions: 100,
        label: "$_value",
        semanticFormatterCallback: (double newValue) {
          return '${newValue.round()} ';
        },
        onChanged: (double value) {},
      );

      final column = Column(
        children: [
          slider,
        ],
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              key: const ValueKey("scroll"),
              child: column,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byWidget(column), findsOneWidget);
      expect(find.byWidget(slider), findsOneWidget);
    });
  });
  group("set image page", () {
    testWidgets('all widget in set image page', (tester) async {
      final image = Image.asset("assets/images/m1.png");
      final sizedbox = SizedBox(
        height: 400,
        child: image,
      );
      const text1 = Text("crop image");
      final elevatedbutton1 = ElevatedButton(
        onPressed: () {},
        child: text1,
      );
      const text2 = Text("Add Frame");
      final elevatedbutton2 = ElevatedButton(
        onPressed: () {
          build(BuildContext context) {
            Navigator.of(context).pushNamed(
              "frames",
            );
          }
        },
        child: text2,
      );
      final row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          elevatedbutton1,
          elevatedbutton2,
        ],
      );
      final container = Container(
        height: 50,
        width: 400,
        color: Colors.grey,
        child: row,
      );

      final column = Column(
        children: [
          sizedbox,
          container,
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: column,
          ),
        ),
      );
      await tester.pump();
      expect(find.byWidget(column), findsOneWidget);
      expect(find.byWidget(sizedbox), findsOneWidget);
      expect(find.byWidget(image), findsOneWidget);
      expect(find.byWidget(container), findsOneWidget);
      expect(find.byWidget(row), findsOneWidget);
      expect(find.byWidget(elevatedbutton1), findsOneWidget);
      expect(find.byWidget(elevatedbutton2), findsOneWidget);
      expect(find.byWidget(text1), findsOneWidget);
      expect(find.byWidget(text2), findsOneWidget);
    });
  });

  group("frames", () {
    testWidgets('all widget', (tester) async {
      final card2 = Card(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/m1.png",
              ),
            ),
          ),
        ),
      );

      final inkwell = InkWell(
        onTap: () {
          build(BuildContext context) {
            Navigator.of(context).pushNamed(
              "framepage",
            );
          }
        },
        child: card2,
      );
      final card1 = Card(
        elevation: 2,
        child: inkwell,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: card1,
          ),
        ),
      );
      await tester.pump(
        const Duration(seconds: 5),
      );
      expect(find.byWidget(card1), findsOneWidget);
      expect(find.byWidget(card2), findsOneWidget);
      expect(find.byWidget(inkwell), findsOneWidget);
    });
  });

  group("Story page", () {
    testWidgets('My widget test', (tester) async {
      final myWidget = find.byType(AlbumPage);

      final image = Image.asset("assets/images/m1.png");

      final sizedbox = SizedBox(
        height: 300,
        width: 300,
        child: image,
      );
      final button = find.widgetWithText(ElevatedButton, "Delete");

      final button2 = find.widgetWithText(OutlinedButton, "Close");
      Future<List<Storage>>? fetchdata;
      final futurewidget = FutureBuilder(
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
                                    fetchdata =
                                        DBHelper.dbHelper.fetchAllData();
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
                      Navigator.of(context).pushNamed(
                        "setting",
                        arguments: data[i].image,
                      );
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
      );
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: futurewidget,
            ),
          ),
        );
      });

      await tester.pump();

      expect(find.byWidget(futurewidget), findsOneWidget);
    });
  });

  group("select frame", () {
    testWidgets('find all widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SelectFrame(),
        ),
      );
      await tester.pump();
      final text = find.byType(
        Text,
      );
      final column = find.byType(
        Column,
      );
      final sizedbox = find.byType(SizedBox);
      final expanded = find.byType(Expanded);
      final gesture = find.byType(GestureDetector);
      final stack = find.byType(Stack);

      expect(text, findsWidgets);
      expect(column, findsWidgets);
      expect(sizedbox, findsWidgets);
      expect(expanded, findsWidgets);
      expect(gesture, findsWidgets);
      expect(stack, findsWidgets);
    });
  });

  group('sticker page', () {
    testWidgets('Sticker Screen Testing', (tester) async {
      StickIt _stickIt = StickIt(
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
        ],
        child: Container(),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: _stickIt,
          ),
        ),
      );
      await tester.pump();
      expect(find.byWidget(_stickIt), findsWidgets);
    });
  });
}
