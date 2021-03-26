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
      // TODO: implement initState
      super.initState();
      var user = FirebaseAuth.instanceFor(app: Firebase.app()).currentUser;
      if(user != null) {
          email = user.email;
      }else{

      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(email??"Nothing"),
      ),
    );
  }
}