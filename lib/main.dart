import 'package:hive_flutter/hive_flutter.dart';
import 'package:safestore/modules/payment_gateway/controllers/payfast/payfast_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:safestore/modules/ad_details/controller/ad_details_cubit.dart';
import 'package:safestore/modules/ad_details/repository/ad_details_repository.dart';
import 'package:safestore/modules/ads/controller/adlist_bloc.dart';
import 'package:safestore/modules/ads/controller/customer_ads/customer_ads_bloc.dart';
import 'package:safestore/modules/ads/repository/adlist_repository.dart';
import 'package:safestore/modules/authentication/controllers/forgot_password/forgot_password_cubit.dart';
import 'package:safestore/modules/category/controller/category_bloc.dart';
import 'package:safestore/modules/chat/controller/chat_users_cubit/chat_users_cubit.dart';
import 'package:safestore/modules/chat/controller/chat_users_repository.dart';
import 'package:safestore/modules/chat/controller/message_cubit/message_cubit.dart';
import 'package:safestore/modules/dashboard/controller/dashboard_cubit.dart';
import 'package:safestore/modules/home/controller/cubit/home_controller_cubit.dart';
import 'package:safestore/modules/home/controller/repository/home_repository.dart';
import 'package:safestore/modules/my_plans/controller/plan_billing_cubit.dart';
import 'package:safestore/modules/payment_gateway/controllers/paypal/paypal_cubit.dart';
import 'package:safestore/modules/post_ad/controller/postad_bloc.dart';
import 'package:safestore/modules/post_ad/controller/postad_repository.dart';
import 'package:safestore/modules/price_planing/controller/payment_gateways/pg_cubit.dart';
import 'package:safestore/modules/price_planing/controller/pricing_cubit.dart';
import 'package:safestore/modules/price_planing/controller/pricing_repository.dart';
import 'package:safestore/modules/profile/controller/compare_list/compare_list_cubit.dart';
import 'package:safestore/modules/profile/controller/public_profile/public_profile_cubit.dart';
import 'package:safestore/modules/profile/controller/wish_list/wish_list_cubit.dart';
import 'package:safestore/utils/my_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/data/datasources/local_data_source.dart';
import 'core/data/datasources/remote_data_source.dart';
import 'core/router_name.dart';
import 'modules/ads/new_ad_edit/controller/new_ad_edit_bloc.dart';
import 'modules/animated_splash/controller/app_setting_cubit.dart';
import 'modules/animated_splash/repository/app_setting_repository.dart';
import 'modules/authentication/controllers/login/login_bloc.dart';
import 'modules/authentication/controllers/sign_up/sign_up_bloc.dart';
import 'modules/authentication/repository/auth_repository.dart';
import 'modules/map/map_cubit.dart';
import 'modules/new_post_ad/controller/new_posted_bloc.dart';
import 'modules/payment_gateway/controllers/payment_repository.dart';
import 'modules/payment_gateway/controllers/stripe/stripe_cubit.dart';
import 'modules/profile/controller/change_password/change_password_cubit.dart';
import 'modules/profile/controller/edit_profile/ads_edit_profile_cubit.dart';
import 'modules/profile/repository/profile_repository.dart';
import 'modules/setting/controllers/repository/setting_repository.dart';

