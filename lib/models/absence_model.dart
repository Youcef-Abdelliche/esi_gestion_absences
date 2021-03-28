import 'dart:convert';

import 'package:esi_gabsence/models/student.dart';

class Absence {
  String date;
  String time;
  String module;
  Student student;
  Absence({
     this.date,
     this.time,
     this.module,
     this.student,
  });

  

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'time': time,
      'module': module,
      'student': student.toMap(),
    };
  }

  factory Absence.fromMap(Map<String, dynamic> map) {
    return Absence(
      date: map['date'],
      time: map['time'],
      module: map['module'],
      //student: Student.fromMap(map['student']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Absence.fromJson(String source) => Absence.fromMap(json.decode(source));
}
