import 'package:flutter/material.dart';

class ModuleItem extends StatelessWidget {
  final String title;
  final int NbrAbsences;
  const ModuleItem({
    this.title,
    this.NbrAbsences,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/2,
      height: MediaQuery.of(context).size.height/2,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        /*gradient: LinearGradient(
          colors: [Color(0xFF03045E), Color(0xFF023e8a)],
        ),*/
        color: Colors.white,
        border: Border.all(color: Color(0xFF023e8a))
      ),
      child:  Center(
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 40, color: Color(0xFF023e8a)),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      NbrAbsences.toString(),
                      style: TextStyle(fontSize: 24, color: Color(0xFF023e8a)),
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}