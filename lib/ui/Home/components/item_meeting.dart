import 'package:flutter/material.dart';

class ItemMeeting extends StatelessWidget {
  final String title;
  final String dateTime;
  const ItemMeeting({
    this.title,
    this.dateTime,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Color(0xFF03045E), Color(0xFF023e8a)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              Text(
                dateTime,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
          IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
    );
  }
}