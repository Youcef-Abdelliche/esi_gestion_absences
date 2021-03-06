import 'package:esi_gabsence/services/firebase_auth_service_.dart';
import 'package:esi_gabsence/services/shared_preference_service.dart';
import 'package:flutter/material.dart';

import 'components/google_connect_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isStudent = false;
  bool isTeacher = false;
  String role = "empty";

  Future<void> _signInWithGoogle() async {
    try {
      await FirebaseService().signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF03045E), Color(0xFF023e8a)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                color: Color(0xFF03045E)),
            child: Column(
              children: [
                Image.asset("assets/images/esi_logo.png"),
                SizedBox(height: 30),
                Text(
                  "Ecole Nationale Supérieure d'Informatique (ESI) a comme principale mission la formation en graduation d’ingénieur d’état en informatique.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(6),
              height: MediaQuery.of(context).size.height * 1 / 3,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  Text(
                    "Vous êtes ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF03045E),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _pageController,
                      physics: isStudent || isTeacher
                          ? null
                          : NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    margin: EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text("Etudiant",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: isStudent
                                                ? Colors.white
                                                : Color(0xFF03045E),
                                          )),
                                    ),
                                    decoration: BoxDecoration(
                                        color: isStudent
                                            ? Color(0xFF03045E)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          )
                                        ]),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      isStudent = true;
                                      isTeacher = false;
                                    });
                                    SharedPreferenceService()
                                        .setUserRole("etudiant");
                                    _pageController.nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeIn);
                                  },
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    margin: EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text("Enseigant",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: isTeacher
                                                ? Colors.white
                                                : Color(0xFF03045E),
                                          )),
                                    ),
                                    decoration: BoxDecoration(
                                        color: isTeacher
                                            ? Color(0xFF03045E)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          )
                                        ]),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      isStudent = false;
                                      isTeacher = true;
                                    });
                                    SharedPreferenceService()
                                        .setUserRole("enseignant");
                                    _pageController.nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeIn);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        GoogleConnectWidget(
                          funtion: () {
                            _signInWithGoogle();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
