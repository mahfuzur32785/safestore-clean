import 'dart:convert';

import 'package:safestore/modules/home/model/city_model.dart';
import 'package:equatable/equatable.dart';

class StateModel extends Equatable{
  const StateModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.countryId,
    required this.orderId,
    required this.status,
    required this.city,
    required this.stateId,
  });

  final int id;
  final String name;
  final String slug;
  final int countryId;
  final int orderId;
  final int status;
  final List<City> city;
  final int stateId;

  StateModel copyWith({
    int? id,
    String? name,
    String? slug,
    int? countryId,
    int? orderId,
    int? status,
    List<City>? city,
    int? stateId,
  }) =>
      StateModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        countryId: countryId ?? this.countryId,
        orderId: orderId ?? this.orderId,
        status: status ?? this.status,
        city: city ?? this.city,
        stateId: stateId ?? this.stateId,
      );

  factory StateModel.fromJson(String str) => StateModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StateModel.fromMap(Map<String, dynamic> json) => StateModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    slug: json["slug"] ?? '',
    countryId: json["country_id"] ?? 0,
    orderId: json["order_id"] ?? 0,
    status: json["status"] ?? 0,
    city: json["city"] == null ? [] : List<City>.from(json['city']
        .map((x) => City.fromMap(x))),
    stateId: json["state_id"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "slug": slug,
    "country_id": countryId,
    "order_id": orderId,
    "status": status,
    "city": city,
    "state_id": stateId,
  };

  @override
  String toString() {
    return 'Brand(id: $id, name: $name, slug: $slug, country_id: $countryId, order_id: $orderId,city: $city, state_id: $stateId, status: $status)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      slug,
      countryId,
      orderId,
      city,
      stateId,
      status,
    ];
  }
}
