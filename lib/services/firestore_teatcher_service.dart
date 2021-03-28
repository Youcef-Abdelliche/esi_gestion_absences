import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esi_gabsence/models/meeting.dart';
import 'package:esi_gabsence/models/student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FiretoreTeacherService {
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
    List<Meeting> meetings = [];
    await seances.get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        Meeting meeting = Meeting.fromMap(element.data());
        meeting.meetingId = element.id;
        if (user.uid == meeting.ensid && meeting.date == todayDate) {
          meetings.add(meeting);
        }
      });
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
      CollectionReference seances =
          FirebaseFirestore.instance.collection('seances2021');
      await seances.doc(meeting.meetingId).update({'absence': true});
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
