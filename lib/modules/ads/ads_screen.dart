import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:safestore/modules/animated_splash/controller/app_setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safestore/modules/ads/controller/adlist_bloc.dart';
import 'package:safestore/modules/category/controller/category_bloc.dart';
import 'package:safestore/modules/home/component/grid_product_container2.dart';
import 'package:safestore/modules/main/main_controller.dart';

import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_textfeild.dart';
import '../home/controller/cubit/home_controller_cubit.dart';
import 'component/ads_appbar.dart';

class AdsScreen extends StatefulWidget {
  const AdsScreen({Key? key, this.searchValue,  this.cityValue, this.categoryValue}) : super(key: key);

  final String? searchValue;
  final String? cityValue;
  final String? categoryValue;

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {

  TextEditingController searchController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();

  var selectedCategory;
  String? selectedSortingValue;

  final _scrollController = ScrollController();

  late SearchAdsBloc searchAdsBloc;
  late CategoryBloc categoryBloc;
  // late HomeModel homeModel;
  late HomeControllerCubit homeControllerCubit;

  final MainController mainController = MainController();

  var selectedCity;

  @override
  void initState() {
    super.initState();
    searchAdsBloc = context.read<SearchAdsBloc>();
    homeControllerCubit = context.read<HomeControllerCubit>();
    categoryBloc = context.read<CategoryBloc>();
    print("category : ${categoryBloc.categorySlug}, sub-category : ${categoryBloc.subCategorySlug}");
    if (searchAdsBloc.adList.isEmpty) {
      Future.microtask(() => context.read<SearchAdsBloc>().add(SearchAdsEventSearch("${widget.searchValue}",'','','','','',"${widget.categoryValue}",'','${widget.cityValue}','',context.read<AppSettingCubit>().location.isEmpty ? context.read<AppSettingCubit>().defaultLocation.toString() :  context.read<AppSettingCubit>().location)));
    }
    _init();

    // context.read<SearchAdsBloc>().selectedCity = widget.cityValue.toString().isEmpty ? 'Enter city' : context.read<SearchAdsBloc>().selectedCity;
    // print("ads selected value ${context.read<SearchAdsBloc>().selectedCity}");

    context.read<SearchAdsBloc>().searchController.text = widget.searchValue?? '';
  }

  void _init() {
    _scrollController.addListener(() {
      final maxExtent = _scrollController.position.maxScrollExtent - 100;
      if (maxExtent < _scrollController.position.pixels) {
        searchAdsBloc.add(const SearchAdsEventLoadMore());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchAdsBloc.adList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FE),
        body: CustomScrollView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            slivers: [
              AdsAppBar.appBar(context),

              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 14, bottom: 14),
                  margin: const EdgeInsets.only(bottom: 40),
                  decoration: const BoxDecoration(
                    color: Color(0XFFF7E7F3),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                        Border.all(color: Colors.black12, width: 8),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        ///Search text filed
                        CstmTextFeild(
                          isObsecure: false,
                          controller: context.read<SearchAdsBloc>().searchController,
                          hintext: "What are you looking for?",
                        ),

                        /// Select City
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18),
                          height: 48,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: const Text('Entire city',
                                  style: TextStyle(color: Colors.black)),
                              isDense: true,
                              isExpanded: true,
                              onChanged: (dynamic value) {
                                selectedCity = value;
                                print(selectedCity);
                                setState(() {

                                });
                              },
                              value: selectedCity,
                              items: context.read<HomeControllerCubit>().stateList.map((location) {
                                return DropdownMenuItem<String>(
                                  value: location.slug,
                                  child: Text("${location.name}"),
                                );
                              }).toList(),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              Utils.closeKeyBoard(context);
                              setState(() {
                                Future.microtask(() => context.read<SearchAdsBloc>().add(SearchAdsEventSearch(context.read<SearchAdsBloc>().searchController.text.trim(),'','','','','',categoryBloc.categorySlug,'',selectedCity==null?'':selectedCity,'', context.read<AppSettingCubit>().location.isEmpty ? context.read<AppSettingCubit>().defaultLocation.toString() :  context.read<AppSettingCubit>().location)));
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero),
                                backgroundColor: redColor),
                            child: const Text("Find it"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Visibility(
                  // visible: searchAdsBloc.adList.isEmpty &&
                  //     state is SearchAdsStateLoaded,
                  visible: false,
                  child: SizedBox(
                    // height: 200,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Ads Not Found",
                        style: const TextStyle(
                            color: redColor, fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: CstmTextFeild(
                            isObsecure: false,
                            controller: minPriceController,
                            hintext: "Min",
                            keyboardType: TextInputType.number,
                          ),),

                          Expanded(child: CstmTextFeild(
                            isObsecure: false,
                            controller: maxPriceController,
                            hintext: "Max",
                            keyboardType: TextInputType.number,
                          ),),
                          SizedBox(width: 2,),
                          Expanded(child: SizedBox(
                            height: 46,
                            child: ElevatedButton(
                              onPressed: () {
                                Utils.closeDialog(context);
                                Future.microtask(() => context.read<SearchAdsBloc>().add(SearchAdsEventSearch('',minPriceController.text,maxPriceController.text,'','','',categoryBloc.categorySlug,'','','',context.read<AppSettingCubit>().location.isEmpty ? context.read<AppSettingCubit>().defaultLocation.toString() :  context.read<AppSettingCubit>().location)));
                                // setState(() {
                                //   context.read<SearchAdsBloc>().add(SearchAdsEventSearch("",minPriceController.text,maxPriceController.text,'','','',"",'','','',));
                                // });
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  backgroundColor:
                                  const Color(0xFF212d6e)),
                              child: const Text("Apply"),
                            ),
                          ),),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Ads",
                            style:
                            const TextStyle(fontSize: 18, height: 1.5, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets
                                  .symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors
                                          .grey.shade400),
                                  borderRadius:
                                  BorderRadius.circular(
                                      8)),
                              child:
                              DropdownButtonHideUnderline(
                                child:
                                DropdownButton<String>(
                                  hint: const Text(
                                      'Sort By',
                                      style: TextStyle(
                                          color: Colors
                                              .black)),
                                  isDense: true,
                                  isExpanded: true,
                                  onChanged:
                                      (dynamic value) {
                                    selectedSortingValue = value;
                                    context.read<SearchAdsBloc>().add(SearchAdsEventSearch("${context.read<SearchAdsBloc>().searchController.text.trim()}",'','','',selectedSortingValue!,'',"",'',selectedCity==null?'':selectedCity,'',context.read<AppSettingCubit>().location.isEmpty ? context.read<AppSettingCubit>().defaultLocation.toString() :  context.read<AppSettingCubit>().location));
                                    print(selectedSortingValue);
                                    setState(() {});
                                  },
                                  value: selectedSortingValue,
                                  items: myItemSortListData
                                      .map((location) {
                                    return DropdownMenuItem<String>(
                                      value: location['value'],
                                      child: Text("${location['name']}"),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10)
                    ],
                  ),

                ),
              ),


              SliverToBoxAdapter(
                  child: BlocConsumer<SearchAdsBloc, SearchAdsState>(
                    listener: (context, state) {
                      if (state is SearchAdsStateMoreError) {
                        Utils.errorSnackBar(context, state.message);
                      }
                    },
                    builder: (context, state) {
                      final adList = searchAdsBloc.adList;
                      if (searchAdsBloc.adList.isEmpty && state is SearchAdsStateLoading) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.width * 0.3,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is SearchAdsStateError) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.width * 0.3,
                          child: Center(
                            child: Text(
                              state.message,
                              style: const TextStyle(color: redColor),
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: [
                          GridProductContainer2(
                            onPressed: (){},
                            adModelList: adList,
                          ),
                          Visibility(
                            visible: state is SearchAdsStateLoadMore,
                            child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: const Center(
                                  child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator()),
                                )),
                          ),
                        ],
                      );
                    },
                  )
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 50,
                ),
              )
            ],
          ),
      ),
    );
  }
}
