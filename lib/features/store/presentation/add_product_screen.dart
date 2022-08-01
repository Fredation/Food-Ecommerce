// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:food_ecommerce/core/data_utils/validators.dart';
// import 'package:food_ecommerce/features/store/domain/entities/product.dart';
// import 'package:food_ecommerce/reusables/input_field.dart';
// //import 'package:get/get.dart';

// class AddProductScreen extends StatelessWidget {
//   static const routeName = '/addProduct-screen';

//   final _formKey = GlobalKey<FormState>();
//   final _titleController = TextEditingController();
//   final _subTitleController = TextEditingController();
//   final _priceController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _imageUrlController = TextEditingController();

//   // String? _fieldValidator(String? value) {
//   //   // ignore: curly_braces_in_flow_control_structures
//   //   if (GetUtils.isLengthGreaterOrEqual(value, 3)) {
//   //     return null;
//   //   } else {
//   //     return 'Invalid input';
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Product'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               if (_formKey.currentState!.validate()) {
//                 final product = Product(
//                   id: '1',
//                   title: _titleController.text,
//                   subTitle: _subTitleController.text,
//                   description: _descriptionController.text,
//                   imageUrl: _imageUrlController.text,
//                   price: double.parse(_priceController.text),
//                 );
//                 try {
//                   //Get.find<ApiClient>().addProduct(product);
//                 } catch (e) {
//                   log(e.toString());
//                 }
//               }
//             },
//             icon: const Icon(Icons.save),
//           ),
//         ],
//       ),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: const EdgeInsets.only(
//             left: 10,
//             right: 10,
//           ),
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             InputField(
//               hintText: "enter product title",
//               label: "Title",
//               controller: _titleController,
//               validator: MyFormValidator.validateContent,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             InputField(
//               hintText: "enter product subtitle",
//               label: "Subtitle",
//               controller: _subTitleController,
//               validator: MyFormValidator.validateContent,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             InputField(
//               hintText: "enter product price",
//               label: "Price",
//               controller: _priceController,
//               validator: MyFormValidator.validateAmount,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             InputField(
//               hintText: "enter product description",
//               label: "Description",
//               controller: _descriptionController,
//               validator: MyFormValidator.validateContent,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             InputField(
//               hintText: "enter product image url",
//               label: "Image Url",
//               controller: _imageUrlController,
//               validator: MyFormValidator.validateContent,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             GestureDetector(
//               onTap: () {
//                 if (_formKey.currentState!.validate()) {
//                   final product = Product(
//                     id: '1',
//                     title: _titleController.text,
//                     subTitle: _subTitleController.text,
//                     description: _descriptionController.text,
//                     imageUrl: _imageUrlController.text,
//                     price: double.parse(_priceController.text),
//                   );
//                   try {
//                     //Get.find<ApiClient>().addProduct(product);
//                   } catch (e) {
//                     log(e.toString());
//                   }
//                 }
//               },
//               child: Container(
//                 height: 50,
//                 width: 50,
//                 decoration: BoxDecoration(color: Colors.blue[400]),
//                 child: const Center(
//                   child: Text(
//                     "Add Product",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
