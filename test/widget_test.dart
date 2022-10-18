
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
