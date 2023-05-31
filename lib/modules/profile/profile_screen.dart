import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_awesome_web_names/flutter_font_awesome.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:safestore/utils/utils.dart';
import 'package:safestore/widgets/please_signin_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../authentication/controllers/login/login_bloc.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final scrollController = ScrollController();

  void toTop() {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    String? selectedValue;

    final userData = context.read<LoginBloc>().userInfo;

    if (userData == null) {
      return const PleaseSignInWidget();
    }

    return CustomScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverAppBar(
          title: Text("Overview"),
          pinned: true,
        ),
        _buildProfileOptions(context),
        const SliverToBoxAdapter(child: SizedBox(height: 65)),
      ],
    );
  }

  SliverPadding _buildProfileOptions(BuildContext context) {
    final userData = context.read<LoginBloc>().userInfo;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.dashboardScreen);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.home_outlined,
                size: 27,
                color: Colors.black54,
              ),
              title: Text(
                  "Dashboard",
                  style: const TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.publicShopScreen,
                    arguments: userData?.user.username);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.person_outline,
                size: 27,
                color: Colors.black54,
              ),
              title: Text(
                  "My Shop",
                  style: const TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                // Navigator.pushNamed(context, RouteNames.postAd);
                Navigator.pushNamed(context, RouteNames.newPostAd);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.add,
                size: 27,
                color: Colors.black54,
              ),
              title: Text(
                  "Ad Post",
                  style: const TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.customerAds);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.format_list_bulleted,
                size: 27,
                color: Colors.black54,
              ),
              title: Text("My ads",
                  style: const TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.compareScreen);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.change_circle_outlined,
                size: 27,
                color: Colors.black54,
              ),
              title: Text(
                  "Compare Ads",
                  style: const TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.wishListScreen);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.favorite_outline,
                size: 27,
                color: Colors.black54,
              ),
              title: Text(
                  "Favorite ads",
                  style: const TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.chatScreen);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.question_answer_outlined,
                size: 27,
                color: Colors.black54,
              ),
              title: Text("Chat",
                  style: const TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.planAndBillings);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.article_outlined,
                color: Colors.black54,
              ),
              // leading: const CustomImage(path: Kimages.profileDollarIcon,height: 27,width: 27,color: redColor,),
              title: Text(
                  "Transactions",
                  style: const TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () async {
                await launchUrl(Uri.parse("https://safestore.tech/contact"),
                    webViewConfiguration: const WebViewConfiguration(
                      enableJavaScript: true,
                      enableDomStorage: true,
                    ),
                    mode: LaunchMode.externalApplication,
                );
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.perm_contact_cal_outlined,
                color: Colors.black54,
              ),
              // leading: const CustomImage(path: Kimages.profileDollarIcon,height: 27,width: 27,color: redColor,),
              title: Text(
                  "Contact Us",
                  style: const TextStyle(fontSize: 16)),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.profileEditScreen);
              },
              minLeadingWidth: 0,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.settings_outlined,
                size: 27,
                color: Colors.black54,
              ),
              title: Text(
                  "Setting",
                  style: const TextStyle(fontSize: 16)),
            ),
            BlocBuilder<LoginBloc, LoginModelState>(builder: (context, state) {
              if (state.state is LoginStateLogOutLoading) {
                const CircularProgressIndicator();
              }
              return ListTile(
                minLeadingWidth: 0,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                leading: const Icon(
                  Icons.exit_to_app_outlined,
                  size: 27,
                  color: Colors.black54,
                ),
                title: Text(
                    "Logout",
                    style: const TextStyle(fontSize: 16)),
                onTap: () {
                  Utils.loadingDialog(context);
                  context.read<LoginBloc>().add(const LoginEventLogout());
                  Hive.box('compareList').clear();
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
