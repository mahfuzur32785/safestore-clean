import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:safestore/modules/authentication/models/user_prfile_model.dart';
import 'package:safestore/modules/home/model/ad_model.dart';

import '../../home/model/badges_model.dart';
import '../../home/model/category_model.dart';

class AdDetails extends Equatable{
  AdDetails({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.phone,
    required this.showPhone,
    required this.phone2,
    required this.email,
    required this.address,
    required this.totalViews,
    required this.mapAddress,
    required this.status,
    required this.showEmail,
    required this.featured,
    required this.whatsapp,
    required this.showWhatsapp,
    required this.authenticity,
    required this.edition,
    required this.required_education,
    required this.locality,
    required this.postcode,
    // required this.city,
    required this.region,
    required this.country,
    required this.propertySize,
    required this.propertyUnit,
    required this.vehicleManufacture,
    required this.vehicleEngineCapacity,
    required this.vehicleFuleType,
    required this.vehicleTransmission,
    required this.vehicleBodyType,
    required this.propertyPriceType,
    required this.propertyType,
    required this.condition,
    required this.registrationYear,
    required this.featureDuration,
    required this.designation,
    required this.experience,
    required this.jobType,
    required this.salaryFrom,
    required this.salaryTo,
    required this.deadline,
    required this.employerName,
    required this.employerLogo,
    required this.textbookType,
    required this.model,

    required this.userId,
    required this.categoryId,
    required this.subcategoryId,
    required this.brandId,

    required this.adsId,
    required this.countryId,
    required this.stateId,
    required this.stateName,
    required this.cityId,
    required this.city,

    required this.brandName,
    required this.isFeatured,
    required this.totalReports,
    required this.isBlocked,
    required this.draftedAt,
    required this.updatedAt,
    required this.neighborhood,
    required this.place,
    required this.district,
    required this.long,
    required this.lat,
    required this.imageUrl,
    this.category,
    this.subcategory,
    this.customer,
    this.brand,
    required this.adFeatures,
    required this.galleries,
    required this.shareUrl,
    this.badges,
    required this.createdAt,
    required this.website,
    required this.wishListed,
    required this.receiveIsEmail,
    required this.receiveIsPhone,
  });

  final int id;
  final String title;
  final String slug;
  final String description;
  final int price;
  final dynamic thumbnail;
  final String phone;
  final dynamic showPhone;
  final dynamic phone2;
  final String email;
  final String address;
  final int totalViews;
  final dynamic mapAddress;
  final String status;
  final String showEmail;
  final String featured;
  final String whatsapp;
  final String showWhatsapp;
  final dynamic authenticity;
  final dynamic edition;
  final String required_education;
  final String locality;
  final String postcode;

  final dynamic adsId;
  final int countryId;
  final int stateId;
  final String stateName;
  final int cityId;
  final String city;

  // final String city;
  final String region;
  final String country;
  final String website;
  final dynamic propertySize;
  final dynamic propertyUnit;
  final dynamic vehicleManufacture;
  final dynamic vehicleEngineCapacity;
  final List<String> vehicleFuleType;
  final String vehicleTransmission;
  final dynamic vehicleBodyType;
  final dynamic propertyPriceType;
  final dynamic propertyType;
  final dynamic condition;
  final dynamic registrationYear;
  final dynamic featureDuration;
  final dynamic designation;
  final dynamic experience;
  final dynamic jobType;
  final dynamic salaryFrom;
  final dynamic salaryTo;
  final dynamic deadline;
  final dynamic employerName;
  final dynamic employerLogo;
  final dynamic textbookType;
  final dynamic model;

  final int userId;
  final int categoryId;
  final int subcategoryId;
  final dynamic brandId;
  final String brandName;
  final String isFeatured;
  final String totalReports;
  final String isBlocked;
  final dynamic draftedAt;
  final String updatedAt;
  final String neighborhood;
  final String place;
  final String district;
  final dynamic long;
  final dynamic lat;
  final String imageUrl;
  Category? category;
  Brand? subcategory;
  UserProfileModel? customer;
  Brand? brand;
  final List<AdFeature> adFeatures;
  final List<Gallery> galleries;
  final String shareUrl;
  Badges? badges;
  final String? createdAt;
  final bool wishListed;
  final dynamic receiveIsEmail;
  final dynamic receiveIsPhone;

