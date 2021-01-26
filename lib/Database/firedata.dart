import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disagn/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

void adduser({useremail, name, userphoto, phoneno, useruid}) async {
  await firestore.collection('User').doc(useremail).set({
    "Name": name,
    "email": useremail,
    "photo": userphoto,
    "phoneNo": phoneno,
    "uid": useruid,
    "chattingWith": null,
  });
}

class UserInfo1 {
  var name;
  var photo;
  var email;
  var uid;
  var postno;

  UserInfo1() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      name = user.displayName;
      photo = user.photoURL;
      email = user.email;
      uid = user.uid;
    });
   
  }
}

void messageSend({message, peerid, mtime, uid, recuid, docref}) async {
  var docref = FirebaseFirestore.instance
      .collection('message')
      .doc(peerid)
      .collection(peerid)
      .doc(DateTime.now().millisecondsSinceEpoch.toString());

  try {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(docref, {
        "idFrom": uid,
        "idTo": recuid,
        "read": "No",
        "peerid": peerid,
        "timestemp": mtime,
        "Message": message
        // 'playerID': token
      });
    });
  } on Exception catch (e) {
    print('send data erros');
  }
}

class Daata {
  // var curuid = userinifomain.uid;
  // var disName = userinifomain.name;
  SharedPreferences preferences;

  void setData({snap, reciverid}) async {
    preferences = await SharedPreferences.getInstance();
    // if (curuid.hashCode <= reciverid.hashCode) {
    //   chatid = '$curuid-$reciverid';
    // } else {
    //   chatid = '$reciverid-$curuid';
    // }
    var docref = FirebaseFirestore.instance
        .collection('mainscreen')
        .doc(userinifomain.uid.toString())
        .collection(userinifomain.name.toString())
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(docref, {
        "idFrom": userinifomain.name.toString(),
        "idTo": snap.id.toString(),
        "recName": snap.data()['Name'].toString(),
        "about": snap.data()['About'] == null
            ? "Friends"
            : snap.data()['About'].toString(),
        "photo": snap.data()['photo'].toString(),
        "read": "No",
        'playerID': snap.data()['playerID'].toString(),
        "timestemp": DateTime.now().millisecondsSinceEpoch.toString(),
      });
    });

    var recobj = FirebaseFirestore.instance
        .collection('mainscreen')
        .doc(snap.id.toString())
        .collection(snap.data()['Name'].toString())
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(recobj, {
        "idTo": userinifomain.uid.toString(),
        "recName": userinifomain.name.toString(),
        "about": 'set About..',
        "photo": userinifomain.photo,
        'playerID': userinifomain.uid,
        "timestemp": DateTime.now().millisecondsSinceEpoch.toString(),
      });
    });
  }
}
