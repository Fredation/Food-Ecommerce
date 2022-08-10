import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/features/cart/presentation/state/cart_cubit.dart';
import 'package:food_ecommerce/features/cart/presentation/widgets/item_counter_widget.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';

class CartItem extends StatefulWidget {
  Product product;
  CartItem({Key? key, required this.product}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    final checkout = context.read<CartCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(widget.product.title,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 16,
                          // height:
                        )),
                // minVerticalPadding: 100/,
                subtitle: Text(
                  ' ${widget.product.price} per item',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                  ),
                )),
          ),
          const SizedBox(width: 20),
          ItemCounterWidget(
              onChanged: (count) async {
                // log(count.toString());
                if (count == 0) {
                  await checkout.removeFromCart(prod: widget.product);
                  await checkout.getCart();
                } else {
                  widget.product = widget.product.copyWith(quantity: count);
                  await checkout.addToCart(prod: widget.product);
                  await checkout.getCart();
                }
                setState(() {});
              },
              count: widget.product.quantity)
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
