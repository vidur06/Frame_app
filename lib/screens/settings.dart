
import 'package:festival_frame/widgets/rate_dialog.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  int _value = 20;
  Uint8List? result;
  @override
  void initState() {
    super.initState();
    navigatorObservers:
    [FirebaseAnalyticsObserver(analytics: analytics)];
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Settings",
          key: ValueKey('appbar text'),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.compress),
            title: const Text('Compress Image'),
            textColor: Colors.black,
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
            onTap: () async {
                Navigator.of(context).pushNamed(
                  'imagepage',
                  arguments: ['Yes'],
                );
            },
          ),
          Divider(
            color: Colors.black,
            height: 2,
            indent: width * 0.03,
            endIndent: width * 0.03,
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Abouts'),
            textColor: Colors.black,
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
            onTap: () {
              Navigator.of(context).pushNamed('about_app');
            },
          ),
          Divider(
            color: Colors.black,
            height: 2,
            indent: width * 0.03,
            endIndent: width * 0.03,
          ),
          ListTile(
            leading: const Icon(Icons.rate_review),
            title: const Text('Rate'),
            textColor: Colors.black,
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
            onTap: () {
              showDialog(context: context, builder: (context) => const RateDialog());
            },
          ),
          Divider(
            color: Colors.black,
            height: 2,
            indent: width * 0.03,
            endIndent: width * 0.03,
          ),
        ],
      ),
    );
  }
}
