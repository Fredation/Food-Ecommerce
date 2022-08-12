import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/app_colors.dart';
import 'package:food_ecommerce/core/size_config/extensions.dart';
import 'package:food_ecommerce/features/store/presentation/meal_detail_screen.dart';
import 'package:food_ecommerce/features/store/presentation/popular_meal_detail_screen.dart';
import 'package:food_ecommerce/features/store/presentation/state/store_cubit.dart';
import 'package:food_ecommerce/reusables/icon_and_text.dart';
import 'package:food_ecommerce/reusables/reusable_text_big.dart';
import 'package:food_ecommerce/reusables/reusable_text_small.dart';

class FoodPageBody extends StatefulWidget {
  //const FoodPageBody({ Key? key }) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var currentPageValue = 0.0;

  var scaleFactor = 0.85;

  @override
  void initState() {
    pageController.addListener(
      () {
        setState(() {
          currentPageValue = pageController.page!;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storeCubit = context.read<StoreCubit>();

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4167,
          child: PageView.builder(
              controller: pageController,
              itemCount: storeCubit.products.length,
              itemBuilder: (ctx, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      MealDetailScreen.routeName,
                      arguments: storeCubit.products[index].id,
                    );
                  },
                  child: _buildPageItem(index))),
        ),
        SizedBox(
          height: 10.height,
        ),
        DotsIndicator(
          dotsCount: storeCubit.products.length,
          position: currentPageValue,
          decorator: DotsDecorator(
            activeColor: Colors.brown[300],
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.height)),
          ),
        ),
        SizedBox(
          height: 15.height,
        ),
        Container(
          margin: EdgeInsets.only(
            left: 30.width,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ReusableTextBig(text: 'Popular'),
              SizedBox(
                width: 20.width,
              ),
              SizedBox(
                child: ReusableTextSmall(text: 'Food Pairing'),
              )
            ],
          ),
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: storeCubit.products.length,
            itemBuilder: (ctx, index) {
              final product = storeCubit.products[index];
              return GestureDetector(
                onTap: () async {
                  await storeCubit.getFavorites();
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              );
            }),
      ],
    );
  }

  Widget _buildPageItem(int index) {
    final _height = MediaQuery.of(context).size.height * 0.3125;
    Matrix4 matrix = Matrix4.identity();
    if (index == currentPageValue.floor()) {
      var currentScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == currentPageValue.floor() + 1) {
      var currentScale =
          scaleFactor + (currentPageValue - index + 1) * (1 - scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == currentPageValue.floor() - 1) {
      var currentScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      //matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.85;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _height * (1 - currentScale) / 2, 1);
    }
    final product = context.read<StoreCubit>().products[index];
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: _height,
            width: double.infinity,
            margin: EdgeInsets.only(
              right: 7.width,
              left: 7.width,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.height),
              color: index.isEven
                  ? const Color.fromARGB(255, 146, 158, 168)
                  : const Color.fromARGB(255, 137, 157, 137),
              image: DecorationImage(
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1786,
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 10.height,
                right: 17.width,
                left: 17.width,
                bottom: 15.height,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.height),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                    offset: Offset(0, 3),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-3, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(3, 0),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(left: 15.width),
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.height,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: ReusableTextBig(
                        text: product.title,
                      ),
                    ),
                    SizedBox(
                      height: 7.height,
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
                          width: 10.width,
                        ),
                        ReusableTextSmall(
                          text: '4.5',
                          size: 13,
                        ),
                        SizedBox(
                          width: 10.width,
                        ),
                        ReusableTextSmall(
                          text: '1287',
                          size: 13,
                        ),
                        SizedBox(
                          width: 5.width,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconAndText(
                          icon: Icons.circle_sharp,
                          iconColor: AppColors.iconColor1,
                          text: 'Normal',
                        ),
                        SizedBox(
                          width: 15.width,
                        ),
                        IconAndText(
                          icon: Icons.location_on,
                          iconColor: AppColors.mainColor,
                          text: '1.7km',
                        ),
                        SizedBox(
                          width: 15.width,
                        ),
                        IconAndText(
                          icon: Icons.access_time_rounded,
                          iconColor: AppColors.iconColor2,
                          text: '32min',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
