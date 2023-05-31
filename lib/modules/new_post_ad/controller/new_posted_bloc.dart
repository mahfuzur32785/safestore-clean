import 'dart:convert';

import 'package:safestore/modules/ad_details/model/ad_details_model.dart';
import 'package:safestore/modules/home/model/category_model.dart';
import 'package:safestore/modules/home/model/city_model.dart';
import 'package:safestore/modules/home/model/country_model.dart';
import 'package:safestore/modules/home/model/pricing_model.dart';
import 'package:safestore/modules/home/model/service_type.dart';
import 'package:safestore/modules/home/model/state_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:safestore/modules/home/controller/cubit/home_controller_cubit.dart';
import 'package:safestore/modules/post_ad/controller/postad_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../home/model/brand_model.dart';
import '../../home/model/model_model.dart';

part 'new_postad_event.dart';
part 'new_postad_state.dart';

class NewPostAdBloc extends Bloc<NewPostAdEvent, NewPostAdModalState> {
  final PostAdRepository _postAdRepository;
  final HomeControllerCubit _homeControllerCubit;
  final featureFormKey = GlobalKey<FormState>();
  bool isPaymentChecked = false;

  String price = '';
  int id = 0;
  String title = '';

  List<Category> get categoryList => _homeControllerCubit.homeModel.categories.reversed.toList();

  List<Brand> subCategoryList = [];
  Brand? subCategory;

  // List<BrandModel> get brandList => _homeControllerCubit.homeModel.brandList.where((element) => element.categoryId.toString() == state.category).toList();
  // List<Model> get serviceTypeList => _homeControllerCubit.homeModel.serviceTypeList;

  List<PricingModel> get pricingList => _homeControllerCubit.homeModel.plans;
  List<Model> get designationList => _homeControllerCubit.homeModel.designations.toList();

  List<TopCountry> get countryList => _homeControllerCubit.homeModel.topCountries.reversed.toList();

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
  var locationController = TextEditingController(text: "");
  var phoneController = TextEditingController(text: "");
  var emailController = TextEditingController(text: "");
  var backupPhoneController = TextEditingController(text: "");
  var whatsappController = TextEditingController(text: "");
  var descriptionController = TextEditingController(text: "");
  var webSiteController = TextEditingController(text: "");
  var editionController = TextEditingController(text: "");
  var modelController = TextEditingController(text: "");
  var employerNameController = TextEditingController(text: "");
  var employerPhoneController = TextEditingController(text: "");
  var employerEmailController = TextEditingController(text: "");

