import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String? email;
  final String? passowrd;
  final String? uuid;
  final String? type;
  final int? created;
  final int? modified;
  final String? username;
  final bool? activated;
  final String? nickname;
  User(
      {this.email,
      this.passowrd,
      this.uuid,
      this.type,
      this.created,
      this.modified,
      this.username,
      this.activated,
      this.nickname});

  factory User.fromJson(Map<String, dynamic> json) => User(
        passowrd: json["password"],
        email: json["email"],
        uuid: json["uuid"],
        type: json["type"],
        created: json["created"],
        modified: json["modified"],
        username: json["username"],
        activated: json["activated"],
        nickname: json["nickname"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": passowrd,
        "uuid": uuid,
        "type": type,
        "created": created,
        "modified": modified,
        "username": username,
        "activated": activated,
        "nickname": nickname,
      };
}
