// import 'dart:convert';
// import 'dart:developer';

// import 'package:food_ecommerce/features/store/domain/entities/product.dart';
// import 'package:get/get.dart';

// class ApiClient extends GetConnect implements GetxService {
//   String? token;
//   final String appBaseUrl;
//   late Map<String, String> _mainHeaders;

//   ApiClient({required this.appBaseUrl}) {
//    baseUrl = appBaseUrl;
//     timeout = const Duration(seconds: 30);
//     _mainHeaders = {
//       'Content-type': 'application/json; charset=UTF-8',
//       'Authorization': 'Bearer $token',
//     };
//   }

//   Future<Response> getData(String uri) async {
//     try {
//       Response response = await get(uri);
//       return response;
//     } catch (error) {
//       return Response(
//         statusCode: 1,
//         statusText: error.toString(),
//       );
//     }
//   }

//   Future<Response> addProduct(Product product) async {
//     try {
//       const _uri =
//           'https://food-e-commerce-dd2e0-default-rtdb.firebaseio.com/items.json';
//       final body = json.encode({
//         'id': product.id,
//         'title': product.title,
//         'subTitle': product.subTitle,
//         'description': product.description,
//         'imageUrl': product.imageUrl,
//         'price': product.price,
//       });
//       Response response = await post(_uri, body);
//       log(response.body.toString());
//       return response;
//     } catch (error) {
//       log(error.toString());
//       return Response(
//         statusCode: 1,
//         statusText: error.toString(),
//       );
//     }
//   }
// }
