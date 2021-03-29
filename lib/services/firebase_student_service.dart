import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esi_gabsence/models/absence_model.dart';
import 'package:esi_gabsence/models/student.dart';
import 'package:esi_gabsence/ui/students_list/students_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseStudentService {
  final firestoreInstance = FirebaseFirestore.instance;

  Future<List<Absence>> getAbsences() async {
    CollectionReference absences =
        FirebaseFirestore.instance.collection('absences');
    var user = FirebaseAuth.instanceFor(app: Firebase.app()).currentUser;
    assert(user != null);

    List<Absence> listAbsents = [];
    await absences.get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        Absence absence = Absence.fromMap(element.data());
        absence.student = Student.fromMap(element['etudiant']);

        if (absence.student.email == user.email) {
          print(absence.module + " " + absence.date);
          listAbsents.add(absence);
        }
      });
    });

    return listAbsents;
  }

  Future<List<dynamic>> getNbrAbsentsByModule() async {
    List<Absence> absences = await getAbsences();
    List<Absence> list = await getAbsences();
    List<dynamic> absentsByModule = [];

    absences.forEach((element) {
      if (!(absentsByModule.length != 0 &&
          contains(absentsByModule, element))) {
        final module = element.module;
        final nbr = list
            .where((element2) => element2.module == element.module)
            .toList()
            .length;
        absentsByModule.add({"module": module, "nbr": nbr});
      }
    });

    return absentsByModule;
  }
}

bool contains(List<dynamic> list, Absence absence) {
  for (int index = 0; index < list.length; index++) {
    if (list[index]["module"] == absence.module) return true;
    break;
  }
  return false;
}
