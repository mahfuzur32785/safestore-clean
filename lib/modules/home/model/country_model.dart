import 'dart:convert';

import 'package:safestore/modules/home/model/state_model.dart';
import 'package:equatable/equatable.dart';

class TopCountry extends Equatable{
  const TopCountry({
    required this.id,
    required this.iso,
    required this.name,
    required this.nicename,
    required this.iso3,
    required this.numcode,
    required this.phonecode,
    required this.isDefault,
    required this.status,
    required this.states,
  });

  final int id;
  final String iso;
  final String name;
  final String nicename;
  final String iso3;
  final int numcode;
  final int phonecode;
  final int isDefault;
  final int status;
  final List<StateModel> states;

  TopCountry copyWith({
    int? id,
    String? iso,
    String? name,
    String? nicename,
    String? iso3,
    int? numcode,
    int? phonecode,
    int? isDefault,
    int? status,
    List<StateModel>? states,
  }) =>
      TopCountry(
        id: id ?? this.id,
        iso: iso ?? this.iso,
        name: name ?? this.name,
        nicename: nicename ?? this.nicename,
        iso3: iso3 ?? this.iso3,
        numcode: numcode ?? this.numcode,
        phonecode: phonecode ?? this.phonecode,
        isDefault: isDefault ?? this.isDefault,
        status: status ?? this.status,
        states: states ?? this.states,
      );

  factory TopCountry.fromJson(String str) => TopCountry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TopCountry.fromMap(Map<String, dynamic> json) => TopCountry(
    id: json["id"] is String ? int.parse(json["id"]): json["id"]??0,
    iso: json["iso"]??'',
    name: json["name"]??'',
    nicename: json["nicename"]??'',
    iso3: json["iso3"]??'',
    numcode: json["numcode"] is String ? int.parse(json["numcode"]): json["numcode"]??0,
    phonecode: json["phonecode"] is String ? int.parse(json["phonecode"]): json["phonecode"]??0,
    isDefault: json["is_default"] is String ? int.parse(json["is_default"]): json["is_default"]??0,
    status: json["status"] is String ? int.parse(json["status"]): json["status"]??0,
    states: json["states"] == null ? [] : List<StateModel>.from(json['states']
        .map((x) => StateModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "iso": iso,
    "name": name,
    "nicename": nicename,
    "iso3": iso3,
    "numcode": numcode,
    "phonecode": phonecode,
    "is_default": isDefault,
    "status": status,
    "states": states,

  };

  @override
  String toString() {
    return 'TopCountry(id: $id,status:$status, iso: $iso, name:$name,nicename:$nicename, iso3:$iso3,numcode:$numcode, phonecode:$phonecode,isDefault:$isDefault, states:$states)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      iso,
      name,
      nicename,
      iso3,
      numcode,
      phonecode,
      isDefault,
      status,
      states
    ];
  }
}