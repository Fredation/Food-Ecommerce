import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/app_colors.dart';
import 'package:food_ecommerce/core/size_config/extensions.dart';
import 'package:food_ecommerce/features/store/domain/entities/product.dart';
import 'package:food_ecommerce/features/store/presentation/popular_meal_detail_screen.dart';
import 'package:food_ecommerce/features/store/presentation/state/store_cubit.dart';
import 'package:food_ecommerce/reusables/icon_and_text.dart';
import 'package:food_ecommerce/reusables/loader_view.dart';
import 'package:food_ecommerce/reusables/my_appbar.dart';
import 'package:food_ecommerce/reusables/reusable_text_big.dart';
import 'package:food_ecommerce/reusables/reusable_text_small.dart';

class FavoritePage extends StatefulWidget {
  static const routeName = '/fav_page';
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final storeCubit = context.read<StoreCubit>();
    List<Product> products = [];
    for (var element in storeCubit.favorites) {
      for (var prod in storeCubit.products) {
        if (prod.id == element.id && element.isFavorite == true) {
          products.add(prod);
        }
      }
    }

    return LoaderLayout(
      loading: storeCubit.state.isLoading,
      child: Scaffold(
        appBar: MyAppBar(title: 'Favorites'),
        body: SingleChildScrollView(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (ctx, index) {
              final product = products[index];
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                  padding: const EdgeInsets.only(right: 30),
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    color: Colors.brown[300],
                  ),
                  child: const Text(
                    'Remove',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onDismissed: (endToStart) async {
                  await storeCubit.toggleFav(pid: product.id, isFav: false);
                  await storeCubit.getFavorites();
                  setState(() {});
                },
                child: GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pushNamed(
                      PopularMealDetailScreen.routeName,
                      arguments: product.id,
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 30.width,
                      right: 30.width,
                      bottom: 10.height,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 100.height,
                          width: 100.width,
                          decoration: BoxDecoration(
                            color: AppColors.yellowColor,
                            borderRadius: BorderRadius.circular(20.height),
                            image: DecorationImage(
                                image: NetworkImage(product.imageUrl),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 80,
                            margin: EdgeInsets.only(
                              left: 10.width,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.height),
                                  bottomRight: Radius.circular(20.height),
                                ),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 2,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ReusableTextBig(text: product.title),
                                  ReusableTextSmall(text: product.subTitle),
                                  Row(
                                    children: [
                                      IconAndText(
                                        icon: Icons.circle_sharp,
                                        iconColor: AppColors.iconColor1,
                                        text: 'Normal',
                                        iconSize: 20,
                                      ),
                                      SizedBox(
                                        width: 10.width,
                                      ),
                                      IconAndText(
                                        icon: Icons.location_on,
                                        iconColor: AppColors.mainColor,
                                        text: '1.7km',
                                        iconSize: 20,
                                      ),
                                      SizedBox(
                                        width: 10.width,
                                      ),
                                      IconAndText(
                                        icon: Icons.access_time_rounded,
                                        iconColor: AppColors.iconColor2,
                                        text: '32min',
                                        iconSize: 20,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
