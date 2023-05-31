part of 'new_ad_edit_bloc.dart';

class NewEditAdModalState extends Equatable {

  final String name;
  final String price;
  final String categoryId;
  final String subCategoryId;
  final String phone;
  final bool isShowPhone;
  final String email;
  final bool isShowEmail;
  final dynamic isReceivedEmail;
  final dynamic isReceivedPhone;
  final String whatsapp;
  final String website;
  final bool isShowWhatsapp;
  final String description;
  final List<String> features;
  final String address;
  final List<String> images;
  final String thumbnail;
  final List<String> deleteImage;

  final String brandId;
  final String adsId;
  final String countryId;
  final String stateId;
  final String cityId;

  final String model;
  final String experience;
  final String educations;
  final String designation;
  final String salary_from;
  final String salary_to;
  final String deadline;
  final String employer_name;
  final String job_type;
  final String employer_website;
  final String employer_logo;
  final String condition;
  final String textbookType;
  final String authenticity;
  final String edition;
  final String trim_edition;
  final String year_of_manufacture;
  final String engine_capacity;
  final String transmission;
  final String registration_year;
  final String body_type;
  final List<String> vehicleFuleType;
  final String property_type;
  final String size;
  final String size_type;
  final String property_location;
  final String price_type;
  final String status;
  final NewEditAdState state;
  const NewEditAdModalState({
    this.name = '',
    this.price = '',
    this.email = '',
    this.isShowEmail = false,
    this.isReceivedEmail = false,
    this.isReceivedPhone = false,
    this.categoryId = '',
    this.subCategoryId = '',
    this.phone = '',
    this.isShowPhone = false,
    this.whatsapp = '',
    this.website = '',
    this.isShowWhatsapp = false,
    this.description = '',
    this.features = const [],
    this.address = '',
    this.images = const [],
    this.thumbnail = '',
    this.deleteImage = const [],

    this.adsId = '',
    this.countryId = '',
    this.stateId = '',
    this.cityId = '',

    this.experience = '',
    this.educations = '',
    this.designation = '',
    this.salary_from = '',
    this.salary_to = '',
    this.deadline = '',
    this.employer_name = '',
    this.job_type = '',
    this.employer_website = '',
    this.employer_logo = '',
    this.condition = '',
    this.textbookType = '',
    this.authenticity = '',
    this.edition = '',
    this.model = '',
    this.brandId = '',
    this.trim_edition = '',
    this.year_of_manufacture = '',
    this.engine_capacity = '',
    this.transmission = '',
    this.registration_year = '',
    this.body_type = '',
    this.vehicleFuleType = const [],
    this.property_type = '',
    this.size = '',
    this.size_type = 'sqft',
    this.property_location='',
    this.price_type= 'total price',
    this.status = '',
    this.state = const NewEditAdStateInitial(),
  });

