// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:food_ecommerce/core/model/build_config.dart';

// class Api {
//   late Dio dio;
//   final BuildConfig buildConfig;

//   Api({required this.buildConfig}) {
//     dio = Dio(BaseOptions(
//       baseUrl: buildConfig.baseUrl,
//       receiveTimeout: 15000,
//       connectTimeout: 15000,
//       sendTimeout: 15000,
//     ));

//     dio.interceptors
//         .addAll({AppInterceptors(dio: dio, buildConfig: buildConfig)});
//   }
// }

// class AppInterceptors extends Interceptor {
//   final Dio dio;
//   final BuildConfig buildConfig;

//   AppInterceptors({required this.dio, required this.buildConfig});

//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) {
//     dio.options.baseUrl = buildConfig.baseUrl;

//     if (kDebugMode) {
//       log(err.requestOptions.path);
//       log(err.requestOptions.baseUrl);

//       print(err.response?.data.toString());
//       print(err.response?.statusCode.toString());
//     }
//     switch (err.type) {
//       case DioErrorType.connectTimeout:
//         throw ConnectTimeoutException(err.requestOptions);
//       case DioErrorType.sendTimeout:
//       case DioErrorType.receiveTimeout:
//         throw DeadlineExceededException(err.requestOptions);
//       case DioErrorType.response:
//         switch (err.response?.statusCode) {
//           case 400:
//             throw BadRequestException(
//                 res: err.response, requestOptions: err.requestOptions);
//           case 401:
//             throw UnauthorizedException(
//                 res: err.response, requestOptions: err.requestOptions);
//           case 404:
//             throw NotFoundException(
//                 res: err.response, requestOptions: err.requestOptions);
//           case 409:
//             throw ConflictException(
//                 res: err.response, requestOptions: err.requestOptions);

//           case 500:
//             throw InternalServerErrorException(
//                 res: err.response, requestOptions: err.requestOptions);
//           default:
//             throw UnknownException(
//                 res: err.response, requestOptions: err.requestOptions);
//         }
//       case DioErrorType.cancel:
//         break;
//       case DioErrorType.other:
//         throw NoInternetConnectionException(err.requestOptions);
//     }
//     return handler.next(err);
//   }

//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     return handler.next(options);
//   }

//   @override
//   void onResponse(
//     Response response,
//     ResponseInterceptorHandler handler,
//   ) {
//     dio.options.baseUrl = buildConfig.baseUrl;
//     handler.next(response);
//   }
// }

// class NoInternetConnectionException extends DioError {
//   NoInternetConnectionException(RequestOptions requestOptions)
//       : super(requestOptions: requestOptions);

//   @override
//   String toString() {
//     return 'The connection to the internet has been lost.\nPlease try again';
//   }
// }

// class UnknownException extends DioError {
//   Response? res;

//   UnknownException({this.res, required RequestOptions requestOptions})
//       : super(response: res, requestOptions: requestOptions);
//   @override
//   String toString() {
//     return res?.data['error'] ?? 'Something went wrong.\nPlease try again.';
//   }
// }

// class InternalServerErrorException extends DioError {
//   Response? res;

//   InternalServerErrorException(
//       {this.res, required RequestOptions requestOptions})
//       : super(response: res, requestOptions: requestOptions);
//   @override
//   String toString() {
//     return res?.data['error'] ?? 'Something went wrong.\nPlease try again.';
//   }
// }

// class ConflictException extends DioError {
//   Response? res;

//   ConflictException({this.res, required RequestOptions requestOptions})
//       : super(response: res, requestOptions: requestOptions);
//   @override
//   String toString() {
//     return res?.data['error'] ?? 'Something went wrong.\nPlease try again.';
//   }
// }

// class NotFoundException extends DioError {
//   Response? res;

//   NotFoundException({this.res, required RequestOptions requestOptions})
//       : super(response: res, requestOptions: requestOptions);
//   @override
//   String toString() {
//     return res?.data['error'] ?? 'Something went wrong.\nPlease try again.';
//   }
// }

// class UnauthorizedException extends DioError {
//   Response? res;

//   UnauthorizedException({this.res, required RequestOptions requestOptions})
//       : super(response: res, requestOptions: requestOptions);
//   @override
//   String toString() {
//     return res?.data['error'] ?? 'Something went wrong.\nPlease try again.';
//   }
// }

// class BadRequestException extends DioError {
//   Response? res;

//   BadRequestException({this.res, required RequestOptions requestOptions})
//       : super(response: res, requestOptions: requestOptions);
//   @override
//   String toString() {
//     return res?.data['error'] ?? 'Something went wrong.\nPlease try again.';
//   }
// }

// class ConnectTimeoutException extends DioError {
//   ConnectTimeoutException(RequestOptions requestOptions)
//       : super(requestOptions: requestOptions);

//   @override
//   String toString() {
//     return 'Connection timeout';
//   }
// }

// class DeadlineExceededException extends DioError {
//   DeadlineExceededException(RequestOptions requestOptions)
//       : super(requestOptions: requestOptions);
//   @override
//   String toString() {
//     return 'The connection has timed out.\nplease try again.';
//   }
// }
