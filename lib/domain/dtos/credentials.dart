import 'dart:convert';

class Credentials {
  String email;
  String password;
  String? name;
  DateTime? birthDate;

  Credentials({
    this.name,
    this.email = '',
    this.password = '',
    this.birthDate,
  });

  void setEmail(String email) {
    this.email = email;
  }

  void setPassword(String password) {
    this.password = password;
  }

  void setName(String name) {
    this.name = name;
  }

  void setBirthDate(DateTime birthDate) {
    this.birthDate = birthDate;
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'birthDate': birthDate?.millisecondsSinceEpoch,
    };
  }

  factory Credentials.fromMap(Map<String, dynamic> map) {
    return Credentials(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'],
      birthDate: map['birthDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Credentials.fromJson(String source) =>
      Credentials.fromMap(json.decode(source));
}