  NewPostAdBloc({
    required PostAdRepository postAdRepository,
    required HomeControllerCubit homeControllerCubit,
  })  : _postAdRepository = postAdRepository,
        _homeControllerCubit = homeControllerCubit,
        super(const NewPostAdModalState()) {

    on<NewPostAdEventEmpty>(_clearAll);
    on<NewPostAdEventTitle>((event, emit) {
      emit(state.copyWith(title: event.title));
    });
    on<NewPostAdEventPrice>((event, emit) {
      emit(state.copyWith(price: event.price));
    });
    on<NewPostAdEventCategory>((event, emit) {
      Category category = categoryList.singleWhere((element) => element.id == int.parse(event.category));
      subCategoryList = category.subCategoryList.toSet().toList();
      if (subCategoryList.isNotEmpty) {
        subCategory = subCategoryList[0];
        emit(state.copyWith(subCategory: '${subCategory?.id.toString()}'));
      } else {
        emit(state.copyWith(subCategory: ''));
      }
      emit(state.copyWith(category: event.category));
    });

    on<NewPostAdEventSubCategory>((event, emit) {
      Brand brand = subCategoryList.singleWhere((element) => element.id == int.parse(event.subCategory));
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
      emit(state.copyWith(subCategory: event.subCategory));
    });



    on<NewPostAdEventPhone>((event, emit) {
      emit(state.copyWith(phone: event.phone));
    });
    on<NewPostAdEventShowPhone>((event, emit) {
      emit(state.copyWith(isShowPhone: event.isShowPhone));
    });
    on<NewPostAdEventEmail>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<NewPostAdEventEmployerEmail>((event, emit) {
      emit(state.copyWith(employerEmail: event.email));
    });
    on<NewPostAdEventEmployerPhone>((event, emit) {
      emit(state.copyWith(employerPhone: event.employerPhone));
    });
    on<NewPostAdEventWebsite>((event, emit) {
      emit(state.copyWith(website: event.website));
    });
    on<NewPostAdEventShowEmail>((event, emit) {
      emit(state.copyWith(isShowEmail: event.isShowEmail));
    });
    on<NewPostAdEventApplicationReceivedInEmail>((event, emit) {
      emit(state.copyWith(receiveIsEmail: event.value1));
    });
    on<NewPostAdEventApplicationReceivedInPhone>((event, emit) {
      emit(state.copyWith(receiveIsPhone: event.value1));
    });
    on<NewPostAdEventBackupPhone>((event, emit) {
      emit(state.copyWith(backupPhone: event.backupPhone));
    });
    on<NewPostAdEventWhatsapp>((event, emit) {
      emit(state.copyWith(whatsapp: event.whatsapp));
    });
    on<NewPostAdEventShowWhatsapp>((event, emit) {
      emit(state.copyWith(isShowWhatsapp: event.isShowWhatsapp));
    });
    on<NewPostAdEventIsChecked>((event, emit) {
      emit(state.copyWith(isFeatured: event.isChecked));
    });
    on<NewPostAdEventDescription>((event, emit) {
      emit(state.copyWith(description: event.description));
    });
    on<NewPostAdEventFeature>((event, emit) {
      emit(state.copyWith(features: event.features));
    });
    on<NewPostAdEventAddress>((event, emit) {
      emit(state.copyWith(address: event.address));
    });
    on<NewPostAdEventLatLng>((event, emit) {
      emit(state.copyWith(lat: event.lat, long: event.long));
    });
    on<NewPostAdEventImages>((event, emit) {
      emit(state.copyWith(images: event.images));
    });
    on<NewPostAdEventFeatureImage>((event, emit) {
      emit(state.copyWith(thumbnail: event.thumbnail));
    });
    on<NewPostAdEventBrand>((event, emit) {
      emit(state.copyWith(brand: event.brand));
    });

    on<NewPostAdEventProductBrandId>((event, emit) {
      emit(state.copyWith(brandId: event.value1));
    });
    on<NewPostAdEventServiceTypeId>((event, emit) {
      emit(state.copyWith(adsId: event.value1));
    });
    on<NewPostAdEventExperience>((event, emit) {
      emit(state.copyWith(experience: event.value1));
    });
    on<NewPostAdEventEducations>((event, emit) {
      emit(state.copyWith(educations: event.value1));
    });
    on<NewPostAdEventDesignationId>((event, emit) {
      emit(state.copyWith(designation_id: event.value1));
    });
    on<NewPostAdEventSalaryFrom>((event, emit) {
      emit(state.copyWith(salary_from: event.value1));
    });
    on<NewPostAdEventSalaryTo>((event, emit) {
      emit(state.copyWith(salary_to: event.value1));
    });
    on<NewPostAdEventDeadline>((event, emit) {
      emit(state.copyWith(deadline: event.value1));
    });
    on<NewPostAdEventEmployerName>((event, emit) {
      emit(state.copyWith(employer_name: event.value1));
    });
    on<NewPostAdEventEmployerDesignation>((event, emit) {
      emit(state.copyWith(designation: event.designation));
    });
    on<NewPostAdEventEmploymentType>((event, emit) {
      emit(state.copyWith(employment_type: event.value1));
    });
    on<NewPostAdEventJobType>((event, emit) {
      emit(state.copyWith(job_type: event.value1));
    });
    on<NewPostAdEventEmployerWebsite>((event, emit) {
      emit(state.copyWith(employer_website: event.value1));
    });
    on<NewPostAdEventEmployeeLogo>((event, emit) {
      emit(state.copyWith(employerLogo: event.value1));
    });
    on<NewPostAdEventCondition>((event, emit) {
      emit(state.copyWith(condition: event.value1));
    });
    on<NewPostAdEventAuthenticity>((event, emit) {
      emit(state.copyWith(authenticity: event.value1));
    });
    on<NewPostAdEventTextBookType>((event, emit) {
      emit(state.copyWith(textBookType: event.value1));
    });
    on<NewPostAdEventRam>((event, emit) {
      emit(state.copyWith(ram: event.value1));
    });
    on<NewPostAdEventProductModel>((event, emit) {
      emit(state.copyWith(model: event.value1));
    });

    on<NewPostAdEventProductCountryId>((event, emit) {
      TopCountry countryModel = countryList.singleWhere((element) => element.id == int.parse(event.value1));
      stateList = countryModel.states.toSet().toList();
    if (stateList.isNotEmpty) {
      stateModel = stateList[0];
      emit(state.copyWith(stateId: '${stateModel?.id.toString()}'));
    } else {
      emit(state.copyWith(stateId: ''));
    }

      cityList = stateModel!.city.toSet().toList();
      if (cityList.isNotEmpty) {
        cityModel = cityList[0];
        emit(state.copyWith(cityId: '${cityModel?.id.toString()}'));
      } else {
        emit(state.copyWith(cityId: ''));
      }

    emit(state.copyWith(countryId: event.value1));
    });

    on<NewPostAdEventProductStateId>((event, emit) {
      StateModel stateModel = stateList.singleWhere((element) => element.id == int.parse(event.value1));
      cityList = stateModel.city.toSet().toList();
    if (cityList.isNotEmpty) {
      cityModel = cityList[0];
      emit(state.copyWith(cityId: '${cityModel?.id.toString()}'));
    } else {
      emit(state.copyWith(cityId: ''));
    }
    emit(state.copyWith(stateId: event.value1));
    });

    on<NewPostAdEventProductCityId>((event, emit) {
      cityModel = event.city;
      emit(state.copyWith(cityId: event.value1));
    });

    on<NewPostAdEventProcessor>((event, emit) {
      emit(state.copyWith(processor: event.value1));
    });
    on<NewPostAdEventEdition>((event, emit) {
      emit(state.copyWith(edition: event.value1));
    });
    on<NewPostAdEventYearOfManufacture>((event, emit) {
      emit(state.copyWith(vehicle_manufacture: event.value1));
    });
    on<NewPostAdEventEngineCapacity>((event, emit) {
      emit(state.copyWith(vehicle_engine_capacity: event.value1));
    });
    on<NewPostAdEventTransmission>((event, emit) {
      emit(state.copyWith(transmission: event.transmission));
    });
    on<NewPostAdEventRegistrationYear>((event, emit) {
      emit(state.copyWith(registration_year: event.value1));
    });
    on<NewPostAdEventBodyType>((event, emit) {
      emit(state.copyWith(vehicle_body_type: event.value1));
    });
    on<NewPostAdEventFuelType>((event, emit) {
      emit(state.copyWith(vehicle_fule_type: event.value1));
    });
    on<NewPostAdEventPropertyType>((event, emit) {
      emit(state.copyWith(property_type: event.value1));
    });
    on<NewPostAdEventBedroom>((event, emit) {
      emit(state.copyWith(bedroom: event.value1));
    });
    on<NewPostAdEventSize>((event, emit) {
      emit(state.copyWith(size: event.value1));
    });
    on<NewPostAdEventSizeType>((event, emit) {
      emit(state.copyWith(size_type: event.value1));
    });
    on<NewPostAdEventPropertyLocation>((event, emit) {
      emit(state.copyWith(property_location: event.value1));
    });
    on<NewPostAdEventPriceType>((event, emit) {
      emit(state.copyWith(price_type: event.value1));
    });
    on<NewPostAdEventAnimalType>((event, emit) {
      emit(state.copyWith(animal_type: event.value1));
    });

    // on<NewPostAdEventCustomFieldDataMap>((event, emit) {
    //   emit(state.copyWith(customFields: event.data));
    // });
    // on<NewPostAdEventGetCustomFieldData>(_getCustomFieldsData);
    on<NewPostAdEventSubmit>(submitPostAdForm);

  }


