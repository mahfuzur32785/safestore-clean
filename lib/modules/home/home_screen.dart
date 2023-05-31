import 'dart:core';
import 'package:safestore/core/remote_urls.dart';
import 'package:safestore/core/router_name.dart';
import 'package:safestore/modules/animated_splash/controller/app_setting_cubit.dart';
import 'package:safestore/modules/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safestore/modules/home/component/horizontal_ad_container.dart';

import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_textfeild.dart';
import '../ads/controller/adlist_bloc.dart';
import '../category/controller/category_bloc.dart';
import 'component/grid_product_container.dart';
import 'controller/cubit/home_controller_cubit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();

  final scrollController2 = ScrollController();

  void toTop() {
    scrollController2.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final _className = 'HomeScreen';

  final double height = 114;

  TextEditingController searchController = TextEditingController();

  var selectedCategory;
  var selectedCity;

  String? selected;

  final MainController mainController = MainController();

  late SearchAdsBloc searchAdsBloc;
  late CategoryBloc categoryBloc;

  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryBloc = context.read<CategoryBloc>();
    context.read<HomeControllerCubit>().updatedCountry.isEmpty ? context.read<HomeControllerCubit>().updatedCountry = context.read<AppSettingCubit>().location : null;
    print("update country code: ${context.read<HomeControllerCubit>().updatedCountry}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeControllerCubit, HomeControllerState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          // log(state.toString(), name: _className);
          if (state is HomeControllerLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeControllerError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.errorMessage,
                    style: const TextStyle(color: redColor),
                  ),
                  const SizedBox(height: 10),
                  IconButton(
                    onPressed: () {
                      context.read<HomeControllerCubit>().getHomeData(context.read<AppSettingCubit>().location.isEmpty ? context.read<AppSettingCubit>().defaultLocation.toString() : context.read<AppSettingCubit>().location);
                    },
                    icon: const Icon(Icons.refresh_outlined),
                  ),
                ],
              ),
            );
          }

          if (state is HomeControllerLoaded) {
            return Scaffold(
              backgroundColor: const Color(0xFFF6F7FE),
              appBar: AppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                // centerTitle: true,
                scrolledUnderElevation: 0,
                title: const CustomImage(
                  path: Kimages.logoColor,
                  height: 100,
                ),
                actions: [
                  SizedBox(
                    height: 55,
                    width: 170,
                    child: PopupMenuButton(
                      icon: Material(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.shade300,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                          child: Text(context.read<HomeControllerCubit>().country),
                        ),
                      ),
                      tooltip: "Select Country",
                      itemBuilder: (context) => <PopupMenuEntry>[
                        ...List.generate(state.homeModel.topCountries.length, (countryIndex) {
                          // print("Length ${state.homeModel.topCountries.length}");
                          return PopupMenuItem(
                            onTap: (){
                              selectedCity = null;

                              context.read<HomeControllerCubit>().countryIndex = countryIndex;
                              context.read<HomeControllerCubit>().updatedCountry = context.read<AppSettingCubit>().location = state.homeModel.topCountries[countryIndex].iso;
                              print("update country code: ${context.read<HomeControllerCubit>().updatedCountry}");
                              context.read<HomeControllerCubit>().getHomeData(context.read<HomeControllerCubit>().updatedCountry);
                              context.read<HomeControllerCubit>().country = state.homeModel.topCountries[countryIndex].name;
                            },
                            child: Text(state.homeModel.topCountries[countryIndex].name),
                          );
                        }),
                      ],
                    ),

                  ),
                ],
              ),
              body: RefreshIndicator(
                key: refreshKey,
                onRefresh: () => context.read<HomeControllerCubit>().getHomeData(context.read<HomeControllerCubit>().updatedCountry),
                child: CustomScrollView(
                  controller: scrollController2,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [

                    /// SEARCH, FILTER FILED
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 14, right: 14, top: 14, bottom: 14),
                        margin: const EdgeInsets.only(bottom: 20),
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
                                controller: searchController,
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
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // mainController.naveListener.sink.add(1);
                                    Navigator.pushNamed(
                                      context, RouteNames.adsScreen, arguments: [
                                      searchController.text ?? '',
                                      selectedCity ?? '',
                                      ''
                                    ],
                                    );
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

                    ///Category Section
                    SliverToBoxAdapter(
                      child: Visibility(
                        visible: true,
                        child: Column(
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      text: 'Browse ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 18),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Categories',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                                fontSize: 18)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 70.0,
                                    margin: EdgeInsets.fromLTRB(
                                        0.0, 5.0, 0.0, 0.0),
                                    child: Column(
                                      children: [
                                        const Divider(
                                          height: 1,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 40.0,
                                    child: const Divider(
                                      height: 6,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 10)
                                ],
                              ),
                            ),

                            Container(
                              // color: Colors.red,
                              // margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                              height: MediaQuery.of(context).size.height * 0.6,
                              alignment: Alignment.center,
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 0,
                                  childAspectRatio: 1.5,
                                ),
                                shrinkWrap: true,
                                itemCount: state.homeModel.categories.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context, RouteNames.adsScreen, arguments: [
                                          searchController.text ?? '',
                                          selectedCity ?? '',
                                          state.homeModel.categories[index].slug.toString()
                                        ],
                                        );
                                        // context.read<SearchAdsBloc>().add(SearchAdsEventSearch("",'','','','','',"${state.homeModel.categories[index].slug.toString()}",'','',''));
                                      },
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.grey.shade300,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: CustomImage(
                                                  // path: RemoteUrls.imageUrl(productModel.image),
                                                    path: state.homeModel.categories[index].image != '' ? "${RemoteUrls.rootUrl3}${state
                                                        .homeModel.categories[index]
                                                        .image}" : null,
                                                    fit: BoxFit.cover
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            SizedBox(
                                              child: Text(
                                                state.homeModel.categories[index]
                                                    .name,
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                },
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),

                    ///Feature section
                    SliverToBoxAdapter(
                      child: Visibility(
                        visible: true,
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              RichText(
                                text: const TextSpan(
                                  text: 'Featured ',
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Ads',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 18)),
                                  ],
                                ),
                              ),
                              Container(
                                width: 70.0,
                                margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                                child: Column(
                                  children: [
                                    const Divider(
                                      height: 1,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 40.0,
                                child: const Divider(
                                  height: 6,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///Feature AD SECTION
                    SliverToBoxAdapter(
                      child: Visibility(
                        visible: true,
                        child: HorizontalProductContainer(
                          adModelList: state.homeModel.featuredAds,
                          title: "",
                          onPressed: () {},
                          from: "home",
                        ),
                      ),
                    ),

                    ///LATEST AD SECTION
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 15,),
                    ),

                    SliverToBoxAdapter(
                      child: Visibility(
                        visible: true,
                        child: Center(
                          child: Column(
                            children: [
                              RichText(
                                text: const TextSpan(
                                  text: 'Latest ',
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Ads',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 18)),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                                width: 70.0,
                                child: const Divider(
                                  height: 1,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                width: 40.0,
                                child: const Divider(
                                  height: 6,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///Latest Ad Section
                    GridProductContainer(
                        adModelList: state.homeModel.latestAds,
                        title: "",
                        onPressed: () {},
                        from: "home"
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 30)),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
