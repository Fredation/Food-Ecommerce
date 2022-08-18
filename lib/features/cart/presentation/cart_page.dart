import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ecommerce/core/data_utils/constants.dart';
import 'package:food_ecommerce/core/data_utils/format_money.dart';
import 'package:food_ecommerce/features/cart/presentation/widgets/add_address.dart';
import 'package:food_ecommerce/features/cart/presentation/widgets/add_recipient.dart';
import 'package:food_ecommerce/features/cart/presentation/widgets/address_widget.dart';
import 'package:food_ecommerce/features/cart/presentation/widgets/cart_item.dart';
import 'package:food_ecommerce/features/cart/presentation/state/cart_cubit.dart';
import 'package:food_ecommerce/features/cart/presentation/widgets/recipient_widget.dart';
import 'package:food_ecommerce/reusables/loader_view.dart';
import 'package:food_ecommerce/reusables/my_appbar.dart';

class CartPage extends StatefulWidget {
  static const routeName = '/cart-page';
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getRecipient();
    context.read<CartCubit>().getCartAddress();
  }

  @override
  Widget build(BuildContext context) {
    final ckoutCubit = context.watch<CartCubit>();
    final address = ckoutCubit.cartAddress;
    final recipient = ckoutCubit.recipient;
    return LoaderLayout(
      loading: ckoutCubit.state.isLoading,
      overlay: true,
      child: Scaffold(
        appBar: MyAppBar(title: "Checkout"),
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
            recipient?.name == null
                ? GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, AddRecipient.routeName),
                    child: Card(
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
                  )
                : RecipientWidget(recipient: recipient!),
            const SizedBox(height: 20),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            const Text(
              "Delivery Address",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w600,
              ),
            ),
            address?.houseNumber == null
                ? GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, AddAddress.routeName),
                    child: const Card(
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
                  )
                : AddressWidget(address: address!),
            const SizedBox(height: 10),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
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
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith()),
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
      ),
    );
  }
}
