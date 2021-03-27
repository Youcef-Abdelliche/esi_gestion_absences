import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esi_gabsence/models/meeting.dart';
import 'package:esi_gabsence/services/firebase_auth_service_.dart';
import 'package:esi_gabsence/services/firestore_service.dart';
import 'package:esi_gabsence/ui/students_list/students_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var email;
  var date = "Monday";
  List<Meeting> meetings = [];

  @override
  void initState() {
    super.initState();
    var user = FirebaseAuth.instanceFor(app: Firebase.app()).currentUser;
    if (user != null) {
      email = user.email;
    } else {}

    FiretoreService().getTodayMeeting(email, DateTime.now()).then((value) {
      setState(() {
        meetings = value;
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(email ?? "Nothing"),
        actions: [
          TextButton(
            child: Text("Logout"),
            onPressed: () {
              FirebaseService().signOut();
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Text(
              days[DateFormat('EEEE').format(DateTime.now())] +
                  ", " +
                  DateTime.now().day.toString() +
                  " " +
                  months[DateTime.now().month],
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          Expanded(
              flex: 2,
              child: ListView.builder(
                  itemCount: meetings.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentsListPage(
                                  meeting: meetings[index],
                                      title: "2ST A G04",
                                      dateTime:
                                          "Jeudi, 25 février . 3:00 à 4:00pm",
                                    )),
                          );
                        },
                        child: ItemMeeting(
                          title: meetings[index].module.toUpperCase(),
                          dateTime: meetings[index].time,
                        ));
                  })),
        ],
      ),
    );
  }
}

class ItemMeeting extends StatelessWidget {
  final String title;
  final String dateTime;
  const ItemMeeting({
    this.title,
    this.dateTime,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Color(0xFF03045E), Color(0xFF023e8a)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              Text(
                dateTime,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
          IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
    );
  }
}

Map<String, String> days = {
  'Monday': "Lundi",
  'Tuesday': "Mardi",
  'Wednesday': "Mercredi",
  'Thursday': "Jeudi",
  'Friday': "Vendredi",
  'Saturday': "Samedi",
  'Sunday': "Dimanche"
};

List<String> months = [
  "janvier",
  "férier",
  "mars",
  "avril",
  "mai",
  "juin",
  "juillet",
  "aout",
  "séptembre",
  "octobre",
  "novembre",
  "décembre"
];

/** */