import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ecommerce/core/data_utils/constants.dart';
import 'package:food_ecommerce/core/data_utils/format_money.dart';
import 'package:food_ecommerce/features/cart/presentation/widgets/cart_item.dart';
import 'package:food_ecommerce/features/cart/presentation/state/cart_cubit.dart';

class CartPage extends StatefulWidget {
  static const routeName = '/cart-page';
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final ckoutCubit = context.watch<CartCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 70,
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.maybePop(context);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(201, 201, 201, 0.1),
                    borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          const Text(
            "Recipient",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w600,
            ),
          ),
          Card(
            color: Colors.brown[300],
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Add Recipient',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            "Delivery Address",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w600,
            ),
          ),
          const Card(
            color: Colors.black,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Add Delivery Address',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Payment Details',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SvgPicture.asset("assets/images/visa_icon.svg"),
                  const SizedBox(width: 10),
                  SvgPicture.asset("assets/images/mastercard_icon.svg"),
                  const SizedBox(width: 10),
                  SvgPicture.asset("assets/images/verve_icon.svg"),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Pay with credit/debit cards',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          Column(
            children: List.generate(
              ckoutCubit.cart.length,
              (index) {
                final p = ckoutCubit.cart[index];
                return Card(
                  child: CartItem(
                    product: p,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Total Price',
                      style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontSize: 12,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                        formatMoney(
                            amount: ckoutCubit.getSubTotal(),
                            symbol: nairaSign),
                        style:
                            Theme.of(context).textTheme.headline6!.copyWith()),
                  ],
                )),
                Expanded(
                  child: AbsorbPointer(
                    absorbing: ckoutCubit.getSubTotal() < 1500,
                    child: Opacity(
                      opacity: (ckoutCubit.cart.isNotEmpty) ? 1 : .3,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 211,
                          decoration: BoxDecoration(
                            color: Colors.brown[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Make Payment',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white.withOpacity(.1),
                                ),
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 20,
                                  color: Colors.white.withOpacity(.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