  Future<void> submitPostAdForm(
      NewPostAdEventSubmit event,
      Emitter<NewPostAdModalState> emit,
      ) async {
    if (!featureFormKey.currentState!.validate()) return;
    featureFormKey.currentState!.save();
    emit(state.copyWith(state: const NewPostAdStateLoading()));
    final bodyData = state.toMap();
    print(event.token);
    print("Bodydata: $bodyData");

    final result = await _postAdRepository.newPostAdSubmit(state,event.token);

    result.fold(
          (Failure failure) {
        final error = NewPostAdStateError(failure.message, failure.statusCode);
        emit(state.copyWith(state: error));
      },
          (message) async {
        final loadedData = NewPostAdStateLoaded(message: "Ad Post Successfully", adDetails: message);
        titleController.text = '';
        priceController.text = '';
        locationController.text = '';
        phoneController.text = '';
        backupPhoneController.text = '';
        emailController.text = '';
        whatsappController.text = '';
        descriptionController.text = '';
        webSiteController.text = '';
        editionController.text = '';
        modelController.text = '';
        employerNameController.text = '';
        employerPhoneController.text = '';
        employerEmailController.text = '';
        stateModel = null;
        cityModel = null;
        emit(state.copyWith(
            title: "",
            category: "",
            subCategory: "",
            stateId: '',
            countryId: '',
            cityId: '',
            phone: "",
            isShowPhone: false,
            isShowEmail: false,
            isShowWhatsapp: false,
            receiveIsEmail: false,
            receiveIsPhone: false,
            backupPhone: "",
            whatsapp: "",
            description: "",
            features: [],
            address: "",
            images: [],
            brand: "",
            service_type_id: '',
            experience: '',
            educations: '',
            designation_id: '',
            designation:'',

            salary_from: '',
            salary_to: '',
            deadline: '',
            employer_name: '',
            employment_type: '',
            job_type: '',
            employer_website: '',
            application_received: '',
            email: '',
            employerEmail: '',
            employerPhone: '',
            employer_logo: '',
            condition: '',
            authenticity: '',
            textBookType: '',
            ram: '',
            model:'',
            brandId:'',
            processor:'',
            edition:'',
            vehicle_manufacture:'',
            vehicle_engine_capacity:'',
            transmission:'',
            registration_year:'',
            vehicle_body_type:'',
            vehicle_fule_type: [],
            property_type:'',
            bedroom:'',
            size:'',
            size_type: 'sqft',
            property_location:'',
            price_type: 'total price',
            animal_type: '',
            state: loadedData));
      },
    );
  }

