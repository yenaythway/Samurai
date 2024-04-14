import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  final String email;
  final String uid;
  final String passowrd;
  UserData({
    required this.email,
    required this.passowrd,
    required this.uid,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        passowrd: json["password"],
        email: json["email"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": passowrd,
        "uid": uid,
      };
}
