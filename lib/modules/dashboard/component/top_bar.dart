import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safestore/core/router_name.dart';
import 'package:safestore/modules/authentication/controllers/login/login_bloc.dart';
import 'package:safestore/widgets/custom_image.dart';

import '../../../utils/constants.dart';
import '../model/overview_model.dart';

class DashboardTopBar extends StatelessWidget {
  const DashboardTopBar({Key? key, required this.overViewModel}) : super(key: key);
  final DOverViewModel overViewModel;

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: Colors.grey.shade300,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CustomImage(
                path: "${loginBloc.userInfo!.user.imageUrl}" != '' ? "${loginBloc.userInfo!.user.imageUrl}" : null,
                fit: BoxFit.cover
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text(loginBloc.userInfo!.user.name != '' ? "${loginBloc.userInfo?.user.name}" : "No name",style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
              Text("${overViewModel.adsCount.activeAdsCount} Active Posted ads",style: const TextStyle(color: Colors.black45,fontSize: 13,fontWeight: FontWeight.w400),),
            ],
          ),
        ),
        Material(
          color: Colors.white.withAlpha(910),
          elevation: 3,
          shadowColor: const Color(0xFFFFFFFF),
          borderOnForeground: true,
          shape: const CircleBorder(),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: (){
              Navigator.pushNamed(context, RouteNames.profileEditScreen);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.edit,color: redColor,size: 20,),
            ),
          ),
        ),
      ],
    );
  }
}
