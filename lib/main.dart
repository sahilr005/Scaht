import 'package:disagn/Database/firedata.dart';
import 'package:disagn/Splech.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

var box;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // box = await Hive.box('SchatS');
  runApp(MyApp());
}

UserInfo1 userinifomain;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schats',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        brightness: Brightness.dark,
        primaryColorDark: Colors.black,
        dialogBackgroundColor: Colors.black54,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splechscreen(),
    );
  }
}

