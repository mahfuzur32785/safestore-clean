import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safestore/modules/dashboard/component/top_bar.dart';
import 'package:safestore/modules/dashboard/controller/dashboard_cubit.dart';
import '../home/component/horizontal_ad_container.dart';
import 'component/grid_card_container.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<DashboardCubit>().getDashboardData());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F6),
      // backgroundColor: Colors.red,
      body: SafeArea(
        child: BlocBuilder<DashboardCubit,DashboardState>(
            builder: (context,state) {
              if (state is DashboardStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is DashboardStateError) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is DashboardStateLoaded) {
                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: () => context.read<DashboardCubit>().getDashboardData(),
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        sliver: SliverToBoxAdapter(child: DashboardTopBar(overViewModel: state.data,)),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                        sliver: DashboardGridCardLayout(overViewModel: state.data),
                      ),

                      ///.......... Recent Ads horizontal ..........
                      SliverToBoxAdapter(
                        child: HorizontalProductContainer(
                          adModelList: state.data.recentAds.adList,
                          title: "Recent ads",
                          onPressed: (){},
                          from: 'dashboard',
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 30,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
          }
        ),
      ),
    );
  }

}