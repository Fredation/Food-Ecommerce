import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/size_config/extensions.dart';
import 'package:food_ecommerce/features/store/presentation/state/store_cubit.dart';
import 'package:food_ecommerce/features/store/presentation/widgets/expandable_text.dart';
import 'package:food_ecommerce/reusables/reusable_text_small.dart';
import '../../../reusables/reusable_icon.dart';
import '../../../reusables/reusable_text_big.dart';
import '../../../core/app_colors.dart';

class PopularMealDetailScreen extends StatefulWidget {
  static const routeName = '/popular-meal';

  @override
  State<PopularMealDetailScreen> createState() =>
      _PopularMealDetailScreenState();
}

class _PopularMealDetailScreenState extends State<PopularMealDetailScreen> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final storeCubit = context.read<StoreCubit>();

    final loadedProduct = storeCubit.findById(productId);
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
                Container(
                  height: 45.height,
                  width: 45.width,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.height),
                  ),
                  child: Image.asset('assets/images/cart.png',
                      color: AppColors.mainColor),
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
                  backgroundColor: AppColors.mainColor,
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
                  backgroundColor: AppColors.mainColor,
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
                Container(
                  height: 50.height,
                  width: 55.width,
                  padding: EdgeInsets.only(left: 10.width, right: 10.width),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.height),
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    size: 25,
                    color: AppColors.mainColor,
                  ),
                ),
                Container(
                  height: 50.height,
                  width: 170.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.height),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                    child: ReusableTextSmall(
                      size: 16,
                      text: '\$${loadedProduct.price * count} | Add To Cart',
                      color: Colors.white,
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
