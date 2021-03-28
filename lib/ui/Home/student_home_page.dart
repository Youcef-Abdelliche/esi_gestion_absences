import 'package:esi_gabsence/ui/Home/components/item_meeting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class StudentHomePage extends StatefulWidget {
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  String name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var user = FirebaseAuth.instanceFor(app: Firebase.app()).currentUser;
    if (user != null) {
      name = user.displayName;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name ?? "Error"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Text(
              "Mes absences:",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),

          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return ItemMeeting(title: "BDA", dateTime: "2021-3-28 . 10:00-12:00",);
              }),
          )
        ],
      ),
    );
  }
}

