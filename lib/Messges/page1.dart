import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disagn/Messges/Page2.dart';
import 'package:disagn/main.dart';
import 'package:disagn/screen/Activite.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Messagespage extends StatefulWidget {
  @override
  _MessagespageState createState() => _MessagespageState();
}

class _MessagespageState extends State<Messagespage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Activite(),
            Activite(),
          ],
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('mainscreen')
                .doc(userinifomain.uid)
                .collection(userinifomain.name)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return CircularProgressIndicator();
              }

              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, index) {
                  DocumentSnapshot snap = snapshot.data.docs[index];
                  var timedate = "10-03-21";
                  if (box == null) {
                    CircularProgressIndicator();
                  }
                  if (box.toMap().containsValue(snap.data()['idTo'])) {
                    print('@Uuu NOt Addded');
                  } else {
                    print('@Uuu addded');
                    box.add(snap.data()['idTo']);
                  }
                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (a) => ChatPage2(),
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (a) => ChatPage2(
                              image: snap.data()['photo'],
                              lasttime: "2 min",
                              name: snap.data()['idFrom'],
                              userid: snap.data()['playerID'],
                            ),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(
                          snap.data()['photo'],
                        ),
                      ),
                      title: Text(
                        snap.data()['recName'],
                        style: GoogleFonts.abel(
                            color: Colors.white70,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        snap.data()['about'],
                        style: GoogleFonts.abel(
                            fontSize: 12, color: Colors.white70),
                      ),
                      trailing: Column(
                        children: [
                          Text(
                            timedate.toString(),
                            style: GoogleFonts.abel(
                                color: Colors.grey, fontSize: 12),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.yellow[900],
                            radius: 10,
                            child: Text(
                              '2',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            })
      ],
    );
  }
}
