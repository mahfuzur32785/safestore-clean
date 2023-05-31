import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safestore/core/error/failure.dart';
import 'package:safestore/modules/ad_details/controller/ad_details_state.dart';
import 'package:safestore/modules/ad_details/repository/ad_details_repository.dart';
import 'package:safestore/modules/authentication/controllers/login/login_bloc.dart';
import 'package:safestore/modules/authentication/controllers/sign_up/sign_up_bloc.dart';
import 'package:safestore/utils/constants.dart';
import 'package:safestore/utils/utils.dart';

class AdDetailsCubit extends Cubit<AdDetailsState>{
  AdDetailsCubit(this.adDetailsRepository, this.loginBloc) : super(const AdDetailsStateLoading());
  final AdDetailsRepository adDetailsRepository;
  final LoginBloc loginBloc;

  final emailController = TextEditingController();
  final messageController = TextEditingController();
  String reasonType = reasonTypeList[0];


  Future<void> getAdDetails(String slug, bool isLoading) async {
    if (isLoading) {
      emit(const AdDetailsStateLoading());
    }

    String token = '';
    if (loginBloc.userInfo != null) {
      token = '${loginBloc.userInfo?.accessToken}';
    }

    final result = await adDetailsRepository.getAdDetails(slug,token);
    result.fold((error) => emit(AdDetailsStateError(error.message)), (data) => emit(AdDetailsStateLoaded(data)));
  }

  Future<void> postReport (String reason, String email, String message, int adId, context) async {

    Map<String, dynamic> body = {
      "ad_id": adId.toString(),
      "reason": reason,
      "email": email,
      "message": message
    };
    String token = '';
    if (loginBloc.userInfo != null) {
      token = '${loginBloc.userInfo?.accessToken}';
    }
    final result = await adDetailsRepository.postReport(body,token);
    print(result);

    result.fold((failure) => Utils.errorSnackBar(context, failure.message), (success) => {
      Utils.showSnackBar(context, success),
      emailController.text = '',
      messageController.text = '',
    });
  }
}