late final SharedPreferences _sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('compareList');

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Stripe.publishableKey = KStrings.stPublishableKey;
  // Stripe.merchantIdentifier = 'any string works';
  // await Stripe.instance.applySettings();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  _sharedPreferences = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        ///network client
        RepositoryProvider<Client>(
          create: (context) => Client(),
        ),
        RepositoryProvider<SharedPreferences>(
          create: (context) => _sharedPreferences,
        ),

        ///data source repository
        RepositoryProvider<RemoteDataSource>(
          create: (context) => RemoteDataSourceImpl(client: context.read()),
        ),
        RepositoryProvider<LocalDataSource>(
          create: (context) =>
              LocalDataSourceImpl(sharedPreferences: context.read()),
        ),

        ///Repository
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImp(
            remoteDataSource: context.read(),
            localDataSource: context.read(),
          ),
        ),
        RepositoryProvider<HomeRepository>(
          create: (context) =>
              HomeRepositoryImp(remoteDataSource: context.read()),
        ),
        RepositoryProvider<AdDetailsRepository>(
          create: (context) =>
              AdDetailsRepositoryImp(remoteDataSource: context.read()),
        ),
        RepositoryProvider<SearchAdsRepository>(
          create: (context) =>
              SearchAdsRepositoryImp(remoteDataSource: context.read()),
        ),

        RepositoryProvider<PricingRepository>(
          create: (context) =>
              PricingRepositoryImp(remoteDataSource: context.read()),
        ),
        RepositoryProvider<PostAdRepository>(
          create: (context) =>
              PostAdRepositoryImp(remoteDataSource: context.read()),
        ),
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepositoryImp(
            remoteDataSource: context.read(),
            localDataSource: context.read(),
          ),
        ),
        RepositoryProvider<SettingRepository>(
          create: (context) =>
              SettingRepositoryImp(remoteDataSource: context.read()),
        ),

        RepositoryProvider<AppSettingRepository>(
          create: (context) => AppSettingRepositoryImp(
            remoteDataSource: context.read(),
            localDataSource: context.read(),
          ),
        ),
        RepositoryProvider<PaymentRepository>(
          create: (context) => PaymentRepositoryImp(context.read()),
        ),
        RepositoryProvider<ChatRepository>(
          create: (context) => ChatRepositoryImp(remoteDataSource: context.read(),),
        ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<LoginBloc>(
              create: (BuildContext context) => LoginBloc(
                profileRepository: context.read(),
                authRepository: context.read(),
              ),
            ),
            BlocProvider<HomeControllerCubit>(
              create: (BuildContext context) =>
                  HomeControllerCubit(context.read(), context.read()),
            ),
            BlocProvider<MapCubit>(
              create: (context) => MapCubit(),
            ),
            BlocProvider<AdDetailsCubit>(
              create: (BuildContext context) => AdDetailsCubit(context.read(),context.read()),
            ),
            BlocProvider<SearchAdsBloc>(
              create: (BuildContext context) => SearchAdsBloc(
                searchAdsRepository: context.read(),
              ),
            ),
            BlocProvider<CustomerAdsBloc>(
              create: (BuildContext context) => CustomerAdsBloc(
                searchAdsRepository: context.read(),
                loginBloc: context.read(),
                homeControllerCubit: context.read()
              ),
            ),
            BlocProvider<NewPostAdBloc>(
              create: (BuildContext context) => NewPostAdBloc(
                homeControllerCubit: context.read(),
                postAdRepository: context.read(),
              ),
            ),
            BlocProvider<PostAdBloc>(
              create: (BuildContext context) => PostAdBloc(
                homeControllerCubit: context.read(),
                postAdRepository: context.read(),
              ),
            ),
            BlocProvider<NewEditAdBloc>(
              create: (BuildContext context) => NewEditAdBloc(
                homeControllerCubit: context.read(),
                postAdRepository: context.read(),
              ),
            ),

            BlocProvider<DashboardCubit>(
              create: (BuildContext context) => DashboardCubit(
                profileRepository: context.read(),
                loginBloc: context.read(),
              ),
            ),
            BlocProvider<PublicProfileCubit>(
              create: (BuildContext context) => PublicProfileCubit(
                profileRepository: context.read(),
                loginBloc: context.read(),
              ),
            ),
            BlocProvider<PricingCubit>(
              create: (BuildContext context) => PricingCubit(
                pricingRepository: context.read(),
                loginBloc: context.read(),
              ),
            ),
            BlocProvider<PlanBillingCubit>(
              create: (BuildContext context) => PlanBillingCubit(
                pricingRepository: context.read(),
                loginBloc: context.read(),
              ),
            ),
            BlocProvider<PaymentGatewayCubit>(
              create: (BuildContext context) => PaymentGatewayCubit(
                pricingRepository: context.read(),
                loginBloc: context.read(),
              ),
            ),
            BlocProvider<CategoryBloc>(
              create: (BuildContext context) => CategoryBloc(),
            ),
            BlocProvider<ForgotPasswordCubit>(
              create: (BuildContext context) => ForgotPasswordCubit(
                context.read(),
              ),
            ),
            BlocProvider<AppSettingCubit>(
              create: (BuildContext context) => AppSettingCubit(context.read()),
            ),
            // BlocProvider<AccDeletionBloc>(
            //   create: (BuildContext context) => AccDeletionBloc(
            //       settingRepository: context.read(), loginBloc: context.read()),
            // ),
            BlocProvider<SignUpBloc>(
              create: (BuildContext context) => SignUpBloc(context.read()),
            ),
            BlocProvider<ChangePasswordCubit>(
              create: (BuildContext context) => ChangePasswordCubit(
                loginBloc: context.read(),
                profileRepository: context.read(),
              ),
            ),
            BlocProvider<CompareListCubit>(
              create: (BuildContext context) => CompareListCubit(
                loginBloc: context.read(),
                profileRepository: context.read(),
              ),
            ),
            BlocProvider<WishListCubit>(
              create: (BuildContext context) => WishListCubit(
                loginBloc: context.read(),
                profileRepository: context.read(),
              ),
            ),
            BlocProvider<StripeCubit>(
              create: (context) => StripeCubit(
                paymentRepository: context.read(),
                loginBloc: context.read(),
              ),
            ),
            BlocProvider<ChatUsersCubit>(
              create: (context) => ChatUsersCubit(
                chatRepository: context.read(),
                loginBloc: context.read(),
              ),
            ),
            BlocProvider<MessageCubit>(
              create: (context) => MessageCubit(
                chatRepository: context.read(),
                loginBloc: context.read(),
              ),
            ),
            BlocProvider<PaypalCubit>(
              create: (context) => PaypalCubit(
                paymentRepository: context.read(),
                loginBloc: context.read(),
              ),
            ),
            BlocProvider<AdEditProfileCubit>(
              create: (BuildContext context) => AdEditProfileCubit(
                profileRepository: context.read(),
                loginBloc: context.read(),authRepository: context.read(),
              ),
            ),

            BlocProvider<PayfastCubit>(
              create: (context) => PayfastCubit(
                paymentRepository: context.read(),
                loginBloc: context.read(),
              ),
            ),
          ],
          child: BlocBuilder<AppSettingCubit, AppSettingState>(
            builder: (context,localeState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: MyTheme.theme,
                onGenerateRoute: RouteNames.generateRoute,
                initialRoute: RouteNames.animatedSplashScreen,
                onUnknownRoute: (RouteSettings settings) {
                  return MaterialPageRoute(
                    builder: (_) => Scaffold(
                      body: Center(
                        child: Text('No route defined for ${settings.name}'),
                      ),
                    ),
                  );
                },
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: child!,
                  );
                },
              );
            }
          ),
      ),
    );
  }
}