  AdDetails copyWith({

    int? id,
    String? title,
    String? slug,
    String? description,
    int? price,
    dynamic thumbnail,
    String? phone,
    dynamic showPhone,
    dynamic phone2,
    String? email,
    String? address,
    int? totalViews,
    dynamic mapAddress,
    String? status,
    String? showEmail,
    String? featured,
    String? whatsapp,
    String? showWhatsapp,
    dynamic authenticity,
    dynamic edition,
    String? locality,
    String? required_education,
    String? postcode,

    dynamic adsId,
    int? countryId,
    int? stateId,
    String? stateName,
    int? cityId,
    String? city,

    String? region,
    String? country,
    String? website,
    dynamic propertySize,
    dynamic propertyUnit,
    dynamic vehicleManufacture,
    dynamic vehicleEngineCapacity,
    List<String>? vehicleFuleType,
    String? vehicleTransmission,
    dynamic vehicleBodyType,
    dynamic propertyPriceType,
    dynamic propertyType,
    dynamic condition,
    dynamic registrationYear,
    dynamic featureDuration,
    dynamic designation,
    dynamic experience,
    dynamic jobType,
    dynamic salaryFrom,
    dynamic salaryTo,
    dynamic deadline,
    dynamic employerName,
    dynamic employerLogo,
    dynamic textbookType,
    dynamic model,

    int? userId,
    int? categoryId,
    int? subcategoryId,
    dynamic brandId,

    String? brandName,
    String? isFeatured,
    String? totalReports,
    String? isBlocked,
    dynamic draftedAt,
    String? updatedAt,
    String? neighborhood,
    String? place,
    String? district,
    dynamic long,
    dynamic lat,
    String? imageUrl,

    Category? category,
    Brand? subcategory,
    UserProfileModel? customer,
    Brand? brand,
    List<AdFeature>? adFeatures,
    List<Gallery>? galleries,
    String? shareUrl,
    Badges? badges,
    String? createdAt,

    bool? wishListed,
    dynamic receiveIsEmail,
    dynamic receiveIsPhone,

  }) =>
      AdDetails(
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        description: description ?? this.description,
        price: price ?? this.price,
        thumbnail: thumbnail ?? this.thumbnail,
        phone: phone ?? this.phone,
        showPhone: showPhone ?? this.showPhone,
        phone2: phone2 ?? this.phone2,
        email: email ?? this.email,
        address: address ?? this.address,
        totalViews: totalViews ?? this.totalViews,
        mapAddress: mapAddress ?? this.mapAddress,
        status: status ?? this.status,
        showEmail: showEmail ?? this.showEmail,
        featured: featured ?? this.featured,
        whatsapp: whatsapp ?? this.whatsapp,
        showWhatsapp: showWhatsapp ?? this.showWhatsapp,
        authenticity: authenticity ?? this.authenticity,
        edition: edition ?? this.edition,
        locality: locality ?? this.locality,
        required_education: required_education ?? this.required_education,
        postcode: postcode ?? this.postcode,
        region: region ?? this.region,
        country: country ?? this.country,
        website: website ?? this.website,
        propertySize: propertySize ?? this.propertySize,
        propertyUnit: propertyUnit ?? this.propertyUnit,
        vehicleManufacture: vehicleManufacture ?? this.vehicleManufacture,
        vehicleEngineCapacity: vehicleEngineCapacity ?? this.vehicleEngineCapacity,
        vehicleFuleType: vehicleFuleType ?? this.vehicleFuleType,
        vehicleTransmission: vehicleTransmission ?? this.vehicleTransmission,
        vehicleBodyType: vehicleBodyType ?? this.vehicleBodyType,
        propertyPriceType: propertyPriceType ?? this.propertyPriceType,
        propertyType: propertyType ?? this.propertyType,
        condition: condition ?? this.condition,
        registrationYear: registrationYear ?? this.registrationYear,
        featureDuration: featureDuration ?? this.featureDuration,
        designation: designation ?? this.designation,
        experience: experience ?? this.experience,
        jobType: jobType ?? this.jobType,
        salaryFrom: salaryFrom ?? this.salaryFrom,
        salaryTo: salaryTo ?? this.salaryTo,
        deadline: deadline ?? this.deadline,
        employerName: employerName ?? this.employerName,
        employerLogo: employerLogo ?? this.employerLogo,
        textbookType: textbookType ?? this.textbookType,
        model: model ?? this.model,

        userId: userId ?? this.userId,
        categoryId: categoryId ?? this.categoryId,
        subcategoryId: subcategoryId ?? this.subcategoryId,
        brandId: brandId ?? this.brandId,

        adsId: adsId ?? this.adsId,
        countryId: countryId ?? this.countryId,
        stateId: stateId ?? this.stateId,
        stateName: stateName ?? this.stateName,
        cityId: cityId ?? this.cityId,
        city: city ?? this.city,

        brandName: brandName ?? this.brandName,
        isFeatured: isFeatured ?? this.isFeatured,
        totalReports: totalReports ?? this.totalReports,
        isBlocked: isBlocked ?? this.isBlocked,
        draftedAt: draftedAt ?? this.draftedAt,
        updatedAt: updatedAt ?? this.updatedAt,
        neighborhood: neighborhood ?? this.neighborhood,
        place: place ?? this.place,
        district: district ?? this.district,
        long: long ?? this.long,
        lat: lat ?? this.lat,
        imageUrl: imageUrl ?? this.imageUrl,
        category: category ?? this.category,
        subcategory: subcategory ?? this.subcategory,
        customer: customer ?? this.customer,
        brand: brand ?? this.brand,
        adFeatures: adFeatures ?? this.adFeatures,
        galleries: galleries ?? this.galleries,
        shareUrl: shareUrl ?? this.shareUrl,
        badges: badges ?? this.badges,
        createdAt: createdAt ?? this.createdAt,
        wishListed: wishListed ?? this.wishListed,
        receiveIsEmail: receiveIsEmail ?? this.receiveIsEmail,
        receiveIsPhone: receiveIsPhone ?? this.receiveIsPhone,

      );

