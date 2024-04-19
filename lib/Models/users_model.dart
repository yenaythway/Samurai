import 'dart:convert';

UsersModel usersModelFromJson(String str) =>
    UsersModel.fromJson(json.decode(str));

String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  final String path;
  final String uri;
  final int timestamp;
  final List<Entity> entities;
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
            List<Entity>.from(json["entities"].map((x) => Entity.fromJson(x))),
        count: json["count"],
        action: json["action"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "uri": uri,
        "timestamp": timestamp,
        "entities": List<dynamic>.from(entities.map((x) => x.toJson())),
        "count": count,
        "action": action,
        "duration": duration,
      };
}

class Entity {
  final String uuid;
  final String type;
  final int created;
  final int modified;
  final String username;
  final bool activated;
  final String nickname;

  Entity({
    required this.uuid,
    required this.type,
    required this.created,
    required this.modified,
    required this.username,
    required this.activated,
    required this.nickname,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        uuid: json["uuid"],
        type: json["type"],
        created: json["created"],
        modified: json["modified"],
        username: json["username"],
        activated: json["activated"],
        nickname: json["nickname"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "type": type,
        "created": created,
        "modified": modified,
        "username": username,
        "activated": activated,
        "nickname": nickname,
      };
}
