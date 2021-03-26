import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GoogleConnectWidget extends StatelessWidget {
  final Function funtion;
  const GoogleConnectWidget({
    @required this.funtion,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        funtion();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: 100, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ]),
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SvgPicture.asset(
                    "assets/icons/google.svg", width: 30,)),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text("Sign In With Google", style: TextStyle(fontSize: 20),)),
          ],
        ),
      ),
    );
  }
}