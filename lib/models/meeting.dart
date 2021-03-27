import 'dart:convert';

class Meeting {
  String ensid;
  String groupe;
  String promo;
  String module;
  String time;
  Meeting({
    this.ensid,
    this.groupe,
    this.promo,
    this.module,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'ensid': ensid,
      'groupe': groupe,
      'promo': promo,
      'module': module,
      'time': time,
    };
  }

  factory Meeting.fromMap(Map<String, dynamic> map) {
    return Meeting(
      ensid: map['ensid'],
      groupe: map['groupe'],
      promo: map['promo'],
      module: map['module'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Meeting.fromJson(String source) => Meeting.fromMap(json.decode(source));
}
