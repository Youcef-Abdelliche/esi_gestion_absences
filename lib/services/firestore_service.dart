import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esi_gabsence/models/meeting.dart';
import 'package:esi_gabsence/models/student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class FiretoreService {
  final firestoreInstance = FirebaseFirestore.instance;
  //final _firebaseAuth = FirebaseAuth.instanceFor(app: Firebase.app());

  Future<List<Meeting>> getTodayMeeting(String email, DateTime dateTime) async {
    String todayDate = dateTime.year.toString() +
        "-" +
        dateTime.month.toString() +
        "-" +
        dateTime.day.toString();

    var user = FirebaseAuth.instanceFor(app: Firebase.app()).currentUser;
    assert(user != null);

    CollectionReference seances =
        FirebaseFirestore.instance.collection('seances2021');
    DocumentSnapshot documentSnapshot = await seances.doc(todayDate).get();
    List<dynamic> list = documentSnapshot.data()["seances"];
    List<Meeting> meetings = [];
    list.forEach((element) {
      Meeting meeting = Meeting.fromMap(element);
      if (user.uid == meeting.ensid) {
        meetings.add(meeting);
      }
    });
    return meetings;
  }

  Future<List<Student>> getStudentsByPromoGroupe(
      String promo, String groupe) async {
    CollectionReference etudiants =
        FirebaseFirestore.instance.collection('etudiants');

    List<Student> students = [];
    await etudiants.get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        Student student = Student.fromMap(element.data());
        if (student.groupe == groupe && student.promo == promo) {
          students.add(student);
        }
      });
    });
    return students;
  }

  Future<String> signaleAbsents(
      List<Student> students, Meeting meeting, DateTime dateTime) async {
    String todayDate = dateTime.year.toString() +
        "-" +
        dateTime.month.toString() +
        "-" +
        dateTime.day.toString();
    var user = FirebaseAuth.instanceFor(app: Firebase.app()).currentUser;
    assert(user != null);

    if (students.isNotEmpty) {
      CollectionReference absences =
          FirebaseFirestore.instance.collection('absences');
      students.forEach((element) async {
        await absences.add({
          "date": todayDate,
          "time": meeting.time,
          "module": meeting.module,
          "etudiant": {
            "nom": element.nom,
            'prenom': element.prenom,
            'email': element.email,
            "promo": meeting.promo,
            'groupe': element.groupe,
          },
        });
      });
      return "${students.length} etudiants sont absents";
    } else {
      return "Il n'y a pas des absences";
    }
  }

  Future<List<bool>> getAbsentsStudents(
      DateTime dateTime, Meeting meeting, List<Student> students) async {
    CollectionReference absences =
        FirebaseFirestore.instance.collection('absences');
    String todayDate = dateTime.year.toString() +
        "-" +
        dateTime.month.toString() +
        "-" +
        dateTime.day.toString();
    List<Student> absentsStudents = [];
    List<bool> absentsss = [];
    if (meeting.absence) {
      await absences.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          if (todayDate == element.data()['date']) {
            Student student = Student.fromMap(element.data()['etudiant']);
            if (meeting.groupe == student.groupe &&
                meeting.promo == student.promo) absentsStudents.add(student);
          }
        });
      });
      students.forEach((element) {
        absentsss.add(contains(element, absentsStudents));
      });
    }
    return absentsss;
  }
}

bool contains(Student element, List<Student> students) {
  for (int index = 0; index < students.length; index++) {
    if (students[index].email == element.email) {
      return true;
    }
    break;
  }

  return false;
}
