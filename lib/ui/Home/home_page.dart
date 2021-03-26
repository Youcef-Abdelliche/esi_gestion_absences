import 'package:esi_gabsence/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var email;
  @override
  void initState() {
    super.initState();
    var user = FirebaseAuth.instanceFor(app: Firebase.app()).currentUser;
    if (user != null) {
      email = user.email;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(email ?? "Nothing")),
          TextButton(
            child: Text("Logout"),
            onPressed: () {
              FirebaseService().signOut();
            },
          )
        ],
      ),
    );
  }
}
