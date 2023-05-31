import 'dart:convert';

import 'package:equatable/equatable.dart';

class MessageModel extends Equatable{
  const MessageModel({
    required this.id,
    required this.fromId,
    required this.toId,
    required this.body,
    required this.read,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int fromId;
  final int toId;
  final String body;
  final int read;
  final String createdAt;
  final String updatedAt;

  MessageModel copyWith({
    int? id,
    int? fromId,
    int? toId,
    String? body,
    int? read,
    String? createdAt,
    String? updatedAt,
  }) =>
      MessageModel(
        id: id ?? this.id,
        fromId: fromId ?? this.fromId,
        toId: toId ?? this.toId,
        body: body ?? this.body,
        read: read ?? this.read,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory MessageModel.fromJson(String str) => MessageModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
    id: json["id"]  ?? 0,
    fromId: json["from_id"]  ?? 0,
    toId: json["to_id"] ?? 0,
    body: json["body"]??'',
    read: json["read"]??0,
    createdAt: json["created_at"]??'',
    updatedAt: json["updated_at"]??'',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "from_id": fromId,
    "to_id": toId,
    "body": body,
    "read": read,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };

  @override
  String toString() {
    return 'MessageModel(id: $id, from_id: $fromId, to_id: $toId, body: $body, read: $read, created_at: $createdAt, updated_at: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      fromId,
      toId,
      body,
      read,
      createdAt,
      updatedAt,
    ];
  }
}