  factory AdDetails.fromJson(String str) => AdDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdDetails.fromMap(Map<String, dynamic> json) => AdDetails(

    id: json["id"] ?? 0,
    title: json["title"] ?? '',
    slug: json["slug"] ?? '',
    description: json["description"] ?? '',
    price: json["price"] is String ? int.parse(json["price"]) : json["price"] ?? 0,
    thumbnail: json["thumbnail"],
    phone: json["phone"] ?? '',
    showPhone: json["show_phone"],
    phone2: json["phone_2"] ?? '',
    email: json["email"] ?? '',
    address: json["address"] ?? '',
    totalViews: json["total_views"] is String ? int.parse(json["total_views"]): json["total_views"] ?? 0,

    mapAddress: json["map_address"],
    status: json["status"] ?? '',
    showEmail: json["show_email"] is int ? json["show_email"].toString() : json["show_email"] ?? '',

    featured: json["featured"] is int ? json["featured"].toString() : json["featured"] ?? '',
    whatsapp: json["whatsapp"] ?? '',
    showWhatsapp: json["show_whatsapp"] is int ? json["show_whatsapp"].toString() : json["show_whatsapp"]??'',

    authenticity: json["authenticity"],
    edition: json["edition"],
    locality: json["locality"] ?? '',
    required_education: json["required_education"] ?? '',
    postcode: json["postcode"] ?? '',
    region: json["region"] ?? '',
    country: json["country"] ?? '',
    website: json["website"] ?? '',
    propertySize: json["property_size"],
    propertyUnit: json["property_unit"],
    vehicleManufacture: json["vehicle_manufacture"],
    vehicleEngineCapacity: json["vehicle_engine_capacity"],
    vehicleFuleType: json["vehicle_fule_type"] == null ? [] : json["vehicle_fule_type"] == "[]" ? [] : List<String>.from(json["vehicle_fule_type"].map((x) => x)).toList(),

    // vehicleFuleType: json["vehicle_fule_type"] ?? [].cast<dynamic>(),

    // vehicleFuleType: json["vehicle_fule_type"] is String ? json["vehicle_fule_type"] == '' ? [] : List<String>.from(json["vehicle_fule_type"].map((x) => x)).toList() :  json["vehicle_fule_type"] == null ? [] : List<String>.from(json["vehicle_fule_type"].map((x) => x)).toList(),

    vehicleTransmission: json["vehicle_transmission"] ?? '',
    vehicleBodyType: json["vehicle_body_type"],
    propertyPriceType: json["property_price_type"],
    propertyType: json["property_type"],
    condition: json["condition"],
    registrationYear: json["registration_year"],
    featureDuration: json["feature_duration"],
    designation: json["designation"],
    experience: json["experience"],
    jobType: json["job_type"],
    salaryFrom: json["salary_from"],
    salaryTo: json["salary_to"],
    deadline: json["deadline"],
    employerName: json["employer_name"],
    employerLogo: json["employer_logo"],
    textbookType: json["textbook_type"],
    model: json["model"],

    userId: json["user_id"] is String ? int.parse(json["user_id"]) : json["user_id"] ?? 0,
    categoryId: json["category_id"] is String ? int.parse(json["category_id"])  : json["category_id"] ?? 0,
    subcategoryId: json["subcategory_id"] is String ? int.parse(json["subcategory_id"]) : json["subcategory_id"] ?? 0,
    brandId: json["brand_id"],

    adsId: json['ads_type'],
    countryId: json['country_id'] is String ? int.parse( json['country_id']) :  json['country_id'] ?? 0,
    stateId: json['region_id'] is String ? int.parse( json['region_id']) :  json['region_id'] ?? 0,
    stateName: json['state'] ?? '',
    cityId: json['city_id'] is String ? int.parse( json['city_id']) :  json['city_id'] ?? 0,
    city: json['city'] ?? '',

    brandName: json["brand_name"] ?? '',
    isFeatured: json["is_featured"] ?? '',
    totalReports: json["total_reports"] is int ? json["total_reports"].toString() : json["total_reports"] ?? '',
    isBlocked: json["is_blocked"] is int ? json["is_blocked"].toString() : json["is_blocked"] ?? '',
    draftedAt: json["drafted_at"] ?? '',
    updatedAt: json["updated_at"] ?? '',
    neighborhood: json["neighborhood"] ?? '',
    place: json["place"] ?? '',
    district: json["district"] ?? '',
    long: json["long"],
    lat: json["lat"],
    // long: json["long"] is int
    //   ? (json['long'] as int).toDouble()
    //   : json['long'] ?? 0.0,
    // lat: json["lat"] is int
    //   ? (json['lat'] as int).toDouble()
    //   : json['lat'] ?? 0.0,
    imageUrl: json["image_url"] ?? '',
    category: json["category"] == null ? null : Category.fromMap(json["category"]),
    subcategory: json["subcategory"] == null ? null : Brand.fromMap(json["subcategory"]),
    brand: json["brand"] == null ? null : Brand.fromMap(json["brand"]),
    customer: json["customer"] == null ? null :  UserProfileModel.fromMap(json["customer"]),
    adFeatures: json["ad_features"] == null ? [] : List<AdFeature>.from(json["ad_features"].map((x) => AdFeature.fromMap(x))),
    galleries: json["galleries"] == null ? [] : List<Gallery>.from(json["galleries"].map((x) => Gallery.fromMap(x))),
    shareUrl: json["shareUrl"] ?? '',
    badges: json["badges"] == null ? null : Badges.fromMap(json["badges"]),
    createdAt: json['created_at'] ?? '',
    wishListed: json["is_wishlist"] ?? false,
    receiveIsEmail: json["receive_is_email"],
    receiveIsPhone: json["receive_is_phone"],

  );

