import 'package:esi_gabsence/models/absence_model.dart';
import 'package:esi_gabsence/ui/Home/components/item_meeting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class JustificationPage extends StatefulWidget {
  final Absence absence;

  const JustificationPage({Key key, this.absence}) : super(key: key);

  @override
  _JustificationPageState createState() => _JustificationPageState();
}

class _JustificationPageState extends State<JustificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Justification")),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ItemMeeting(
            title: widget.absence.module,
            dateTime: widget.absence.date + " . " + widget.absence.time,
          ),
          TextButton(
            child: Text("Press"),
            onPressed: () {
              send(widget.absence.module);
            },
          )
        ],
      )),
    );
  }

  Future<void> send(String subject) async {
    final Email email = Email(
      body: "Test",
      subject: subject,
      recipients: ["recipents test"],
      attachmentPaths: [],
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }
}
