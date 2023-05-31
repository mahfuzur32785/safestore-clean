
import 'dart:convert';

import 'package:equatable/equatable.dart';

class City extends Equatable{
  const City({
    required this.id,
    required this.name,
    required this.slug,
    required this.countryId,
    required this.orderId,
    required this.status,
    required this.stateId,
  });

  final int id;
  final String name;
  final String slug;
  final int countryId;
  final int orderId;
  final int status;
  final int stateId;

  City copyWith({
    int? id,
    String? name,
    String? slug,
    int? countryId,
    int? orderId,
    int? status,
    int? stateId,
  }) =>
      City(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        countryId: countryId ?? this.countryId,
        orderId: orderId ?? this.orderId,
        status: status ?? this.status,
        stateId: stateId ?? this.stateId,
      );

  factory City.fromJson(String str) => City.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory City.fromMap(Map<String, dynamic> json) => City(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    slug: json["slug"] ?? '',
    countryId: json["country_id"] ?? 0,
    orderId: json["order_id"] ?? 0,
    status: json["status"] ?? 0,
    stateId: json["state_id"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "slug": slug,
    "country_id": countryId,
    "order_id": orderId,
    "status": status,
    "state_id": stateId,
  };

  @override
  String toString() {
    return 'Brand(id: $id, name: $name, slug: $slug, country_id: $countryId, order_id: $orderId, state_id: $stateId, status: $status)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      slug,
      countryId,
      orderId,
      stateId,
      status,
    ];
  }
}