  Map<String, dynamic> toMap() => {

    "id": id,
    "title": title,
    "slug": slug,
    "description": description,
    "price": price,
    "thumbnail": thumbnail,
    "phone": phone,
    "show_phone": showPhone,
    "phone_2": phone2,
    "email": email,
    "address": address,
    "total_views": totalViews,
    "map_address": mapAddress,
    "status": status,
    "show_email": showEmail,
    "featured": featured,
    "whatsapp": whatsapp,
    "show_whatsapp": showWhatsapp,
    "authenticity": authenticity,
    "edition": edition,
    "locality": locality,
    "required_education": required_education,
    "postcode": postcode,
    // "city": city ==null ? null : city,
    "region": region,
    "country": country,
    "website": website,
    "property_size": propertySize,
    "property_unit": propertyUnit,
    "vehicle_manufacture": vehicleManufacture,
    "vehicle_engine_capacity":  vehicleEngineCapacity,
    "vehicle_fule_type": vehicleFuleType,
    "vehicle_transmission": vehicleTransmission,
    "vehicle_body_type": vehicleBodyType,
    "property_price_type": propertyPriceType,
    "property_type": propertyType,
    "condition": condition,
    "registration_year": registrationYear,
    "feature_duration": featureDuration,
    "designation": designation,
    "experience": experience,
    "job_type": jobType,
    "salary_from": salaryFrom,
    "salary_to": salaryTo,
    "deadline": deadline,
    "employer_name": employerName,
    "employer_logo": employerLogo,
    "textbook_type": textbookType,
    "model": model,

    "user_id": userId,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "brand_id": brandId,

    "ads_type": adsId,
    'country_id': countryId,
    'region_id': stateId,
    'state': stateName,
    'city_id': cityId,
    'city': city,


    "brand_name": brandName,
    "is_featured": isFeatured,
    "total_reports": totalReports,
    "mapAddress": mapAddress,
    "is_blocked": isBlocked,
    "drafted_at": draftedAt,
    "updated_at": updatedAt,
    "neighborhood": neighborhood,
    "place": place,
    "district": district,
    "long": long,
    "lat": lat,
    "image_url": imageUrl,
    "category": category == null ? null : category?.toMap(),
    "subcategory": subcategory == null ? null : subcategory?.toMap(),
    "customer": customer == null ? null : customer?.toMap(),
    "brand": brand == null ? null : brand?.toMap(),
    "ad_features": List<dynamic>.from(adFeatures.map((x) => x.toMap())),
    "galleries": List<dynamic>.from(galleries.map((x) => x.toMap())),
    "shareUrl": shareUrl,
    "badges": badges == null ? null : badges?.toMap(),
    "created_at": createdAt == null ? null : createdAt,
    "is_wishlist": wishListed,
    "receive_is_email": receiveIsEmail,
    "receive_is_phone": receiveIsPhone,
  };

