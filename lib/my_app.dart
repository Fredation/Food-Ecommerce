import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/model/build_config.dart';
import 'package:food_ecommerce/cubit_states.dart';
import 'package:food_ecommerce/features/address/presentation/address_page.dart';
import 'package:food_ecommerce/features/address/presentation/create_address.dart';
import 'package:food_ecommerce/features/auth/presentation/login_screen.dart';
import 'package:food_ecommerce/features/auth/presentation/sign_up_screen.dart';
import 'package:food_ecommerce/features/cart/presentation/cart_page.dart';
import 'package:food_ecommerce/features/store/presentation/meal_detail_screen.dart';
import 'package:food_ecommerce/features/store/presentation/popular_meal_detail_screen.dart';
import 'package:food_ecommerce/screens/home_screen.dart';
import 'package:food_ecommerce/splash_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:overlay_support/overlay_support.dart';

class MyApp extends StatefulWidget {
  final BuildConfig buildConfig;
  final GetIt instance;
  final GlobalKey<NavigatorState> navigatorKey;
  const MyApp(
      {Key? key,
      required this.buildConfig,
      required this.instance,
      required this.navigatorKey})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: getProviders(widget.instance),
      child: OverlaySupport.global(
        child: MaterialApp(
          title: widget.buildConfig.appName,
          navigatorKey: widget.navigatorKey,
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.routeName,
          theme: ThemeData(primarySwatch: Colors.blue),
          routes: {
            HomeScreen.routeName: (ctx) => const HomeScreen(),
            MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
            PopularMealDetailScreen.routeName: (ctx) =>
                PopularMealDetailScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            SignUpScreen.routeName: (ctx) => const SignUpScreen(),
            SplashScreen.routeName: (ctx) => const SplashScreen(),
            CartPage.routeName: (ctx) => const CartPage(),
            AddressPage.routeName: (ctx) => const AddressPage(),
            CreateAddress.routeName: (ctx) => const CreateAddress(),
            // AddProductScreen.routeName: (ctx) => AddProductScreen(),
          },
        ),
      ),
    );
  }
}
