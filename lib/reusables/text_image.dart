import 'package:flutter/material.dart';
import 'package:food_ecommerce/core/size_config/extensions.dart';

Widget textImage({
  required String imageUrl,
  required String text,
  Color textColor = Colors.black,
}) {
  return Row(
    children: [
      SizedBox(width: 26.width),
      SizedBox(
        height: 26.height,
        width: 24.width,
        child: Image.asset(
          imageUrl,
          color: Colors.brown[300],
        ),
      ),
      SizedBox(width: 26.width),
      Text(
        text,
        style: TextStyle(
          fontFamily: 'Lato',
          fontSize: 18.width,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
      ),
    ],
  );
}
