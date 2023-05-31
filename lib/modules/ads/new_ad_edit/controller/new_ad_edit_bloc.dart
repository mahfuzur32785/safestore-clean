import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:safestore/modules/ad_details/model/ad_details_model.dart';
import 'package:safestore/modules/home/controller/cubit/home_controller_cubit.dart';
import 'package:safestore/modules/home/model/brand_model.dart';
import 'package:safestore/modules/home/model/category_model.dart';
import 'package:safestore/modules/home/model/city_model.dart';
import 'package:safestore/modules/home/model/country_model.dart';
import 'package:safestore/modules/home/model/model_model.dart';
import 'package:safestore/modules/home/model/service_type.dart';
import 'package:safestore/modules/home/model/state_model.dart';
import 'package:safestore/modules/post_ad/controller/postad_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failure.dart';

part 'new_ad_edit_event.dart';
part 'new_ad_edit_state.dart';

class NewEditAdBloc extends Bloc<NewEditAdEvent, NewEditAdModalState> {
  final PostAdRepository _postAdRepository;
  final HomeControllerCubit _homeControllerCubit;
  final featureFormKey = GlobalKey<FormState>();

  Category? category;
  List<Category> get categoryList =>
      _homeControllerCubit.homeModel.categories.reversed.toList();

  List<Brand> subCategoryList = [];
  Brand? subCategory;
  TopCountry? topCountry;

  // List<BrandModel> get brandList => _homeControllerCubit.homeModel.brandList.where((element) => element.categoryId.toString() == state.category).toList();
  // List<Model> get designationList => _homeControllerCubit.homeModel.designations;

  // List<Model> modelList = [];
  // Model? model;
  // List<Model> get serviceTypeList => _homeControllerCubit.homeModel.serviceTypeList;

  List<Model> get designationList =>
      _homeControllerCubit.homeModel.designations;

  List<TopCountry> get countryList =>
      _homeControllerCubit.homeModel.topCountries.reversed.toList();
  TopCountry? countryModel;

  List<StateModel> stateList = [];
  StateModel? stateModel;

  List<City> cityList = [];
  City? cityModel;

  List<ServiceTypeModel> serviceTypeList = [];
  ServiceTypeModel? serviceTypeModel;

  List<BrandModel> brandList = [];
  BrandModel? brandModel;

  var titleController = TextEditingController(text: "");
  var priceController = TextEditingController(text: "");
  var phoneController = TextEditingController(text: "");
  var emailController = TextEditingController(text: "");
  var backupPhoneController = TextEditingController(text: "");
  var webSiteController = TextEditingController(text: "");
  var descriptionController = TextEditingController(text: "");
  var locationController = TextEditingController(text: "");
  var whatsappController = TextEditingController(text: "");
  var modelController = TextEditingController(text: "");

  var experienceController = TextEditingController(text: "");
  var employerWebsiteController = TextEditingController(text: "");
  var employerNameController = TextEditingController(text: "");
  var deadlineController = TextEditingController(text: "");
  var salaryFromController = TextEditingController(text: "");
  var salaryToController = TextEditingController(text: "");

  var trimEditionController = TextEditingController(text: "");
  var yearOfManuController = TextEditingController(text: "");
  var enginCapacityController = TextEditingController(text: "");
  var registrationYearController = TextEditingController(text: "");

