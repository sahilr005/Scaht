import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Activite extends StatefulWidget {
  @override
  _ActiviteState createState() => _ActiviteState();
}

class _ActiviteState extends State<Activite> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 8),
          child: Text(
            "Active",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Colors.white),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .075,
          width: MediaQuery.of(context).size.width * .2,
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.teal, width: 2.7),
            shape: BoxShape.circle,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * .07,
            width: MediaQuery.of(context).size.width * .2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/f1.jpg'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
