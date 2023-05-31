import 'package:bloc/bloc.dart';
import 'package:safestore/modules/authentication/controllers/login/login_bloc.dart';
import 'package:safestore/modules/home/model/state_model.dart';
import 'package:equatable/equatable.dart';

import '../../model/home_model.dart';
import '../repository/home_repository.dart';

part 'home_controller_state.dart';

class HomeControllerCubit extends Cubit<HomeControllerState> {
  HomeControllerCubit(HomeRepository homeRepository, LoginBloc loginBloc)
      : _homeRepository = homeRepository,
        _loginBloc = loginBloc,
        super(HomeControllerLoading()) {
    getHomeData('us');
  }

  final HomeRepository _homeRepository;
  final LoginBloc _loginBloc;
  late HomeModel homeModel;

  List<StateModel> stateList = [];
  StateModel? stateName;

  int countryIndex = 1;

  String country = 'Select Country';
  String updatedCountry = '';

  Future<void> getHomeData(String countryCode) async {
    emit(HomeControllerLoading());

    final result = await _homeRepository.getHomeData(countryCode, _loginBloc.userInfo?.accessToken??'');
    result.fold(
      (failure) {
        emit(HomeControllerError(errorMessage: failure.message));
      },
      (data) {
        homeModel = data;
        // print("home feture wishlist value {${homeModel.regularAds[0].is_wishlist}");
        // countryList = homeModel.topCountries.reversed.toList();
        // TopCountry country = countryList.singleWhere((element) => element.id == countryIndex);
        stateList = homeModel.topCountries[countryIndex].states.reversed.toList();

        if(stateList.isNotEmpty){
          stateName = stateList[0];
          print("stateList $stateList");
        }else{
          print("stateList no $stateList");
        }
        emit(HomeControllerLoaded(homeModel: data));
      },
    );
  }

  Future<void> getHomeDataOnRefresh(String countryCode) async {
    // emit(HomeControllerLoading());

    final result = await _homeRepository.getHomeData(countryCode, _loginBloc.userInfo!.accessToken);
    result.fold(
          (failure) {
        emit(HomeControllerError(errorMessage: failure.message));
      },
          (data) {
        homeModel = data;
        emit(HomeControllerLoaded(homeModel: data));
      },
    );
  }
}