  NewEditAdBloc({
    required PostAdRepository postAdRepository,
    required HomeControllerCubit homeControllerCubit,
  })  : _postAdRepository = postAdRepository,
        _homeControllerCubit = homeControllerCubit,
        super(const NewEditAdModalState()) {
    on<NewEditAdEventEmpty>(_clearAll);

    on<NewEditAdEventName>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
    on<NewEditAdEventPrice>((event, emit) {
      emit(state.copyWith(price: event.price));
    });

    on<NewEditAdEventCategory>((event, emit) {
      Category category = categoryList
          .singleWhere((element) => element.id == event.category);
      subCategoryList = category.subCategoryList.toSet().toList();
      if (subCategoryList.isNotEmpty) {
        subCategory = subCategoryList[0];
        emit(state.copyWith(subCategoryId: '${subCategory?.id.toString()}'));
      } else {
        emit(state.copyWith(subCategoryId: ''));
      }
      emit(state.copyWith(categoryId: "${event.category}"));
    });

    on<NewEditAdEventSubCategory>((event, emit) {
      Brand brand = subCategoryList
          .singleWhere((element) => element.id == int.parse(event.subCategory));
      serviceTypeList = brand.serviceTypeList.toSet().toList();
      if (serviceTypeList.isNotEmpty) {
        serviceTypeModel = serviceTypeList[0];
        emit(state.copyWith(adsId: '${serviceTypeModel?.id.toString()}'));
      } else {
        emit(state.copyWith(adsId: ''));
      }

      brandList = brand.brandList.toSet().toList();
      if (brandList.isNotEmpty) {
        brandModel = brandList[0];
        emit(state.copyWith(brandId: '${brandModel?.id.toString()}'));
      } else {
        emit(state.copyWith(brandId: ''));
      }

      // subCategory = event.subCategoryData;
      emit(state.copyWith(subCategoryId: event.subCategory));
    });
    on<NewEditAdEventPhone>((event, emit) {
      emit(state.copyWith(phone: event.phone));
    });
    on<NewEditAdEventShowPhone>((event, emit) {
      emit(state.copyWith(isShowPhone: event.isShowPhone));
    });
    on<NewEditAdEventEmail>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<NewEditAdEventShowEmail>((event, emit) {
      emit(state.copyWith(isShowEmail: event.isShowEmail));
    });
    on<NewEditAdEventReceivedEmail>((event, emit) {
      emit(state.copyWith(isReceivedEmail: event.isReceivedEmail));
    });
    on<NewEditAdEventReceivedPhone>((event, emit) {
      emit(state.copyWith(isReceivedPhone: event.isReceivedPhone));
    });
    on<NewEditAdEventShowWhatsapp>((event, emit) {
      emit(state.copyWith(isShowWhatsapp: event.isShowWhatsapp));
    });
    on<NewEditAdEventWhatsapp>((event, emit) {
      emit(state.copyWith(whatsapp: event.whatsapp));
    });
    on<NewEditAdEventWebsite>((event, emit) {
      emit(state.copyWith(website: event.website));
    });
    on<NewEditAdEventDescription>((event, emit) {
      emit(state.copyWith(description: event.description));
    });
    on<NewEditAdEventFeature>((event, emit) {
      emit(state.copyWith(features: event.features));
    });
    on<NewEditAdEventLocation>((event, emit) {
      emit(state.copyWith(address: event.location));
    });
    on<NewEditAdEventImages>((event, emit) {
      emit(state.copyWith(images: event.images));
    });
    on<NewEditAdEventFeatureImage>((event, emit) {
      emit(state.copyWith(thumbnail: event.thumbnail));
    });
    on<NewEditAdEventDeleteImage>((event, emit) {
      emit(state.copyWith(deleteImage: event.imageIds));
    });

    on<NewEditAdEventExperience>((event, emit) {
      emit(state.copyWith(experience: event.value1));
    });
    on<NewEditAdEventEducations>((event, emit) {
      emit(state.copyWith(educations: event.value1));
    });
    on<NewEditAdEventDesignation>((event, emit) {
      emit(state.copyWith(designation: event.value1));
    });
    on<NewEditAdEventSalaryFrom>((event, emit) {
      emit(state.copyWith(salary_from: event.value1));
    });
    on<NewEditAdEventSalaryTo>((event, emit) {
      emit(state.copyWith(salary_to: event.value1));
    });
    on<NewEditAdEventDeadline>((event, emit) {
      emit(state.copyWith(deadline: event.value1));
    });
    on<NewEditAdEventEmployerName>((event, emit) {
      emit(state.copyWith(employer_name: event.value1));
    });
    on<NewEditAdEventEmploymentType>((event, emit) {
      emit(state.copyWith(job_type: event.value1));
    });
    on<NewEditAdEventStatusType>((event, emit) {
      emit(state.copyWith(status: event.value1));
    });
    on<NewEditAdEventEmployerWebsite>((event, emit) {
      emit(state.copyWith(employer_website: event.value1));
    });
    on<NewEditAdEventEmployeeLogo>((event, emit) {
      emit(state.copyWith(employer_logo: event.value1));
    });
    on<NewEditAdEventCondition>((event, emit) {
      emit(state.copyWith(condition: event.value1));
    });
    on<NewEditAdEventTextBookType>((event, emit) {
      emit(state.copyWith(textbookType: event.value1));
    });

    on<NewEditAdEventProductCountryId>((event, emit) {
      TopCountry countryModel = countryList
          .singleWhere((element) => element.id == int.parse(event.value1));
      stateList = countryModel.states.toSet().toList();
      if (stateList.isNotEmpty) {
        stateModel = stateList[0];
        emit(state.copyWith(stateId: '${stateModel?.id.toString()}'));
      } else {
        emit(state.copyWith(stateId: ''));
      }
      emit(state.copyWith(countryId: event.value1));
    });

    on<NewEditAdEventProductStateId>((event, emit) {
      StateModel stateModel = stateList
          .singleWhere((element) => element.id == int.parse(event.value1));
      cityList = stateModel.city.toSet().toList();
      if (cityList.isNotEmpty) {
        cityModel = cityList[0];
        emit(state.copyWith(cityId: '${cityModel?.id.toString()}'));
      } else {
        emit(state.copyWith(cityId: ''));
      }
      emit(state.copyWith(stateId: event.value1));
    });

    on<NewEditAdEventProductCityId>((event, emit) {
      cityModel = event.city;
      emit(state.copyWith(cityId: event.value1));
    });

    on<NewEditAdEventAuthenticity>((event, emit) {
      emit(state.copyWith(authenticity: event.value1));
    });
    on<NewEditAdEventEdition>((event, emit) {
      emit(state.copyWith(edition: event.value1));
    });
    on<NewEditAdEventProductModel>((event, emit) {
      emit(state.copyWith(model: event.value1));
    });
    on<NewEditAdEventProductBrandId>((event, emit) {
      emit(state.copyWith(brandId: event.value1));
    });
    on<NewEditAdEventServiceTypeId>((event, emit) {
      emit(state.copyWith(adsId: event.value1));
    });
    on<NewEditAdEventTrimEdition>((event, emit) {
      emit(state.copyWith(trim_edition: event.value1));
    });
    on<NewEditAdEventYearOfManufacture>((event, emit) {
      emit(state.copyWith(year_of_manufacture: event.value1));
    });
    on<NewEditAdEventEngineCapacity>((event, emit) {
      emit(state.copyWith(engine_capacity: event.value1));
    });
    on<NewEditAdEventTransmission>((event, emit) {
      emit(state.copyWith(transmission: event.value1));
    });
    on<NewEditAdEventRegistrationYear>((event, emit) {
      emit(state.copyWith(registration_year: event.value1));
    });
    on<NewEditAdEventBodyType>((event, emit) {
      emit(state.copyWith(body_type: event.value1));
    });
    on<NewEditAdEventFuelType>((event, emit) {
      emit(state.copyWith(vehicleFuleType: event.value1));
    });
    on<NewEditAdEventPropertyType>((event, emit) {
      emit(state.copyWith(property_type: event.value1));
    });
    on<NewEditAdEventSize>((event, emit) {
      emit(state.copyWith(size: event.value1));
    });
    on<NewEditAdEventSizeType>((event, emit) {
      emit(state.copyWith(size_type: event.value1));
    });
    on<NewEditAdEventPropertyLocation>((event, emit) {
      emit(state.copyWith(property_location: event.value1));
    });
    on<NewEditAdEventPriceType>((event, emit) {
      emit(state.copyWith(price_type: event.value1));
    });
    on<NewEditAdEventLoadOldData>(_loadOldData);
    on<NewEditAdEventSubmit>(_submitPostAdForm);
  }

