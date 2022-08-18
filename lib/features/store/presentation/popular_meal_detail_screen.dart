import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/size_config/extensions.dart';
import 'package:food_ecommerce/features/cart/presentation/cart_page.dart';
import 'package:food_ecommerce/features/cart/presentation/state/cart_cubit.dart';
import 'package:food_ecommerce/features/store/presentation/state/store_cubit.dart';
import 'package:food_ecommerce/features/store/presentation/widgets/expandable_text.dart';
import 'package:food_ecommerce/reusables/my_toast.dart';
import 'package:food_ecommerce/reusables/reusable_text_small.dart';
import '../../../reusables/reusable_icon.dart';
import '../../../reusables/reusable_text_big.dart';

class PopularMealDetailScreen extends StatefulWidget {
  static const routeName = '/popular-meal';

  const PopularMealDetailScreen({Key? key}) : super(key: key);

  @override
  State<PopularMealDetailScreen> createState() =>
      _PopularMealDetailScreenState();
}

class _PopularMealDetailScreenState extends State<PopularMealDetailScreen> {
  int count = 1;
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final storeCubit = context.read<StoreCubit>();
    final cartCubit = context.read<CartCubit>();
    final favCubit = context.watch<StoreCubit>();

    final loadedProduct = storeCubit.findById(productId);

    //checks if the value of a product favorite status is true or false and toggles it respectfully
    for (var element in storeCubit.favorites) {
      if (element.id == loadedProduct.id) {
        isFav = true;
        setState(() {});
      } else {
        isFav = false;
        setState(() {});
      }
    }

    bool _isCartItem = false;
    //checks if the product is already in cart by comparing the product title to the titles of all the products in cart
    for (var element in cartCubit.cart) {
      if (element.title == loadedProduct.title) {
        _isCartItem = true;
        setState(() {});
      }
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 55.height,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableIcon(
                  icon: Icons.clear,
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
            bottom: PreferredSize(
              child: Container(
                padding: EdgeInsets.only(
                  top: 5.height,
                  bottom: 10.height,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.height),
                    topRight: Radius.circular(20.height),
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: ReusableTextBig(text: loadedProduct.title),
                ),
              ),
              preferredSize: Size.fromHeight(20.height),
            ),
            pinned: true,
            backgroundColor: Colors.grey[400],
            expandedHeight: 270.height,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                loadedProduct.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 20.width,
                    right: 20.width,
                  ),
                  child: ExpandableText(loadedProduct.description),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 50.width,
              right: 50.width,
              bottom: 7.height,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableIcon(
                  icon: Icons.remove,
                  iconSize: 20,
                  iconColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 161, 136, 127),
                  backgroundSize: 35,
                  onpressed: () {
                    if (count > 1) {
                      count--;
                      setState(() {});
                    }
                  },
                ),
                SizedBox(
                  child: ReusableTextBig(
                      text: '\$${loadedProduct.price}' ' X ' ' $count'),
                ),
                ReusableIcon(
                  icon: Icons.add,
                  iconSize: 20,
                  iconColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 161, 136, 127),
                  backgroundSize: 35,
                  onpressed: () {
                    count++;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 100.height,
            padding: EdgeInsets.only(
              top: 10.height,
              bottom: 10.height,
              left: 20.width,
              right: 20.width,
            ),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.height),
                  topRight: Radius.circular(25.height),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (isFav == true) {
                      await favCubit.toggleFav(
                          pid: loadedProduct.id, isFav: false);
                      await favCubit.getFavorites();
                      setState(() {
                        isFav = false;
                      });
                    } else {
                      await favCubit.toggleFav(
                          pid: loadedProduct.id, isFav: true);

                      await favCubit.getFavorites();
                      setState(() {});
                    }
                  },
                  child: Container(
                    height: 50.height,
                    width: 55.width,
                    padding: EdgeInsets.only(left: 10.width, right: 10.width),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.height),
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.favorite,
                      size: 25,
                      color:
                          isFav == true ? Colors.brown[300] : Colors.grey[200],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (_isCartItem) {
                      Navigator.pushReplacementNamed(
                          context, CartPage.routeName);
                    }
                    await cartCubit.addToCart(
                        prod: loadedProduct.copyWith(quantity: count));
                    if (cartCubit.state.error == null) {
                      MyToast.show(
                          context: context,
                          text: "Added To Cart",
                          isError: false);
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
                            : '\$${loadedProduct.price * count} | Add To Cart',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
