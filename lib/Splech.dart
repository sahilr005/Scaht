import 'dart:async';

import 'package:disagn/Login/loginPage.dart';
import 'package:disagn/firestpage/Scerren1.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class Splechscreen extends StatefulWidget {
  @override
  _SplechscreenState createState() => _SplechscreenState();
}

class _SplechscreenState extends State<Splechscreen> {
  SharedPreferences _preferences;
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (a) => Screen1()));
    } else {
      Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage1()))
          .then((value) => {
                prefs.setBool('seen', true),
              });
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // initPlatformState();
  // }

  Future openBOx() async {
    setState(() {});
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('SchatS');
    return;
  }

  // Future<void> initPlatformState() async {
  // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  // OneSignal.shared.init("b7f8c97a-8029-47be-8058-26365eed17e4", iOSSettings: {
  //   OSiOSSettings.autoPrompt: false,
  //   OSiOSSettings.inAppLaunchUrl: false
  // });
  // OneSignal.shared
  //     .setInFocusDisplayType(OSNotificationDisplayType.notification);
  // }

  @override
  void initState() {
    openBOx();

    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (a) => LoginPage1(),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/f1.jpg'),
        ),
      ),
    );
  }
}
