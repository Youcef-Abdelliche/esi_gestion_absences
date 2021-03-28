import 'dart:convert';

class Meeting {
  String meetingId;
  String ensid;
  String groupe;
  String promo;
  String module;
  String time;
  bool absence;
  String date;
  Meeting({
    this.meetingId,
    this.ensid,
    this.groupe,
    this.promo,
    this.module,
    this.time,
    this.absence,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'ensid': ensid,
      'groupe': groupe,
      'promo': promo,
      'module': module,
      'time': time,
      'absence': absence,
      'date': date,
    };
  }

  factory Meeting.fromMap(Map<String, dynamic> map) {
    return Meeting(
      ensid: map['ensid'],
      groupe: map['groupe'],
      promo: map['promo'],
      module: map['module'],
      time: map['time'],
      absence: map['absence'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Meeting.fromJson(String source) =>
      Meeting.fromMap(json.decode(source));
}
