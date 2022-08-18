import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/size_config/extensions.dart';
import 'package:food_ecommerce/features/cart/presentation/cart_page.dart';
import 'package:food_ecommerce/features/cart/presentation/state/cart_cubit.dart';
import 'package:food_ecommerce/features/store/presentation/state/store_cubit.dart';
import 'package:food_ecommerce/features/store/presentation/widgets/expandable_text.dart';
import 'package:food_ecommerce/reusables/my_toast.dart';

import '../../../reusables/reusable_text_big.dart';
import '../../../reusables/reusable_text_small.dart';
import '../../../reusables/reusable_icon.dart';
import '../../../reusables/icon_and_text.dart';
import '../../../core/app_colors.dart';

class MealDetailScreen extends StatefulWidget {
  const MealDetailScreen({Key? key}) : super(key: key);
  static const routeName = '/meal-detail';

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;

    final storeCubit = context.read<StoreCubit>();
    final cartCubit = context.read<CartCubit>();

    final loadedProduct = storeCubit.findById(productId);
    bool _isCartItem = false;

    //checks if the product is already in cart by comparing the product title to the titles of all the products in cart
    for (var element in cartCubit.cart) {
      if (element.title == loadedProduct.title) {
        _isCartItem = true;
        setState(() {});
      }
    }
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            child: Container(
              height: 300.height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.orange,
                image: DecorationImage(
                  image: NetworkImage(loadedProduct.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 15.width,
            right: 15.width,
            top: 30.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableIcon(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onpressed: () {
                    Navigator.pop(context);
                  },
                ),
                GestureDetector(
                  onTap: () async {
                    await cartCubit.getCart();
                    Navigator.pushReplacementNamed(context, CartPage.routeName);
                  },
                  child: Container(
                    height: 45.height,
                    width: 45.width,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.height),
                    ),
                    child: Image.asset('assets/images/cart.png',
                        color: Colors.brown[300]),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            top: 270.height,
            child: Container(
              padding: EdgeInsets.only(
                left: 15.width,
                top: 15.height,
                right: 15.width,
              ),
              height: MediaQuery.of(context).size.height * .7,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.height),
                  topRight: Radius.circular(
                    (25.height),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableTextBig(
                    text: loadedProduct.title,
                    size: 23.height,
                  ),
                  Row(
                    children: [
                      Wrap(
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            color: AppColors.mainColor,
                            size: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.height,
                      ),
                      ReusableTextSmall(
                        text: '4.5',
                        size: 13,
                      ),
                      SizedBox(
                        width: 10.height,
                      ),
                      ReusableTextSmall(
                        text: '1287',
                        size: 13,
                      ),
                      SizedBox(
                        width: 5.height,
                      ),
                      ReusableTextSmall(
                        text: 'comments',
                        size: 13,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.height,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconAndText(
                        icon: Icons.circle_sharp,
                        iconColor: AppColors.iconColor1,
                        text: 'Normal',
                        size: 5,
                      ),
                      SizedBox(
                        width: 15.height,
                      ),
                      IconAndText(
                        icon: Icons.location_on,
                        iconColor: AppColors.mainColor,
                        text: '1.7km',
                        size: 5,
                      ),
                      SizedBox(
                        width: 15.height,
                      ),
                      IconAndText(
                        icon: Icons.access_time_rounded,
                        iconColor: AppColors.iconColor2,
                        text: '32min',
                        size: 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.height,
                  ),
                  ReusableTextBig(
                    text: 'Introduce',
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: ExpandableText(loadedProduct.description),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 20.width,
          right: 20.width,
          top: 22.height,
          bottom: 22.height,
        ),
        height: 100.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.height),
            topRight: Radius.circular(25.height),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50.height,
              width: 100.width,
              padding: EdgeInsets.only(left: 10.width, right: 10.width),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.width),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (count > 1) {
                        count--;
                        setState(() {});
                      }
                    },
                    child: const Icon(
                      Icons.remove,
                      color: AppColors.signColor,
                    ),
                  ),
                  ReusableTextBig(
                    text: '$count',
                  ),
                  GestureDetector(
                    onTap: () {
                      count++;
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.add,
                      color: AppColors.signColor,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (_isCartItem) {
                  Navigator.pushReplacementNamed(context, CartPage.routeName);
                }
                await cartCubit.addToCart(
                    prod: loadedProduct.copyWith(quantity: count));
                if (cartCubit.state.error == null) {
                  MyToast.show(
                      context: context, text: "Added To Cart", isError: false);
                }
                await cartCubit.getCart();
              },
              child: Container(
                height: 50.height,
                width: 170.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.height),
                  color: Colors.brown[300],
                ),
                child: Center(
                  child: ReusableTextSmall(
                    size: 16,
                    text: _isCartItem
                        ? 'Already in Cart'
                        : '\$${loadedProduct.price * count} | Add to Cart',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
