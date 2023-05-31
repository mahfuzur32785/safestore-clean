import 'dart:convert';
import 'dart:io';

import 'package:safestore/modules/home/model/city_model.dart';
import 'package:safestore/modules/home/model/country_model.dart';
import 'package:safestore/modules/home/model/pricing_model.dart';
import 'package:safestore/modules/home/model/state_model.dart';
import 'package:safestore/modules/new_post_ad/component/category_fileds/education_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safestore/modules/home/model/category_model.dart';
import 'package:safestore/modules/new_post_ad/component/category_fileds/jobs.dart';


import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../controller/new_posted_bloc.dart';
import 'category_fileds/electronics.dart';
import 'category_fileds/mobile_phones.dart';
import 'category_fileds/property.dart';
import 'category_fileds/service_field.dart';
import 'category_fileds/vehicles.dart';

class NewBasicInfoView extends StatefulWidget {
  const NewBasicInfoView({Key? key}) : super(key: key);

  @override
  State<NewBasicInfoView> createState() => _NewBasicInfoViewState();
}

class _NewBasicInfoViewState extends State<NewBasicInfoView> {

  bool isFeature = false;

  Brand? subCategory;

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewPostAdBloc>();
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          sliver: SliverToBoxAdapter(
            child: Form(
              key: postAdBloc.featureFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///title
                  Row(
                    children: [
                      Text("Title"),
                      Text("*",style: const TextStyle(color: Colors.red),),
                    ],
                  ),
                  const SizedBox(height: 6,),
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                    buildWhen: (previous, current) => previous.title != current.title,
                    builder: (context, state) {
                      return TextFormField(
                        keyboardType: TextInputType.name,
                        // initialValue: state.name,
                        controller: postAdBloc.titleController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter title';
                          }
                          return null;
                        },
                        onChanged: (value) => postAdBloc.add(NewPostAdEventTitle(value)),
                        decoration: const InputDecoration(hintText: "Title"),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  ///sub-category
                  Text("Sub Category"),
                  const SizedBox(height: 6,),
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                      buildWhen: (previous, current) => previous.subCategory != current.subCategory,
                      builder: (context, state) {
                        return DropdownButtonFormField<Brand>(
                          isExpanded: true,
                          decoration: const InputDecoration(
                            hintText: "Sub Category",
                          ),
                          value: postAdBloc.subCategory,
                          items: postAdBloc.subCategoryList.map<DropdownMenuItem<Brand>>((e) {
                            return DropdownMenuItem<Brand>(
                              value: e,
                              child: Text(e.name),
                            );
                          }).toList(),

                          onChanged: (Brand? value) {
                            setState(() {
                              subCategory = null;
                            });
                            postAdBloc.add(NewPostAdEventSubCategory(value!.id.toString(),value));
                          },
                        );
                      }
                  ),
                  const SizedBox(height: 16),

                  ///Country
                  Text(
                    "Country",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 7),
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                    buildWhen: (previous, current) => previous.countryId != current.countryId,
                    builder: (context, state) {
                      return DropdownButtonFormField(
                        validator: (value) {
                          if (value == null) {
                            return null;
                          }
                          return null;
                        },
                        isExpanded: true,
                        decoration: const InputDecoration(
                          hintText: "Select Country",
                        ),
                        items:
                        postAdBloc.countryList.map<DropdownMenuItem<TopCountry>>((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          Future.delayed(const Duration(milliseconds: 300))
                              .then((value2) {
                            postAdBloc
                                .add(NewPostAdEventProductCountryId(value!.id.toString()));
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16,),

                  ///States
                  Text(
                    "States",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 7),
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                    buildWhen: (previous, current) =>
                    previous.stateId != current.stateId,
                    builder: (context, state) {
                      return DropdownButtonFormField(
                        value: postAdBloc.stateModel,
                        validator: (value) {
                          if (value == null) {
                            return null;
                          }
                          return null;
                        },
                        isExpanded: true,
                        decoration: const InputDecoration(
                          hintText: "Select State",
                        ),
                        items: postAdBloc.stateList.map<DropdownMenuItem<StateModel>>((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          postAdBloc.add(NewPostAdEventProductStateId(value!.id.toString(),value));
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  ///City
                  Text(
                    "City",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 7),
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                    buildWhen: (previous, current) =>
                    previous.cityId != current.cityId,
                    builder: (context, state) {
                      return DropdownButtonFormField(
                        value: postAdBloc.cityModel,
                        validator: (value) {
                          if (value == null) {
                            return null;
                          }
                          return null;
                        },
                        isExpanded: true,
                        decoration: const InputDecoration(
                          hintText: "Select City",
                        ),
                        items: postAdBloc.cityList.map<DropdownMenuItem<City>>((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          postAdBloc.add(NewPostAdEventProductCityId(value!.id.toString(),value));
                        },
                      );
                    },
                  ),

                  ///Price
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                    buildWhen: (previous, current) => previous.category != current.category,
                    builder: (context, state) {
                      if (state.category != '18' && state.category != '10' && state.category != '9') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Text("Price"),
                            const SizedBox(height: 6,),
                            BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                              buildWhen: (previous, current) => previous.price != current.price,
                              builder: (context, state) {
                                return TextFormField(
                                  keyboardType: TextInputType.number,
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
                                  // initialValue: state.price,
                                  controller: postAdBloc.priceController,
                                  textInputAction: TextInputAction.next,
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return null;
                                  //   }
                                  //   return null;
                                  // },
                                  onChanged: (value) => postAdBloc.add(NewPostAdEventPrice(value)),
                                  decoration: const InputDecoration(hintText: "Price"),
                                );
                              },
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),

                  ///Address
                  const SizedBox(height: 16),
                  Text("Address"),
                  const SizedBox(height: 6,),
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                    buildWhen: (previous, current) => previous.address != current.address,
                    builder: (context, state) {
                      return TextFormField(
                        keyboardType: TextInputType.text,
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.digitsOnly
                        // ],
                        // initialValue: state.price,
                        controller: postAdBloc.locationController,
                        textInputAction: TextInputAction.next,
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return null;
                        //   }
                        //   return null;
                        // },
                        onChanged: (value) => postAdBloc.add(NewPostAdEventAddress(value)),
                        decoration: const InputDecoration(hintText: "Address"),
                      );
                    },
                  ),



                  ///Category wise design start from here
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                    buildWhen: (previous, current) => previous.category != current.category,
                    builder: (context, state) {

                      print('Category id ${state.category}  type ${state.category.runtimeType}');

                      if (state.category == '22') {
                        return const AutoMobileField(categoryId: '22');
                      }
                      if (state.category == '9') {
                        return const PropertyField();
                      }
                      if (state.category == '3') {
                        return const MobilePhonesField();
                      }
                      if (state.category == '7') {
                        return const ElectronicsField();
                      }
                      if (state.category == '18') {
                        return const JobsField();
                      }
                      if (state.category == '13') {
                        return const EducationField();
                      }
                      if (state.category == '19'|| state.category == "20") {
                        return const ServiceField();
                      }
                      return const SizedBox();
                    },
                  ),

                  ///Description and image section

                  ///Description
                  const SizedBox(height: 16,),
                  Row(
                    children: const [
                      Text("Description"),
                      Text("*",style: TextStyle(color: Colors.red),),
                    ],
                  ),
                  const SizedBox(height: 6),
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                    buildWhen: (previous, current) =>
                    previous.description != current.description,
                    builder: (context, state) {
                      return TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                        // initialValue: state.description,
                        controller: postAdBloc.descriptionController,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          }
                          return null;
                        },
                        onChanged: (value) =>
                            postAdBloc.add(NewPostAdEventDescription(value)),
                        decoration:
                        const InputDecoration(hintText: "Description"),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  const Text("Featured Image"),
                  const SizedBox(height: 6),
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                    buildWhen: (previous, current) =>
                    previous.thumbnail != current.thumbnail,
                    builder: (context, state) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              pickImage().then((value) {
                                print("Image value us $value");
                                postAdBloc.add(NewPostAdEventFeatureImage(value ?? ''));
                              });
                            },
                            child: Container(
                              width: 150,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blueGrey.shade100,
                              ),
                              alignment: Alignment.center,
                              child: const Text("Choose File"),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          featureImage != null ? Expanded(child: SizedBox(child: Text("$base64featureImage", overflow: TextOverflow.ellipsis,),)) : Container(),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  ///Images
                  const Text("Gallery Images  (Can add up to 5 only photos)"),
                  const SizedBox(height: 16),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (_, index) {
                      if (index == 0) {
                        return Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(3),
                            onTap: () {
                              pickImages().then((value) {
                                postAdBloc.add(NewPostAdEventImages(value ?? []));
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: ashColor),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add_circle_outlined,
                                  color: redColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: Container(
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              color: ashTextColor.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(3)),
                          child: Image(
                            // image: FileImage(File(controller.images2![index].path))
                            image: FileImage(File(images![index - 1].path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    itemCount: images!.length + 1,
                  ),

                  ///Contact info phone email
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                    buildWhen: (previous, current) => previous.category != current.category,
                    builder: (context, state) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Text("Contact Information",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                            const SizedBox(
                              height: 16,
                            ),
                            ///Phone
                            Row(
                              children: [
                                BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                                    buildWhen: (previous, current) => previous.isShowPhone != current.isShowPhone,
                                    builder: (context, state) {
                                      print("Show phone value ${state.isShowPhone}");
                                      return SizedBox(
                                        width: 30,
                                        height: 24,
                                        child: Checkbox(
                                            value: state.isShowPhone,
                                            onChanged: (value){
                                              postAdBloc.add(NewPostAdEventShowPhone(value!));
                                            },activeColor: const Color(0xFF0b5ed7),),
                                      );
                                    }
                                ),
                                const SizedBox(width: 0,),
                                Text("Show phone to public",style: const TextStyle(fontSize: 16),),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                              buildWhen: (previous, current) => previous.isShowPhone != current.isShowPhone,
                              builder: (context, state) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Phone",style: const TextStyle(fontSize: 16),),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                                      buildWhen: (previous, current) => previous.phone != current.phone,
                                      builder: (context, state) {
                                        return TextFormField(
                                          keyboardType: TextInputType.number,
                                          // initialValue: state.phone,
                                          controller: postAdBloc.phoneController,
                                          textInputAction: TextInputAction.next,
                                          // validator: (value) {
                                          //   if (value == null && state.isShowPhone) {
                                          //     return "Phone field is required";
                                          //   }
                                          //   return null;
                                          // },
                                          onChanged: (value) => postAdBloc.add(NewPostAdEventPhone(value)),
                                          decoration: InputDecoration(hintText: "Phone"),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                );
                              },
                            ),

                            ///Email
                            Row(
                              children: [
                                BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                                    buildWhen: (previous, current) => previous.isShowEmail != current.isShowEmail,
                                    builder: (context, state) {
                                      print("Show Email value ${state.isShowEmail}");
                                      return SizedBox(
                                        width: 30,
                                        height: 24,
                                        child: Checkbox(
                                            value: state.isShowEmail,
                                            onChanged: (value){
                                              postAdBloc.add(NewPostAdEventShowEmail(value!));
                                            },activeColor: const Color(0xFF0b5ed7),),
                                      );
                                    }
                                ),
                                const SizedBox(width: 0,),
                                Text("Show email to public",style: const TextStyle(fontSize: 16),),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                              buildWhen: (previous, current) => previous.isShowEmail != current.isShowEmail,
                              builder: (context, state) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Email",style: const TextStyle(fontSize: 16),),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                                      buildWhen: (previous, current) => previous.email != current.email,
                                      builder: (context, state) {
                                        return TextFormField(
                                          keyboardType: TextInputType.emailAddress,
                                          // initialValue: state.phone,
                                          controller: postAdBloc.emailController,
                                          textInputAction: TextInputAction.next,
                                          // validator: (value) {
                                          //   if (value == null && state.isShowEmail) {
                                          //     return "Email field is required";
                                          //   }
                                          //   return null;
                                          // },
                                          onChanged: (value) => postAdBloc.add(NewPostAdEventEmail(value)),
                                          decoration: InputDecoration(hintText: "Email"),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                );
                              },
                            ),

                            ///Whatsapp
                            Row(
                              children: [
                                BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                                    buildWhen: (previous, current) => previous.isShowWhatsapp != current.isShowWhatsapp,
                                    builder: (context, state) {
                                      print("Show Whatsapp value ${state.isShowWhatsapp}");
                                      return SizedBox(
                                        width: 30,
                                        height: 24,
                                        child: Checkbox(
                                            value: state.isShowWhatsapp,
                                            onChanged: (value){
                                              postAdBloc.add(NewPostAdEventShowWhatsapp(value!));
                                            },activeColor: const Color(0xFF0b5ed7),),
                                      );
                                    }
                                ),
                                const SizedBox(width: 0,),
                                Text("Show Whatsapp to public",style: const TextStyle(fontSize: 16),),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                              buildWhen: (previous, current) => previous.isShowWhatsapp != current.isShowWhatsapp,
                              builder: (context, state) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Whatsapp",style: const TextStyle(fontSize: 16),),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                                      buildWhen: (previous, current) => previous.whatsapp != current.whatsapp,
                                      builder: (context, state) {
                                        return TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: postAdBloc.whatsappController,
                                          textInputAction: TextInputAction.next,
                                          onChanged: (value) => postAdBloc.add(NewPostAdEventWhatsapp(value)),
                                          decoration: InputDecoration(hintText: "Whatsapp"),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        );
                    },
                  ),

                  ///Website
                  BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
                    buildWhen: (previous, current) => previous.category != current.category,
                    builder: (context, state) {
                      if (state.category != '18') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Website"),
                            const SizedBox(height: 6,),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: postAdBloc.webSiteController,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) => postAdBloc.add(NewPostAdEventWebsite(value)),
                              decoration: const InputDecoration(hintText: "Website"),
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  ///Payment for feature ads
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade300,
                    ),
                    child: Row(
                      children: [
                        Checkbox(value: postAdBloc.isPaymentChecked, onChanged: (value) {
                          setState(() {
                            postAdBloc.isPaymentChecked = !postAdBloc.isPaymentChecked;
                            print("Payment is Checked ${postAdBloc.isPaymentChecked}");
                          });
                          postAdBloc.add(NewPostAdEventIsChecked(value!));
                        },activeColor: const Color(0xFF0b5ed7),),
                        const SizedBox(width: 5,),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Mark as featured \$ ${postAdBloc.price}.00",style: TextStyle(fontWeight: FontWeight.bold),),
                                const SizedBox(
                                    child: Text("Make your listing unique on home and search page!",overflow: TextOverflow.ellipsis,maxLines: 2,)),
                                const SizedBox(height: 10,),

                                DropdownButtonFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      return null;
                                    }
                                    return null;
                                  },
                                  isExpanded: true,
                                  decoration: const InputDecoration(
                                    hintText: "Select Plan",
                                  ),
                                  items:
                                  postAdBloc.pricingList.map<DropdownMenuItem<PricingModel>>((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text("${e.title} for \$${e.price}.00"),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      postAdBloc.id = value!.id;
                                      postAdBloc.title = value.title;
                                      postAdBloc.price = value.price;
                                    });
                                  },
                                )

                                /*Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300)
                                  ),
                                  child: const Text("1 week for R177.00"),
                                )*/
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  bool isPayment = false;

  //.............. contacts info ....................
  List<String> featureList = [""];
  var contactController = TextEditingController();
  void addContact() {
    setState(() {
      featureList.add("");
    });
  }

  void removeContact(index) {
    setState(() {
      featureList.removeAt(index);
    });
  }

  String getPosition(index) {
    switch (index) {
      case 1:
        return "Enter 1st Feature";
      case 2:
        return "Enter 2nd Feature";
      case 3:
        return "Enter 3rd Feature";
      default:
        return "Enter ${index}th Feature";
    }
  }

  /// ....................Feature Photo Picker ...................
  String? originalImage;
  String? featureImage;
  String? base64featureImage;
  pickImage() async {
    await Utils.pickSingleImage().then((value) async {
      if (value != null) {
        originalImage = value;
        File file = File(originalImage!);
        if (file != null) {
          featureImage = file.path;
          List<int> imageBytes = await file.readAsBytes();
          base64featureImage = 'data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}';

          print("feature image is: ${base64featureImage}");
          // context.read<AdEditProfileCubit>().base64Image = base64Image!;
        }
      }
    });
    setState(() {});
    return base64featureImage;
  }

  /// ....................Gallery Photo Picker ...................
  final ImagePicker picker = ImagePicker();
  List<XFile>? images = [];
  List<String> base64Images = [];

  Future<List<String>?> pickImages() async {
    List<String> imagePaths = [];
    List<XFile>? tempImages = await picker.pickMultiImage();
    if (tempImages == null) {
      print("Image doesn't choose!");
      return imagePaths;
    } else {
      images = tempImages;
      base64Images = [];
      for (XFile file in images!) {
        List<int> imageBytes = await file.readAsBytes();
        print('xxxxxxxxxxx type : ${file.runtimeType} xxxxxxxxxxxxx');
        base64Images.add(
            'data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}');
        print(file.path.split('.').last);
        imagePaths.add(file.path);
      }

      // images2 = await (ImagePicker.platform.pickMultiImage(imageQuality: 100));
      setState(() {});

      // return imagePaths;
      return base64Images;
    }
  }
}
