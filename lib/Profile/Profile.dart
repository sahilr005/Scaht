import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disagn/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image;
  var imglink;
  Future getImage() async {
    _image = await ImagePicker.pickImage(source: ImageSource.gallery);
    FirebaseStorage fs = FirebaseStorage.instance;
    Reference rootref = fs.ref();
    Reference picther = rootref.child(userinifomain.uid);
    picther.putFile(_image).then((value) async {
      String link = await value.ref.getDownloadURL();
      setState(() {
        imglink = link;
        updateUser();
      });
    });
  }

  Future<void> updateUser() {
    print('goo');
    return FirebaseFirestore.instance
        .collection('mainscreen')
        .doc(userinifomain.uid)
        .update({'photo': imglink})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage().whenComplete(() => () {
                if (this.mounted) {
                  setState(() {});
                }
              });
        },
        tooltip: 'Change Photo',
        backgroundColor: Colors.teal,
        child: Icon(Icons.add_a_photo),
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Center(
              child: Text(
                userinifomain.name,
                style:
                    GoogleFonts.montserrat(color: Colors.white70, fontSize: 30),
              ),
            ),
          ),
          CircleAvatar(
            minRadius: 100,
            maxRadius: 100,
            backgroundImage: NetworkImage(userinifomain.photo),
          ),
        ],
      ),
    );
  }
}