  Future<void> _submitPostAdForm(
    NewEditAdEventSubmit event,
    Emitter<NewEditAdModalState> emit,
  ) async {
    if (!featureFormKey.currentState!.validate()) return;
    featureFormKey.currentState!.save();
    // print("logo"+ state.employer_logo);
    // print("data : ${state.toMap()}");
    // return;
    emit(state.copyWith(state: const NewEditAdStateLoading()));
    // final bodyData = state.toMap();
    // print(event.token);
    // print(event.id);

    final bodyData = state.toMap();
    print(event.token);

    print('Edit BodyData $bodyData');

    final result = await _postAdRepository.newAdEditSubmit(state,event.token,event.id.toString());

    result.fold(
      (Failure failure) {
        final error = NewEditAdStateError(failure.message, failure.statusCode);
        emit(state.copyWith(state: error));
      },
      (message) async {
        final loadedData = NewEditAdStateLoaded(message, true);
        titleController.text = '';
        priceController.text = '';
        phoneController.text = '';
        backupPhoneController.text = '';
        emailController.text = '';
        webSiteController.text = '';
        descriptionController.text = '';
        locationController.text = '';
        emit(state.copyWith(
            name: "",
            price: "",
            categoryId: '',
            subCategoryId: "",
            phone: "",
            isShowPhone: false,
            backupPhone: "",
            whatsapp: "",
            description: "",
            features: [],
            address: "",
            thumbnail: "",
            images: [],
            deleteImage: [],
            experience: '',
            educations: '',
            designation: '',
            salary_from: '',
            salary_to: '',
            deadline: '',
            employer_name: '',
            job_type: '',
            status: '',
            employer_website: '',
            employer_logo: '',
            condition: '',
            textbookType: '',
            authenticity: '',
            edition: '',
            model: '',
            brandId: '',
            trim_edition: '',
            year_of_manufacture: '',
            engine_capacity: '',
            transmission: '',
            registration_year: '',
            body_type: '',
            vehicleFuleType: [],
            property_type: '',
            size: '',
            size_type: 'sqft',
            property_location: '',
            price_type: 'total price',
            state: loadedData));
      },
    );
  }

