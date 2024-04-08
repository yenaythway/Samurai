import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String kind;
  final List<UserElement> users;

  User({
    required this.kind,
    required this.users,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        kind: json["kind"],
        users: List<UserElement>.from(
            json["users"].map((x) => UserElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class UserElement {
  final String localId;
  final String email;
  final String passwordHash;
  final bool emailVerified;
  final int passwordUpdatedAt;
  final List<ProviderUserInfo> providerUserInfo;
  final String validSince;
  final String lastLoginAt;
  final String createdAt;
  final DateTime lastRefreshAt;

  UserElement({
    required this.localId,
    required this.email,
    required this.passwordHash,
    required this.emailVerified,
    required this.passwordUpdatedAt,
    required this.providerUserInfo,
    required this.validSince,
    required this.lastLoginAt,
    required this.createdAt,
    required this.lastRefreshAt,
  });

  factory UserElement.fromJson(Map<String, dynamic> json) => UserElement(
        localId: json["localId"],
        email: json["email"],
        passwordHash: json["passwordHash"],
        emailVerified: json["emailVerified"],
        passwordUpdatedAt: json["passwordUpdatedAt"],
        providerUserInfo: List<ProviderUserInfo>.from(
            json["providerUserInfo"].map((x) => ProviderUserInfo.fromJson(x))),
        validSince: json["validSince"],
        lastLoginAt: json["lastLoginAt"],
        createdAt: json["createdAt"],
        lastRefreshAt: DateTime.parse(json["lastRefreshAt"]),
      );

  Map<String, dynamic> toJson() => {
        "localId": localId,
        "email": email,
        "passwordHash": passwordHash,
        "emailVerified": emailVerified,
        "passwordUpdatedAt": passwordUpdatedAt,
        "providerUserInfo":
            List<dynamic>.from(providerUserInfo.map((x) => x.toJson())),
        "validSince": validSince,
        "lastLoginAt": lastLoginAt,
        "createdAt": createdAt,
        "lastRefreshAt": lastRefreshAt.toIso8601String(),
      };
}

class ProviderUserInfo {
  final String providerId;
  final String federatedId;
  final String email;
  final String rawId;

  ProviderUserInfo({
    required this.providerId,
    required this.federatedId,
    required this.email,
    required this.rawId,
  });

  factory ProviderUserInfo.fromJson(Map<String, dynamic> json) =>
      ProviderUserInfo(
        providerId: json["providerId"],
        federatedId: json["federatedId"],
        email: json["email"],
        rawId: json["rawId"],
      );

  Map<String, dynamic> toJson() => {
        "providerId": providerId,
        "federatedId": federatedId,
        "email": email,
        "rawId": rawId,
      };
}
