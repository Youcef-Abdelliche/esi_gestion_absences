import 'package:esi_gabsence/models/absence_model.dart';
import 'package:esi_gabsence/services/firebase_student_service.dart';
import 'package:esi_gabsence/ui/Home/components/item_meeting.dart';
import 'package:esi_gabsence/ui/justification_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class StudentHomePage extends StatefulWidget {
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  String name;
  List<Absence> absences = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var user = FirebaseAuth.instanceFor(app: Firebase.app()).currentUser;
    if (user != null) {
      name = user.displayName;
    } else {}

    FirebaseStudentService().getAbsences().then((value) {
      setState(() {
        absences = value;
      });
    });
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
                itemCount: absences.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: ItemMeeting(
                      title: absences[index].module,
                      dateTime:
                          absences[index].date + " . " + absences[index].time,
                    ),
                    onTap: () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JustificationPage(
                                  absence: absences[index],
                                )),
                      );*/
                      final Email email = Email(
                        body:
                            "justification de l'absence \nModule: ${absences[index].module} \ndate:  ${absences[index].date}\n",
                        subject: "Justification",
                        recipients: ["achour@esi.dz"],
                        attachmentPaths: [],
                        isHTML: false,
                      );
                      send(email);
                    },
                  );
                }),
          )
        ],
      ),
    );
  }

  Future<void> send(Email email) async {
    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }
}
