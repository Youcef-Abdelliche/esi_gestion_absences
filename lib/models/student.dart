import 'dart:convert';

class Student {

  String nom;
  String prenom;
  String email;
  String promo;
  String groupe;
  Student({
     this.nom,
     this.prenom,
     this.email,
     this.promo,
     this.groupe,
  });

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'groupe': groupe,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
      promo: map['promo'],
      groupe: map['groupe'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) => Student.fromMap(json.decode(source));
}