  NewEditAdModalState copyWith({
    String? name,
    String? price,
    String? categoryId,
    String? subCategoryId,
    String? phone,
    bool? isShowPhone,
    String? email,
    bool? isShowEmail,
    dynamic isReceivedEmail,
    dynamic isReceivedPhone,
    String? backupPhone,
    String? whatsapp,
    String? website,
    bool? isShowWhatsapp,
    String? description,
    List<String>? features,
    String? address,
    List<String>? images,
    List<String>? deleteImage,
    String? thumbnail,

    String? adsId,
    String? countryId,
    String? stateId,
    String? cityId,

    String? experience,
    String? educations,
    String? designation,
    String? salary_from,
    String? salary_to,
    String? deadline,
    String? employer_name,
    String? job_type,
    String? employer_website,
    String? employer_logo,
    String? condition,
    String? textbookType,
    String? authenticity,

    String? edition,
    String? model,
    String? brandId,

    String? trim_edition,
    String? year_of_manufacture,
    String? engine_capacity,
    String? transmission,
    String? registration_year,
    String? body_type,
    List<String>? vehicleFuleType,
    String? property_type,
    String? size,
    String? size_type,
    String? property_location,
    String? price_type,
    String? status,
    NewEditAdState? state,
  }) {
    return NewEditAdModalState(
      name: name ?? this.name,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      phone: phone ?? this.phone,
      isShowPhone: isShowPhone ?? this.isShowPhone,
      email: email ?? this.email,
      isShowEmail: isShowEmail ?? this.isShowEmail,
      isReceivedEmail: isReceivedEmail ?? this.isReceivedEmail,
      isReceivedPhone: isReceivedPhone ?? this.isReceivedPhone,
      whatsapp: whatsapp ?? this.whatsapp,
      website: website ?? this.website,
      isShowWhatsapp: isShowWhatsapp ?? this.isShowWhatsapp,
      description: description ?? this.description,
      features: features ?? this.features,
      address: address ?? this.address,
      images: images ?? this.images,
      thumbnail: thumbnail ?? this.thumbnail,
      deleteImage: deleteImage ?? this.deleteImage,

      adsId: adsId ?? this.adsId,
      countryId: countryId ?? this.countryId,
      stateId: stateId ?? this.stateId,
      cityId: cityId ?? this.cityId,

      experience: experience ?? this.experience,
      educations: educations ?? this.educations,
      designation: designation ?? this.designation,
      salary_from: salary_from ?? this.salary_from,
      salary_to: salary_to ?? this.salary_to,
      deadline: deadline ?? this.deadline,
      employer_name: employer_name ?? this.employer_name,
      job_type: job_type ?? this.job_type,
      employer_website: employer_website ?? this.employer_website,
      employer_logo: employer_logo ?? this.employer_logo,
      condition: condition ?? this.condition,
      textbookType: textbookType ?? this.textbookType,
      authenticity: authenticity ?? this.authenticity,
      edition: edition ?? this.edition,
      model: model ?? this.model,
      brandId: brandId ?? this.brandId,
      trim_edition: trim_edition ?? this.trim_edition,
      year_of_manufacture: year_of_manufacture ?? this.year_of_manufacture,
      engine_capacity: engine_capacity ?? this.engine_capacity,
      transmission: transmission ?? this.transmission,
      registration_year: registration_year ?? this.registration_year,
      body_type: body_type ?? this.body_type,
      vehicleFuleType: vehicleFuleType ?? this.vehicleFuleType,
      property_type: property_type ?? this.property_type,
      size: size ?? this.size,
      size_type: size_type ?? this.size_type,
      property_location: property_location ?? this.property_location,
      price_type: price_type ?? this.price_type,
      status: status ?? this.status,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': name.trim()});
    result.addAll({'price': price.trim()});
    result.addAll({'category_id': categoryId});
    result.addAll({'subcategory_id': subCategoryId});
    result.addAll({'phone': phone.trim()});
    result.addAll({'show_phone': isShowPhone ? '1' : '0'});
    result.addAll({'email': email.trim()});
    result.addAll({'show_email': isShowEmail ? '1' : '0'});
    result.addAll({'receive_is_email': isReceivedEmail ? '1' : '0'});
    result.addAll({'receive_is_phone': isReceivedEmail ? '1' : '0'});
    result.addAll({'whatsapp': whatsapp.trim()});
    result.addAll({'website': website.trim()});
    result.addAll({'show_whatsapp': isShowWhatsapp ? '1' : '0'});
    result.addAll({'description': description.trim()});
    result.addAll({'features': features.map((e) => e).toList()});
    result.addAll({'address': address.trim()});
    result.addAll({'featured': '0'});

    result.addAll({'brand_id': brandId.trim()});
    result.addAll({'ads_type': adsId.trim()});
    result.addAll({'country_id': countryId.trim()});
    result.addAll({'state_id': stateId.trim()});
    result.addAll({'city_id': cityId.trim()});

    result.addAll({'experience': experience.trim()});
    result.addAll({'educations': educations.trim()});
    result.addAll({'designation': designation.trim()});
    result.addAll({'salary_from': salary_from.trim()});
    result.addAll({'salary_to': salary_to.trim()});
    result.addAll({'deadline': deadline.trim()});
    result.addAll({'employer_name': employer_name.trim()});
    result.addAll({'job_type': job_type.trim()});
    result.addAll({'website': employer_website.trim()});
    result.addAll({'employer_logo': employer_logo.trim()});
    result.addAll({'condition': condition.trim()});
    result.addAll({'textbook_type': textbookType.trim()});
    result.addAll({'authenticity': authenticity.trim()});
    result.addAll({'edition': edition.trim()});
    result.addAll({'model': model.trim()});

    result.addAll({'trim_edition': trim_edition.trim()});
    result.addAll({'year_of_manufacture': year_of_manufacture.trim()});
    result.addAll({'engine_capacity': engine_capacity.trim()});
    result.addAll({'transmission': transmission.trim()});
    result.addAll({'registration_year': registration_year.trim()});
    result.addAll({'body_type': body_type.trim()});
    result.addAll({'vehicle_fule_type': vehicleFuleType.map((e) => e).toList()});
    result.addAll({'property_type': property_type.trim()});
    result.addAll({'property_size': size.trim()});
    result.addAll({'property_unit': size_type.trim()});
    result.addAll({'property_location': property_location.trim()});
    result.addAll({'property_price_type': price_type.trim()});
    result.addAll({'status': status.trim()});
    result.addAll({'images': images.map((e) => e).toList()});
    result.addAll({'thumbnail': thumbnail.trim()});
    result.addAll({'delete_image': deleteImage.map((e) => e).toList()});
    // result.addAll({'status': status});
    return result;
  }

  factory NewEditAdModalState.fromMap(Map<String, dynamic> map) {
    return NewEditAdModalState(
      name: map['title'] ?? '',
      price: map['price'] ?? '',
      categoryId: map['category_id'] is int ? map['category_id'].toString() : map['category_id'] ?? '',
      subCategoryId: map['subcategory_id'] is int ? map['subcategory_id'].toString() : map['subcategory_id'] ?? '',
      phone: map['phone'] ?? '',
      isShowPhone: map['show_phone'] ?? false,
      email: map['email'] ?? '',
      isShowEmail: map['show_email'] ?? false,
      isReceivedEmail: map['receive_is_email'] ?? false,
      isReceivedPhone: map['receive_is_phone'] ?? false,
      whatsapp: map['whatsapp'] ?? '',
      website: map['website'] ?? '',
      isShowWhatsapp: map['show_whatsapp'] ?? false,
      description: map['description'] ?? '',
      features: map['features[]'] ?? [],
      address: map['address'] ?? '',
      images: map['images[]'] ?? [],
      thumbnail: map['thumbnail'] ?? '',
      deleteImage: map['delete_image[]'] ?? [],

      adsId: map['ads_type'] ?? '',
      countryId: map['country_id'] ?? '',
      stateId: map['state_id'] ?? '',
      cityId: map['city_id'] ?? '',

      experience: map['experience'] ?? '',
      educations: map['educations'] ?? '',
      designation: map['designation'] ?? '',
      salary_from: map['salary_from'] ?? '',
      salary_to: map['salary_to'] ?? '',
      deadline: map['deadline'] ?? '',
      employer_name: map['employer_name'] ?? '',
      job_type: map['job_type'] ?? '',
      employer_website: map['website'] ?? '',
      employer_logo: map['employer_logo'] ?? '',
      condition: map['condition'] ?? '',
      textbookType: map['textbook_type'] ?? '',
      authenticity: map['authenticity'] ?? '',
      edition: map['edition'] ?? '',
      model: map['model'] ?? '',
      brandId: map['brand_id'] ??'',
      trim_edition: map['trim_edition'] ?? '',
      year_of_manufacture: map['year_of_manufacture'] ?? '',
      engine_capacity: map['engine_capacity'] ?? '',
      transmission: map['transmission'] ?? '',
      registration_year: map['registration_year'] ?? '',
      body_type: map['body_type'] ?? '',
      vehicleFuleType: map['vehicle_fule_type'] ?? [],
      property_type: map['property_type'] ?? '',
      size: map['property_size'] ?? '',
      size_type: map['property_unit'] ?? '',
      property_location: map['property_location'] ?? '',
      price_type: map['property_price_type'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NewEditAdModalState.fromJson(String source) =>
      NewEditAdModalState.fromMap(json.decode(source));

  @override
  String toString() =>
      'NewEditAdModalState(title: $name, price: $price, category_id: $categoryId, subcategory_id: $subCategoryId, website: $website, phone: $phone, show_phone: $isShowPhone, whatsapp: $whatsapp, description: $description, features[]: $features, address: $address, images[]: $images, thumbnail: $thumbnail, delete_image: $deleteImage, state: $state)';

  @override
  List<Object> get props => [
    name,
    price,
    categoryId,
    subCategoryId,
    phone,
    isShowPhone,
    email,
    isShowEmail,
    isReceivedEmail,
    isReceivedPhone,
    whatsapp,
    isShowWhatsapp,
    website,
    description,
    features,
    address,
    adsId,
    countryId,
    stateId,
    cityId,
    images,
    thumbnail,
    deleteImage,
    experience,
    educations,
    designation,
    salary_from,
    salary_to,
    deadline,
    employer_name,
    job_type,
    employer_website,
    employer_logo,
    condition,
    textbookType,
    authenticity,
    edition,
    model,
    brandId,
    trim_edition,
    year_of_manufacture,
    engine_capacity,
    transmission,
    registration_year,
    body_type,
    vehicleFuleType,
    property_type,
    size,
    size_type,
    property_location,
    price_type,
    status,
    state
  ];
}

abstract class NewEditAdState extends Equatable {
  const NewEditAdState();

  @override
  List<Object> get props => [];
}

class NewEditAdStateInitial extends NewEditAdState {
  const NewEditAdStateInitial();
}

class NewEditAdStateLoading extends NewEditAdState {
  const NewEditAdStateLoading();
}

class NewEditAdStateError extends NewEditAdState {
  final String errorMsg;
  final int statusCode;

  const NewEditAdStateError(this.errorMsg, this.statusCode);

  @override
  List<Object> get props => [errorMsg, statusCode];
}

class NewEditAdStateLoaded extends NewEditAdState {
  final String message;
  final bool isBack;
  const NewEditAdStateLoaded(this.message,this.isBack);

  @override
  List<Object> get props => [message];
}