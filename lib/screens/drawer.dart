import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/size_config/extensions.dart';
import 'package:food_ecommerce/features/address/presentation/address_page.dart';
import 'package:food_ecommerce/features/address/presentation/state/address_cubit.dart';
import 'package:food_ecommerce/features/auth/presentation/login_screen.dart';
import 'package:food_ecommerce/features/auth/presentation/state/auth_cubit.dart';
import 'package:food_ecommerce/features/auth/presentation/update_profile_page.dart';
import 'package:food_ecommerce/features/store/presentation/favorites_page.dart';
import 'package:food_ecommerce/features/store/presentation/state/store_cubit.dart';
import 'package:food_ecommerce/reusables/image_picker.dart';
import 'package:food_ecommerce/reusables/text_image.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    final authCubit = context.watch<AuthCubit>();
    final addressCubit = context.watch<AddressCubit>();
    final storeCubit = context.watch<StoreCubit>();

    return SizedBox(
      width: 257.width,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 45.height,
            ),
            const ImagePickerWidget(),
            Align(
              alignment: Alignment.center,
              child: Text(
                authCubit.userData?.userName ?? 'Chef Fredation',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 18.width,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10.height,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                authCubit.userData?.email ?? 'Account ID: SV133445',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 14.width,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 24.height,
            ),
            Container(
              height: 2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 161, 136, 127),
                    Color.fromRGBO(196, 196, 196, 0),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.height),
            GestureDetector(
              onTap: () async {
                Navigator.pushNamed(context, UpdateProfilePage.routeName);
              },
              child: textImage(
                imageUrl: 'assets/images/user_profile_icon.png',
                text: 'My Profile',
              ),
            ),
            SizedBox(height: 10.height),
            Divider(
              color: Colors.black.withOpacity(.5),
            ),
            SizedBox(height: 10.height),
            GestureDetector(
              onTap: () async {
                await addressCubit.getAddresses();
                Navigator.pushNamed(context, AddressPage.routeName);
              },
              child: textImage(
                imageUrl: 'assets/images/address_icon.png',
                text: 'My Addresses',
              ),
            ),
            SizedBox(height: 10.height),
            Divider(
              color: Colors.black.withOpacity(.5),
            ),
            SizedBox(height: 10.height),
            GestureDetector(
              onTap: () async {
                await storeCubit.getFavorites();
                Navigator.pushNamed(context, FavoritePage.routeName);
              },
              child: textImage(
                imageUrl: 'assets/images/favorites_icon.png',
                text: 'My Favorites',
              ),
            ),
            SizedBox(height: 10.height),
            Divider(
              color: Colors.black.withOpacity(.5),
            ),
            SizedBox(height: 10.height),
            textImage(
              imageUrl: 'assets/images/order_history_icon.png',
              text: 'Order History',
            ),
            SizedBox(height: 10.height),
            Divider(
              color: Colors.black.withOpacity(.5),
            ),
            SizedBox(height: 10.height),
            SizedBox(
              height: 35.height,
            ),
            Container(
              height: 2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 161, 136, 127),
                    Color.fromRGBO(196, 196, 196, 0),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.height),
            GestureDetector(
              onTap: () async {
                log('tapped');
                await authCubit.logout();
                if (authCubit.state.error == null) {
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                } else {}
              },
              child: SizedBox(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/images/logout.png'),
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14.width,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
