import 'dart:convert';

import 'package:safestore/modules/home/model/brand_model.dart';
import 'package:safestore/modules/home/model/service_type.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable{
  const Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.order,
    required this.adCount,
    required this.image,
    required this.subCategoryList,
    required this.iconUrl,
  });

  final int id;
  final String name;
  final String slug;
  final String icon;
  final String order;
  final int adCount;
  final String image;
  final List<Brand> subCategoryList;
  final String iconUrl;
  Category copyWith({
    int? id,
    String? name,
    String? slug,
    String? icon,
    String? order,
    int? adCount,
    String? image,
    List<Brand>? subCategoryList,
    String? iconUrl,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        icon: icon ?? this.icon,
        order: order ?? this.order,
        adCount: adCount ?? this.adCount,
        image: image ?? this.image,
        subCategoryList: subCategoryList ?? this.subCategoryList,
        iconUrl: iconUrl ?? this.iconUrl,
      );

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    slug: json["slug"] ?? '',
    icon: json["icon"] ?? '',
    order: json["order"] is int ? json["order"].toString() : json["order"] ?? '',
    adCount: json["ad_count"] ?? 0,
    image: json["image"] ?? '',
    subCategoryList: json["subcategories"] == null ? [] : List<Brand>.from(json['subcategories']
        .map((x) => Brand.fromMap(x))),
    iconUrl: json["icon_url"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "slug": slug,
    "icon": icon,
    "order": order,
    "ad_count": adCount,
    "image": image,
    "subcategories": subCategoryList,
    "icon_url": iconUrl,
  };

  @override
  String toString() {
    return 'Category(id: $id, name: $name, slug: $slug, icon: $icon, order: $order, ad_count: $adCount, image: $image,subcategories: $subCategoryList, icon_url:$iconUrl)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      slug,
      icon,
      order,
      adCount,
      image,
      subCategoryList,
      iconUrl
    ];
  }
}

class Brand extends Equatable{
  const Brand({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.slug,
    required this.adCount,
    required this.status,
    required this.brandList,
    required this.serviceTypeList,
  });

  final int id;
  final int categoryId;
  final String name;
  final String slug;
  final int adCount;
  final int status;
  final List<ServiceTypeModel> serviceTypeList;
  final List<BrandModel> brandList;


  Brand copyWith({
    int? id,
    int? categoryId,
    String? name,
    String? slug,
    int? adCount,
    int? status,
    List<ServiceTypeModel>? serviceTypeList,
    List<BrandModel>? brandList,
  }) =>
      Brand(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        adCount: adCount ?? this.adCount,
        status: status ?? this.status,
        brandList: brandList ?? this.brandList,
        serviceTypeList: serviceTypeList ?? this.serviceTypeList,
      );

  factory Brand.fromJson(String str) => Brand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Brand.fromMap(Map<String, dynamic> json) => Brand(
    id: json["id"] ?? 0,
    categoryId: json["category_id"] ?? 0,
    name: json["name"] ?? '',
    slug: json["slug"] ?? '',
    adCount: json["ad_count"] ?? 0,
    status: json["status"] ?? 0,
    serviceTypeList: json["service"] == null ? [] : List<ServiceTypeModel>.from(json['service']
        .map((x) => ServiceTypeModel.fromMap(x))),
    brandList: json["brand"] == null ? [] : List<BrandModel>.from(json['brand']
        .map((x) => BrandModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "slug": slug,
    "ad_count": adCount,
    "status": status,
    "service": serviceTypeList,
    "brand": brandList,

  };

  @override
  String toString() {
    return 'Brand(id: $id, category_id: $categoryId, name: $name, slug: $slug, ad_count: $adCount, status: $status,brand:$brandList, service:$serviceTypeList)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      categoryId,
      name,
      slug,
      adCount,
      status,
      brandList,
      serviceTypeList
    ];
  }
}