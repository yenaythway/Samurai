// import 'dart:convert';

// User userFromJson(String str) => User.fromJson(json.decode(str));

// String userToJson(User data) => json.encode(data.toJson());

// class User {
//   final dynamic displayName;
//   final String email;
//   final bool isEmailVerified;
//   final bool isAnonymous;
//   final Metadata metadata;
//   final dynamic phoneNumber;
//   final dynamic photoUrl;
//   final List<ProviderDatum> providerData;
//   final dynamic refreshToken;
//   final dynamic tenantId;
//   final String uid;

//   User({
//     required this.displayName,
//     required this.email,
//     required this.isEmailVerified,
//     required this.isAnonymous,
//     required this.metadata,
//     required this.phoneNumber,
//     required this.photoUrl,
//     required this.providerData,
//     required this.refreshToken,
//     required this.tenantId,
//     required this.uid,
//   });

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         displayName: json["displayName"],
//         email: json["email"],
//         isEmailVerified: json["isEmailVerified"],
//         isAnonymous: json["isAnonymous"],
//         metadata: Metadata.fromJson(json["metadata"]),
//         phoneNumber: json["phoneNumber"],
//         photoUrl: json["photoURL"],
//         providerData: List<ProviderDatum>.from(
//             json["providerData"].map((x) => ProviderDatum.fromJson(x))),
//         refreshToken: json["refreshToken"],
//         tenantId: json["tenantId"],
//         uid: json["uid"],
//       );

//   Map<String, dynamic> toJson() => {
//         "displayName": displayName,
//         "email": email,
//         "isEmailVerified": isEmailVerified,
//         "isAnonymous": isAnonymous,
//         "metadata": metadata.toJson(),
//         "phoneNumber": phoneNumber,
//         "photoURL": photoUrl,
//         "providerData": List<dynamic>.from(providerData.map((x) => x.toJson())),
//         "refreshToken": refreshToken,
//         "tenantId": tenantId,
//         "uid": uid,
//       };
// }

// class Metadata {
//   final DateTime creationTime;
//   final DateTime lastSignInTime;

//   Metadata({
//     required this.creationTime,
//     required this.lastSignInTime,
//   });

//   factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
//         creationTime: DateTime.parse(json["creationTime"]),
//         lastSignInTime: DateTime.parse(json["lastSignInTime"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "creationTime": creationTime.toIso8601String(),
//         "lastSignInTime": lastSignInTime.toIso8601String(),
//       };
// }

// class ProviderDatum {
//   final dynamic displayName;
//   final String email;
//   final dynamic phoneNumber;
//   final dynamic photoUrl;
//   final String providerId;
//   final String uid;

//   ProviderDatum({
//     required this.displayName,
//     required this.email,
//     required this.phoneNumber,
//     required this.photoUrl,
//     required this.providerId,
//     required this.uid,
//   });

//   factory ProviderDatum.fromJson(Map<String, dynamic> json) => ProviderDatum(
//         displayName: json["displayName"],
//         email: json["email"],
//         phoneNumber: json["phoneNumber"],
//         photoUrl: json["photoURL"],
//         providerId: json["providerId"],
//         uid: json["uid"],
//       );

//   Map<String, dynamic> toJson() => {
//         "displayName": displayName,
//         "email": email,
//         "phoneNumber": phoneNumber,
//         "photoURL": photoUrl,
//         "providerId": providerId,
//         "uid": uid,
//       };
// }