  @override
  String toString() {
    return 'AdDetails(id: $id, title: $title, slug: $slug, user_id: $userId, category_id: $categoryId, subcategory_id: $subcategoryId, brand_id: $brandId, ads_type: $adsId, brand_name: $brandName, '
        'price: $price, description: $description, phone: $phone, phone_2: $phone2, email: $email, thumbnail: $thumbnail, status: $status, featured: $featured, '
        'is_featured: $isFeatured, total_reports: $totalReports, total_views: $totalViews, mapAddress: $mapAddress, is_blocked: $isBlocked, drafted_at: $draftedAt, updated_at: $updatedAt,'
    'vehicleEngineCapacity:$vehicleEngineCapacity, vehicleTransmission:$vehicleTransmission, vehicleBodyType:$vehicleBodyType,propertyPriceType:$propertyPriceType,propertyType:$propertyType'
    'condition:$condition, registrationYear:$registrationYear, featureDuration:$featureDuration, designation:$designation, experience:$experience, jobType:$jobType'
    ' salaryFrom:$salaryFrom, salaryTo:$salaryTo, deadline:$deadline, employerName:$employerName, '
    'employerLogo:$employerLogo, textbookType:$textbookType, model:$model, created_at:$createdAt, website:$website, country_id:$countryId, region_id:$stateId, city_id:$cityId,'
        ' address: $address, receiveIsEmail:$receiveIsEmail, receiveIsPhone:$receiveIsPhone, is_wishlist: $wishListed, neighborhood: $neighborhood, locality: $locality,required_education: $required_education, place: $place,district: $district,propertySize:$propertySize,propertyUnit:$propertyUnit,vehicleManufacture:$vehicleManufacture, postcode: $postcode, region: $region, country: $country, long: $long,lat: $lat, edition:$edition,locality:$locality,region:$region, country:$country, whatsapp: $whatsapp, image_url: $imageUrl, category: $category,subcategory: $subcategory, authenticity:$authenticity, brand: $brand, customer: $customer, ad_features: $adFeatures, galleries: $galleries,shareUrl: $shareUrl, badges: $badges, showEmail:$showEmail, showWhatsapp:$showWhatsapp, )';
  }

  @override
  List<Object?> get props {
    return [id, title, slug, userId, categoryId, subcategoryId,
      brandId, brandName, price, description, phone, showPhone, phone2,email, thumbnail, status, featured,
      isFeatured,totalReports,totalViews,mapAddress,isBlocked,draftedAt,updatedAt,
      address, neighborhood, locality, place, district, postcode,showWhatsapp, authenticity, edition,
      region,showEmail,website,required_education, wishListed,receiveIsPhone,receiveIsEmail,
      country, propertySize, propertyUnit, vehicleManufacture, vehicleEngineCapacity, vehicleFuleType, vehicleTransmission,
      long,vehicleBodyType, propertyPriceType, propertyType, condition, registrationYear, featureDuration, designation, experience, jobType, salaryFrom,
      lat,salaryTo, deadline, employerName, employerLogo, textbookType, model,createdAt,
      whatsapp,imageUrl,category,subcategory,brand,customer,adFeatures,galleries,shareUrl,badges,adsId,
      countryId,
      country,
      stateId,
      stateName,
      cityId,
      city,
    ];
  }
}