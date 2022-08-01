import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SizeConfig {
  static late BuildContext appContext;
  static late MediaQueryData _mediaQueryData;
  static late double? screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    appContext = context;
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }

  static void darkStatus({Color color: Colors.transparent}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        // statusBarColor is used to set Status bar color in Android devices.
        statusBarColor: color,
        // To make Status bar icons color white in Android devices.
        statusBarIconBrightness: Brightness.light,
        // statusBarBrightness is used to set Status bar icon color in iOS.
        statusBarBrightness: Brightness.dark
        // Here light means dark color Status bar icons.
        ));
  }

  static void lightStatus({Color color: Colors.transparent}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        // statusBarColor is used to set Status bar color in Android devices.
        statusBarColor: color,
        // To make Status bar icons color white in Android devices.
        statusBarIconBrightness: Brightness.dark,
        // statusBarBrightness is used to set Status bar icon color in iOS.
        statusBarBrightness: Brightness.light
        // Here light means dark color Status bar icons.
        ));
  }

  static double height(double height) {
    double screenHeight = _mediaQueryData.size.height / (896 / height);
    return screenHeight;
  }

  static double width(double width) {
    double screenWidth = _mediaQueryData.size.width / (414 / width);
    return screenWidth;
  }

  static double textSize(double textSize) {
    double screenWidth = _mediaQueryData.size.width / (414 / textSize);
    return screenWidth;
  }
}
