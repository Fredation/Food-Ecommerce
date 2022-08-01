import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/size_config/config.dart';
import 'package:food_ecommerce/features/auth/presentation/login_screen.dart';
import 'package:food_ecommerce/features/store/presentation/state/store_cubit.dart';
import 'package:food_ecommerce/initData.dart';
import 'package:food_ecommerce/screens/home_screen.dart';

import 'features/auth/presentation/state/auth_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;
  bool loaded = false;
  int val = 3;

  load(BuildContext context) async {
    await initData(context);
    context.read<AuthCubit>().isUserLoggedIn;
    setState(() {
      loaded = true;
    });
  }

  nextToHome(BuildContext context) {
    if (timer.tick == val && loaded) {
      context.read<AuthCubit>().isUserLoggedIn
          ? Navigator.pushReplacementNamed(context, HomeScreen.routeName)
          : Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  @override
  void initState() {
    load(context);
    timer = Timer.periodic(const Duration(seconds: 3), (ti) async {
      setState(() {});
      if (ti.tick == val) {
        ti.cancel();

        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      nextToHome(context);
    });
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/splash.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
          child: CircularProgressIndicator(
        value: timer.tick == 0 ? 0 : (((timer.tick) / val)),
        backgroundColor: Colors.white.withOpacity(.3),
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
      )),
    );
  }
}
