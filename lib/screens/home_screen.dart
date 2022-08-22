import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/size_config/extensions.dart';
import 'package:food_ecommerce/features/address/presentation/state/address_cubit.dart';
import 'package:food_ecommerce/features/cart/presentation/cart_page.dart';
import 'package:food_ecommerce/features/cart/presentation/state/cart_cubit.dart';
import 'package:food_ecommerce/features/store/presentation/widgets/food_page_body.dart';
import 'package:food_ecommerce/screens/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<CartCubit>().getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final checkout = context.read<CartCubit>();
    final addressCubit = context.read<AddressCubit>();
    return Scaffold(
      drawer: const AppDrawer(),
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
                    children: [
                      Builder(
                        builder: (context) {
                          return GestureDetector(
                            onTap: () => Scaffold.of(context).openDrawer(),
                            child: const Icon(
                              Icons.menu,
                              size: 40,
                            ),
                          );
                        },
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            await checkout.getCart();
                            await checkout.getCartAddress();
                            await checkout.getRecipient();
                            await addressCubit.getAddresses();
                            Navigator.pushNamed(context, CartPage.routeName);
                          },
                          child: Container(
                            height: 45.height,
                            width: 45.width,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.brown[300],
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
            Expanded(
              child: SingleChildScrollView(
                child: FoodPageBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
