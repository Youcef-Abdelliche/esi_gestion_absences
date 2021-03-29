import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esi_gabsence/services/shared_preference_service.dart';
import 'package:esi_gabsence/ui/Auth/login_page.dart';
import 'package:esi_gabsence/ui/Home/home_page.dart';
import 'package:esi_gabsence/ui/Home/student_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var role;
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User>(
        stream:
            FirebaseAuth.instanceFor(app: Firebase.app()).authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user != null) {
              /*return FutureBuilder(
                  future: getUserRole(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return (snapshot.data == "enseignant")
                            ? HomePage()
                            : StudentHomePage();
                      }
                    }

                    return Center(child: CircularProgressIndicator());
                  });*/

              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("roles")
                      .doc(snapshot.data.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final userDoc = snapshot.data.data();
                      if (userDoc['role'] == 'etudiant') {
                        return StudentHomePage();
                      } else {
                        return HomePage();
                      }
                    }
                    return Center(child: CircularProgressIndicator());
                  });
              //return StudentHomePage();
            } else {
              return LoginPage();
            }
          } else {
            return Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF03045E), Color(0xFF023e8a)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                    color: Color(0xFF03045E)),
                child: Image.asset("assets/images/esi_logo.png"),
              ),
            );
          }
        },
      ),
    );
  }
}

/*Future<String> getUserRole() async {
  final firestoreInstance = FirebaseFirestore.instance;
  CollectionReference role =
      FirebaseFirestore.instance.collection('etudiants');
  CollectionReference enseignants =
      FirebaseFirestore.instance.collection('enseignants');
  var user = FirebaseAuth.instanceFor(app: Firebase.app()).currentUser;
  assert(user != null);

  bool isTeacher = (await enseignants.doc(user.uid).get()).exists;

  if (isTeacher) {
    print("enseignant");
    return "enseignant";
  } else {
    isTeacher = (await students.doc(user.uid).get()).exists;
    if (isTeacher) {
      print("etudiant");
      return "etudiant";
    } else {
      print("nothing");
      return "nothing";
    }
  }
}*/

/** */