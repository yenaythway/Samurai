import 'dart:convert';

import 'package:real_time_chatting/Models/user.dart';

UsersModel usersModelFromJson(String str) =>
    UsersModel.fromJson(json.decode(str));

String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  final String path;
  final String uri;
  final int timestamp;
  final List<User> entities;
  final int count;
  final String action;
  final int duration;

  UsersModel({
    required this.path,
    required this.uri,
    required this.timestamp,
    required this.entities,
    required this.count,
    required this.action,
    required this.duration,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        path: json["path"],
        uri: json["uri"],
        timestamp: json["timestamp"],
        entities:
            List<User>.from(json["entities"].map((x) => User.fromJson(x))),
        count: json["count"],
        action: json["action"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "uri": uri,
        "timestamp": timestamp,
        "entities": List<User>.from(entities.map((x) => x.toJson())),
        "count": count,
        "action": action,
        "duration": duration,
      };
}
