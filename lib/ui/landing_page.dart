import 'package:esi_gabsence/ui/Auth/login_page.dart';
import 'package:esi_gabsence/ui/Home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User>(
        stream:
            FirebaseAuth.instanceFor(app: Firebase.app()).authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return LoginPage();
            }
            return HomePage();
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF03045E), Color(0xFF023e8a)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  color: Color(0xFF03045E)),
              child: Image.asset("assets/images/esi_logo.png"),
            );
          }
        },
      ),
    );
  }
}

/** */