// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:festival_frame/screens/allscreen.dart';
import 'package:festival_frame/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:festival_frame/main.dart';

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
      await tester.pump(const Duration(seconds: 5));
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
      await tester.pump();
      expect(childWidget, findsOneWidget);
      expect(childWidget1, findsOneWidget);
    });
    testWidgets('find Opacity Widget', (tester) async {
      final childWidget = find.byKey(const ValueKey("Opacity"));
      final GlobalKey<ScaffoldState> _drawerscaffoldkey =
          GlobalKey<ScaffoldState>();
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
  });
}
