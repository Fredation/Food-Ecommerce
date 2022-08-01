import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ecommerce/core/size_config/extensions.dart';
import 'package:food_ecommerce/features/store/presentation/widgets/food_page_body.dart';
import 'package:food_ecommerce/screens/drawer.dart';

import '../core/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: SizedBox(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 25.height,
                bottom: 15.height,
              ),
              padding: EdgeInsets.only(
                right: 20.width,
                left: 20.width,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Builder(builder: (context) {
                        return GestureDetector(
                            onTap: () => Scaffold.of(context).openDrawer(),
                            child: const Icon(
                              Icons.menu,
                              size: 40,
                            ));
                      }),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            await FirebaseFirestore.instance
                                .collection('all_products/')
                                .get()
                                .then((data) {
                              for (var docs in data.docs) {
                                log(docs['price']);
                              }
                            });
                            // FirebaseFirestore.instance
                            //     .collection('all_products/')
                            //     .snapshots()
                            //     .listen((data) {
                            //   for (var docs in data.docs) {
                            //     log(docs['price']);
                            //   }
                            // });
                          },
                          child: Container(
                            height: 45.height,
                            width: 45.width,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(12.height),
                            ),
                            child: Image.asset('assets/images/cart.png',
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: SingleChildScrollView(child: FoodPageBody())),
          ],
        ),
      ),
    );
  }
}
