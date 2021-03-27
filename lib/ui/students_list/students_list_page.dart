import 'package:esi_gabsence/models/meeting.dart';
import 'package:esi_gabsence/models/student.dart';
import 'package:esi_gabsence/services/firebase_auth_service_.dart';
import 'package:esi_gabsence/services/firestore_service.dart';
import 'package:flutter/material.dart';

class StudentsListPage extends StatefulWidget {
  final String title;
  final String dateTime;
  final Meeting meeting;
  const StudentsListPage(
      {Key key,
      @required this.meeting,
      @required this.dateTime,
      @required this.title})
      : super(key: key);

  @override
  _StudentsListPageState createState() => _StudentsListPageState();
}

class _StudentsListPageState extends State<StudentsListPage> {
  List<Student> students = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FiretoreService()
        .getStudentsByPromoGroupe(widget.meeting.promo, widget.meeting.groupe)
        .then((value) {
      setState(() {
        students = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Text(
              widget.dateTime,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          Expanded(
              flex: 2,
              child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return StudentItem(
                      name: students[index].nom+" "+students[index].prenom,
                    );
                  })),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.red),
            child: Text(
              "Signaler",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class StudentItem extends StatelessWidget {
  final String name;
  final int index;
  const StudentItem({
    this.name,
    this.index,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF023e8a)),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
        child: CheckboxListTile(
          value: false,
          title: Text(
            name,
            style: TextStyle(fontSize: 20, color: Color(0xFF023e8a)),
          ),
          onChanged: (value) {},
        ));
  }
}

List<String> list = [
  "Abdelliche Youcef",
  "Kati Kousseila",
  "Kecharoui haroune",
  "Bacha Ilyes",
  "Ali Arous Mostefa",
  "Ferhat Chala",
  "Khorsi Zizou",
  "Bouaba Saloua",
  "Zakia Yanes",
];

List<bool> list2 = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
];
