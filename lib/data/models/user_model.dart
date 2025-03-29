import 'dart:convert';

class UserModel {
  String id;
  String name;
  String email;
  DateTime birthDate;
  String profilepic;
  String qrcode;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.birthDate,
    required this.profilepic,
    required this.qrcode,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    DateTime? birthDate,
    String? profilepic,
    String? qrcode,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      profilepic: profilepic ?? this.profilepic,
      qrcode: qrcode ?? this.qrcode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'birthDate': birthDate.millisecondsSinceEpoch,
      'profilepic': profilepic,
      'qrcode': qrcode,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      birthDate: DateTime.parse(map['birthDate']),
      profilepic: map['profilepic'] ?? '',
      qrcode: map['qrcode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, birthDate: $birthDate, profilepic: $profilepic, qrcode: $qrcode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.birthDate == birthDate &&
        other.profilepic == profilepic &&
        other.qrcode == qrcode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        birthDate.hashCode ^
        profilepic.hashCode ^
        qrcode.hashCode;
  }

  static final empty = UserModel(
      id: '',
      name: '',
      email: '',
      birthDate: DateTime(2000),
      profilepic: '',
      qrcode: '');
}
