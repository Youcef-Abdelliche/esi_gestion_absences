import 'package:esi_gabsence/models/meeting.dart';
import 'package:esi_gabsence/services/firebase_auth_service_.dart';
import 'package:esi_gabsence/services/firestore_teatcher_service.dart';
import 'package:esi_gabsence/ui/students_list/students_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'components/item_meeting.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var email;
  var date = "Monday";
  bool signal = false;
  String todayDate = days[DateFormat('EEEE').format(DateTime.now())] +
      ", " +
      DateTime.now().day.toString() +
      " " +
      months[DateTime.now().month];
  List<Meeting> meetings = [];

  @override
  void initState() {
    super.initState();
    var user = FirebaseAuth.instanceFor(app: Firebase.app()).currentUser;
    if (user != null) {
      email = user.displayName;
    } else {}

    FiretoreTeacherService()
        .getTodayMeeting(email, DateTime.now())
        .then((value) {
      setState(() {
        meetings = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(email ?? "Error"),
        backgroundColor: Color(0xFF023e8a),
        actions: [
          TextButton(
            child: Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
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
              todayDate,
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
                                      title: meetings[index].promo +
                                          " G0" +
                                          meetings[index].groupe,
                                      dateTime:
                                          "$todayDate . ${meetings[index].time}",
                                    )),
                          ).then((value) {
                            if (value != null) {
                              setState(() {
                                signal = value;
                                meetings[index].absence = signal;
                              });
                            } else {
                              meetings[index].absence = signal;
                            }
                          });
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
  "f??rier",
  "mars",
  "avril",
  "mai",
  "juin",
  "juillet",
  "aout",
  "s??ptembre",
  "octobre",
  "novembre",
  "d??cembre"
];

/** */