  void _clearAll(
      NewPostAdEventEmpty event,
      Emitter<NewPostAdModalState> emit,
      ) async {
    titleController.text = '';
    priceController.text = '';
    locationController.text = '';
    phoneController.text = '';
    backupPhoneController.text = '';
    emailController.text = '';
    whatsappController.text = '';
    descriptionController.text = '';
    webSiteController.text = '';
    editionController.text = '';
    modelController.text = '';
    employerNameController.text = '';
    employerPhoneController.text = '';
    employerEmailController.text = '';
    stateModel = null;
    cityModel = null;
    emit(state.copyWith(
        title: '',
        category: '',
        subCategory: '',
        phone: '',
        isShowPhone: false,
        email: '',
        isShowEmail: false,
        isShowWhatsapp: false,
        receiveIsEmail: false,
        receiveIsPhone: false,
        isPaymentChecked: false,
        backupPhone: '',
        whatsapp: '',
        description: '',
        features: [],
        address: '',
        images: [],
        brand: '',
        service_type_id: '',
        experience: '',
        educations: '',
        designation_id: '',
        adsId: '',
        countryId: '',
        stateId: '',
        cityId: '',
        designation:'',
        salary_from: '',
        salary_to: '',
        deadline: '',
        employer_name: '',
        employment_type: '',
        job_type: '',
        employer_website: '',
        employer_logo: '',
        condition: '',
        authenticity: '',
        textBookType: '',
        application_received: '',
        employerEmail: '',
        employerPhone: '',
        ram: '',
        model:'',
        brandId:'',
        processor:'',
        edition:'',
        vehicle_manufacture:'',
        vehicle_engine_capacity:'',
        transmission:'',
        registration_year:'',
        vehicle_body_type:'',
        vehicle_fule_type: [],
        property_type:'',
        bedroom:'',
        size:'',
        size_type: 'sqft',
        property_location:'',
        price_type: 'total price',
        animal_type: '',
        state: const NewPostAdStateInitial()));
  }
}
