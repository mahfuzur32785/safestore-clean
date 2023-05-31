import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'model_model.dart';

class BrandModel extends Equatable{
  const BrandModel({
    required this.id,
    required this.categoryId,
    required this.subcategoryId,
    required this.name,
    required this.slug,
  });

  final int id;
  final int categoryId;
  final int subcategoryId;
  final String name;
  final String slug;

  BrandModel copyWith({
    int? id,
    int? categoryId,
    int? subcategoryId,
    String? name,
    String? slug,
  }) =>
      BrandModel(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        subcategoryId: subcategoryId ?? this.subcategoryId,
        name: name ?? this.name,
        slug: slug ?? this.slug,
      );

  factory BrandModel.fromJson(String str) => BrandModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BrandModel.fromMap(Map<String, dynamic> json) => BrandModel(
    id: json["id"]??0,
    categoryId: json["category_id"]??0,
    subcategoryId: json["subcategory_id"]??0,
    name: json["name"]??'',
    slug: json["slug"]??'',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "name": name,
    "slug": slug,
  };

  @override
  String toString() {
    return 'BrandModel(id: $id, category_id: $categoryId, name: $name, slug: $slug, subcategory_id: $subcategoryId)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      categoryId,
      name,
      slug,
      subcategoryId,
    ];
  }
}