import 'dart:io';

import 'package:safestore/modules/animated_splash/controller/app_setting_cubit.dart';
import 'package:safestore/modules/main/compare_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safestore/modules/home/controller/cubit/home_controller_cubit.dart';
import 'package:safestore/modules/profile/profile_screen.dart';
import 'package:safestore/utils/constants.dart';
import 'package:upgrader/upgrader.dart';

import '../../core/router_name.dart';
import '../../utils/utils.dart';
import '../authentication/controllers/login/login_bloc.dart';
import '../home/home_screen.dart';
import 'component/bottom_navigation_bar.dart';
import 'main_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _homeController = MainController();

  late List<Widget> pageList;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      // BlocProvider.of<LocaleCubit>(context).toEnglish();
      context.read<LoginBloc>().add(const LoginEventCheckProfile());
      print("Current Location ${context.read<AppSettingCubit>().location} Default Location ${context.read<AppSettingCubit>().defaultLocation.toString()}");
      context.read<HomeControllerCubit>().getHomeData(context.read<AppSettingCubit>().location.isEmpty ? context.read<AppSettingCubit>().defaultLocation.toString() :  context.read<AppSettingCubit>().location);
    });

    pageList = [
      HomeScreen(),
      const CompareListAdsPage(),
      ProfileScreen(),
    ];
  }

  final _className = "MainPage";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      initialData: 0,
      stream: _homeController.naveListener.stream,
      builder: (context, AsyncSnapshot<int> snapshot) {
        int index = snapshot.data ?? 0;

        return BlocListener<LoginBloc, LoginModelState>(
          key: UniqueKey(),
          listener: (context, state) {
            // log(state.state.toString(), name: _className);
            if (state.state is LoginStateLogOut) {
              Utils.closeDialog(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.authenticationScreen, (route) => false);
            } else if (state.state is LoginStateLogOutLoading) {
              Utils.loadingDialog(context);
            } else if (state.state is LoginStateSignOutError) {
              final currentState = state.state as LoginStateSignOutError;
              Utils.closeDialog(context);
              Utils.errorSnackBar(context, currentState.errorMsg);
            }
          },
          child: Scaffold(
            extendBody: true,
            key: UniqueKey(),
            body: WillPopScope(
              onWillPop: () => _homeController.onBackPressed(context,index),
              child: UpgradeAlert(
                upgrader: Upgrader(
                  dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
                ),
                child: IndexedStack(
                  index: index,
                  children: pageList,
                ),
              ),
            ),
            bottomNavigationBar: MyBottomNavigationBar(
                mainController: _homeController, selectedIndex: index,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: Visibility(
              visible: false,
              child: FloatingActionButton(
                onPressed: (){
                  if (index == 3) {
                    Navigator.pushNamed(context, RouteNames.createDirectoryScreen);
                  } else {
                    Navigator.pushNamed(context, RouteNames.postAd);
                  }
                },
                backgroundColor: redColor,
                shape: const CircleBorder(),
                tooltip: "Post ad",
                child: const Icon(Icons.add),
              ),
            ),
          ),
        );
      },
    );
  }
}
