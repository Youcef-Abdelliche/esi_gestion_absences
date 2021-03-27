import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esi_gabsence/models/meeting.dart';
import 'package:esi_gabsence/models/student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FiretoreService {
  final firestoreInstance = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instanceFor(app: Firebase.app());

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

  Future<List<Student>> getStudentsByPromoGroupe(String promo, String groupe) async {
    CollectionReference etudiants =
        FirebaseFirestore.instance.collection('etudiants'+promo);

    List<Student> students = [];
    await etudiants.get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        Student student = Student.fromMap(element.data());
        if(student.groupe == groupe){
          students.add(student);
        }
       });
    });
    return students;
  }
}