  void _loadOldData(NewEditAdEventLoadOldData event,
      Emitter<NewEditAdModalState> emit) async {

    titleController.text = event.adModel.title;
    priceController.text = event.adModel.price.toString();
    phoneController.text = event.adModel.phone;
    emailController.text = event.adModel.email;
    backupPhoneController.text = event.adModel.phone2;
    webSiteController.text = event.adModel.website ?? '';
    whatsappController.text = event.adModel.whatsapp ?? '';
    descriptionController.text = event.adModel.description;
    locationController.text = event.adModel.address ?? '';
    modelController.text = event.adModel.model ?? '';

    subCategory = null;
    stateModel = null;
    brandModel = null;
    topCountry = null;
    cityModel = null;
    serviceTypeModel = null;

    experienceController.text = event.adModel.experience.toString() ?? '';
    employerNameController.text = event.adModel.employerName ?? '';
    deadlineController.text = event.adModel.deadline ?? '';
    salaryFromController.text = event.adModel.salaryFrom.toString() ?? '';
    salaryToController.text = event.adModel.salaryTo.toString() ?? '';

    trimEditionController.text = event.adModel.edition ?? '';
    yearOfManuController.text = event.adModel.vehicleManufacture ?? '';
    enginCapacityController.text = event.adModel.vehicleEngineCapacity ?? '';
    registrationYearController.text = event.adModel.registrationYear ?? '';

    ///load subcategory
    if (event.adModel.categoryId != 0) {
      // print('subcategory event ${event.adModel.categoryId} ${event.adModel.categoryId.runtimeType}');
      Category category = categoryList.singleWhere((element) => element.id == event.adModel.categoryId);
      this.category = category;
      subCategoryList = category.subCategoryList.toSet().toList();
      await Future.delayed(const Duration(milliseconds: 300)).then((value) {
        if (subCategoryList.isNotEmpty && event.adModel.subcategoryId != 0) {
          print('subcategory eventS ${event.adModel.subcategoryId} ${event.adModel.subcategoryId.runtimeType}');
          Brand brand = subCategoryList.singleWhere((element) => element.id == event.adModel.subcategoryId);
          subCategory = brand;
        } else {
          subCategory = null;
        }
      });
    }

    ///load country
    if (event.adModel.countryId != 0) {
      await Future.delayed(const Duration(milliseconds: 300)).then((value) {
        if (countryList.isNotEmpty) {
          TopCountry topCountry = countryList.singleWhere((element) => element.id == event.adModel.countryId);
          this.countryModel = countryModel;
          countryModel = topCountry;
        } else {
          countryModel = null;
        }
      });
    }

    ///load state
    if (event.adModel.countryId != 0) {
      TopCountry countryModel = countryList
          .singleWhere((element) => element.id == event.adModel.countryId);
      this.countryModel = countryModel;
      stateList = countryModel.states.toSet().toList();
      await Future.delayed(const Duration(milliseconds: 300)).then((value) {
        if (stateList.isNotEmpty && event.adModel.stateId != 0) {
          StateModel states = stateList
              .singleWhere((element) => element.id == event.adModel.stateId);
          stateModel = states;
        } else {
          stateModel = null;
        }
      });
    }

    ///load city
    if (event.adModel.stateId != 0) {
      StateModel stateModel = stateList
          .singleWhere((element) => element.id == event.adModel.stateId);
      // this.stateModel = stateModel;
      cityList = stateModel.city.toSet().toList();
      await Future.delayed(const Duration(milliseconds: 300)).then((value) {
        if (cityList.isNotEmpty && event.adModel.cityId != 0) {
          City city = cityList
              .singleWhere((element) => element.id == int.parse("${event.adModel.cityId}"));
          cityModel = city;
        } else {
          cityModel = null;
        }
      });
    }

    ///load brand
    if (event.adModel.subcategoryId != 0) {
      Brand subCategoryModel = subCategoryList
          .singleWhere((element) => element.id == event.adModel.subcategoryId);
      brandList = subCategoryModel.brandList.toSet().toList();

      await Future.delayed(const Duration(milliseconds: 300)).then((value) {
        print('brand event ${event.adModel.brandId} typr ${brandList.isNotEmpty}');
        if ((brandList.isNotEmpty && event.adModel.brandId != null)) {
          BrandModel brand = brandList
              .singleWhere((element) => element.id == event.adModel.brandId);
          brandModel = brand;
        } else {
          brandModel = null;
        }
      });
    }

    ///load serviceType
    if (event.adModel.subcategoryId != 0) {
      Brand subCategoryModel = subCategoryList
          .singleWhere((element) => element.id == event.adModel.subcategoryId);
      serviceTypeList = subCategoryModel.serviceTypeList.toSet().toList();

      await Future.delayed(const Duration(milliseconds: 300)).then((value) {
        print('serviceType event ${event.adModel.adsId} adsIdtypr ${event.adModel.adsId.runtimeType}');

        if (serviceTypeList.isNotEmpty && event.adModel.adsId.toString().isNotEmpty) {
          ServiceTypeModel serviceType = serviceTypeList
              .singleWhere((element) => element.id == int.parse(event.adModel.adsId));
          serviceTypeModel = serviceType;
        } else {
          serviceTypeModel = null;
        }
      });
    }

    List<String> features = [];

    features.addAll(event.adModel.adFeatures.map((e) => e.name).toList());

    emit(state.copyWith(
      name: event.adModel.title,
      isShowPhone: event.adModel.showPhone == 1 ? true : false,
      backupPhone: event.adModel.phone2,
      categoryId: "${event.adModel.categoryId}",
      subCategoryId: event.adModel.categoryId != 0 ? "${event.adModel.subcategoryId}" : '',
      adsId: event.adModel.adsId == null ? '' : event.adModel.adsId.toString(),
      countryId: "${event.adModel.countryId}"??'',
      stateId: "${event.adModel.stateId}" ??'',
      cityId: "${event.adModel.cityId}"??'',

      brandId: event.adModel.brandId == null ? '' : event.adModel.brandId.toString(),

      description: event.adModel.description,
      features: features,
      thumbnail: event.adModel.thumbnail,
      images: [],
      address: event.adModel.address,
      phone: event.adModel.phone,
      email: event.adModel.email,
      isShowEmail: event.adModel.showEmail == '1' ? true : false,
      isShowWhatsapp: event.adModel.showWhatsapp == '1' ? true : false,
      isReceivedEmail: event.adModel.receiveIsEmail == '1' ? true : false,
      isReceivedPhone: event.adModel.receiveIsPhone == '1' ? true : false,
      price: event.adModel.price.toString(),
      whatsapp: event.adModel.whatsapp,

      experience: event.adModel.experience is int
          ? "${event.adModel.experience}".toString()
          : event.adModel.experience ?? '',
      educations: event.adModel.required_education ?? '',
      designation: event.adModel.designation ?? '',
      salary_from: event.adModel.salaryFrom is int
          ? "${event.adModel.salaryFrom}".toString()
          : event.adModel.salaryFrom ?? '',
      salary_to: event.adModel.salaryTo is int
          ? "${event.adModel.salaryTo}".toString()
          : event.adModel.salaryTo ?? '',
      deadline: event.adModel.deadline ?? '',
      employer_name: event.adModel.employerName ?? '',
      job_type: event.adModel.jobType ?? '',
      employer_logo: event.adModel.employerLogo ?? '',
      condition: event.adModel.condition ?? '',
      textbookType: event.adModel.textbookType ?? '',

      authenticity: event.adModel.authenticity ?? '',
      edition: event.adModel.edition ?? '',
      trim_edition: event.adModel.edition ?? '',
      year_of_manufacture: event.adModel.vehicleManufacture ?? '',
      engine_capacity: event.adModel.vehicleEngineCapacity ?? '',
      transmission: event.adModel.vehicleTransmission ?? '',
      registration_year: event.adModel.registrationYear ?? '',
      body_type: event.adModel.vehicleBodyType ?? '',
      vehicleFuleType: event.adModel.vehicleFuleType ?? [],
      size: event.adModel.propertySize ?? '',
      size_type: event.adModel.propertyUnit ?? '',
      property_location: event.adModel.address ?? '',
      price_type: event.adModel.propertyPriceType ?? '',

      state: const NewEditAdStateLoaded("", false),
    ));
  }

