import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'model_model.dart';

class ServiceTypeModel extends Equatable{
  const ServiceTypeModel({
    required this.id,
    required this.title,
    required this.comment,
    required this.categoryId,
    required this.subcategoryId,
    required this.status,
  });

  final int id;
  final String title;
  final dynamic comment;
  final int categoryId;
  final int subcategoryId;
  final int status;

  ServiceTypeModel copyWith({
    int? id,
    String? title,
    dynamic comment,
    int? categoryId,
    int? subcategoryId,
    int? status,
  }) =>
      ServiceTypeModel(
        id: id ?? this.id,
        title: title ?? this.title,
        comment: comment ?? this.comment,
        categoryId: categoryId ?? this.categoryId,
        subcategoryId: subcategoryId ?? this.subcategoryId,
        status: status ?? this.status,
      );

  factory ServiceTypeModel.fromJson(String str) => ServiceTypeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceTypeModel.fromMap(Map<String, dynamic> json) => ServiceTypeModel(
    id: json["id"]??0,
    title: json["title"]??'',
    comment: json["comment"],
    categoryId: json["category_id"]??0,
    subcategoryId: json["subcategory_id"]??0,
    status: json["status"]??0,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "comment": comment,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "status": status,
  };

  @override
  String toString() {
    return 'ServiceTypeModel(id: $id,title:$title, category_id: $categoryId, comment: $comment, status: $status, subcategory_id: $subcategoryId)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      categoryId,
      title,
      comment,
      status,
      subcategoryId,
    ];
  }
}