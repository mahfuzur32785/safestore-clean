import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safestore/modules/profile/controller/wish_list/wish_list_cubit.dart';

import '../../utils/constants.dart';
import '../home/component/grid_product_container.dart';
import 'component/wish_list_produtc_container.dart';

class WishListAdScreen extends StatefulWidget {
  const WishListAdScreen({Key? key}) : super(key: key);

  @override
  State<WishListAdScreen> createState() => _WishListAdScreenState();
}

class _WishListAdScreenState extends State<WishListAdScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => context.read<WishListCubit>().getWishList(true));
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FE),
      appBar: AppBar(
        title: Text("Favorite ads"),
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_sharp,color: iconThemeColor,),
        ),
      ),
      body: BlocBuilder<WishListCubit,WishListState>(
        builder: (context, state) {
          if (state is WishListStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is WishListStateError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: redColor),
              ),
            );
          }
          if(state is WishListStateLoaded){
            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: ()  => context.read<WishListCubit>().getWishList(true),
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  WishListProductContainer(
                    adModelList: state.adList,
                    onPressed: (){},
                    form: 'wist_list_screen',
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