  void _clearAll(
    NewEditAdEventEmpty event,
    Emitter<NewEditAdModalState> emit,
  ) async {
    titleController.text = '';
    priceController.text = '';
    phoneController.text = '';
    backupPhoneController.text = '';
    emailController.text = '';
    webSiteController.text = '';
    descriptionController.text = '';
    locationController.text = '';
    modelController.text = '';

    experienceController.text = '';
    employerWebsiteController.text = '';
    employerNameController.text = '';
    deadlineController.text = '';
    salaryFromController.text = '';
    salaryToController.text = '';

    trimEditionController.text = '';
    yearOfManuController.text = '';
    enginCapacityController.text = '';
    registrationYearController.text = '';

    emit(state.copyWith(
        name: '',
        thumbnail: '',
        isShowWhatsapp: false,
        price: '',
        categoryId: '',
        subCategoryId: '',
        phone: '',
        isShowPhone: false,
        isReceivedEmail: false,
        isReceivedPhone: false,

        email: '',
        isShowEmail: false,
        backupPhone: '',
        website: '',
        whatsapp: '',
        description: '',
        features: [],
        address: '',
        images: [],
        adsId: '',
        countryId: '',
        stateId: '',
        cityId: '',
        experience: '',
        educations: '',
        designation: '',
        salary_from: '',
        salary_to: '',
        deadline: '',
        employer_name: '',
        job_type: '',
        status: '',
        employer_website: '',
        employer_logo: '',
        condition: '',
        textbookType: '',
        authenticity: '',
        edition: '',
        model: '',
        brandId: '',
        trim_edition: '',
        year_of_manufacture: '',
        engine_capacity: '',
        transmission: '',
        registration_year: '',
        body_type: '',
        vehicleFuleType: [],
        property_type: '',
        size: '',
        size_type: 'sqft',
        property_location: '',
        price_type: 'total price',
        state: const NewEditAdStateInitial()));
  }
}
