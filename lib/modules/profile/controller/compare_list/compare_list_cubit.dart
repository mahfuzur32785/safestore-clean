import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:safestore/modules/home/model/ad_model.dart';
import '../../../../../core/error/failure.dart';
import '../../../authentication/controllers/login/login_bloc.dart';
import '../../model/wish_list_model.dart';
import '../../repository/profile_repository.dart';
part 'compare_list_state.dart';

class CompareListCubit extends Cubit<CompareListState> {
  CompareListCubit({
    required LoginBloc loginBloc,
    required ProfileRepository profileRepository,
  })  : _loginBloc = loginBloc,
        _profileRepository = profileRepository,
        super(const CompareListStateInitial());

  final LoginBloc _loginBloc;
  final ProfileRepository _profileRepository;

  List<AdModel> adList = [];

  List<int> selectedId = [];

  Future<void> getCompareList(bool isLoading, List<dynamic> adsId) async {
    // if (_loginBloc.userInfo == null) {
    //   emit(const CompareListStateError("Please login first", 1000));
    //   return;
    // }
    if (isLoading) {
      emit(const CompareListStateLoading());
    }

    final result = await _profileRepository.compareList(adsId);

    result.fold(
          (failure) {
        emit(CompareListStateError(failure.message, failure.statusCode));
      },
          (adList) {
        this.adList = adList;
        emit(CompareListStateLoaded(adList));
      },
    );
  }

  // Future<Either<Failure, String>> removeWishList(WishListModel item) async {
  //   if (_loginBloc.userInfo == null) {
  //     return left(const ServerFailure("Please login first", 1000));
  //   }
  //   final result = await _profileRepository.removeWishList(
  //       item.wishId, _loginBloc.userInfo!.accessToken);
  //
  //   result.fold(
  //         (failure) {
  //       return false;
  //     },
  //         (success) {
  //       adList.remove(item);
  //       return true;
  //     },
  //   );
  //
  //   return result;
  // }
  //
  // Future<Either<Failure, String>> addWishList(int id) async {
  //   if (_loginBloc.userInfo == null) {
  //     return left(const ServerFailure("Please login first", 1000));
  //   }
  //   final result = await _profileRepository.addWishList(
  //       id, _loginBloc.userInfo!.accessToken);
  //
  //   return result;
  // }

}
