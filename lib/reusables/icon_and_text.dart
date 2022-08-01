import 'package:flutter/material.dart';

import '../reusables/reusable_text_small.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;
  final double size;
  final double iconSize;
  final Color iconColor;
  final String text;

  IconAndText({
    required this.icon,
    required this.iconColor,
    required this.text,
    this.size = 0,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
        SizedBox(
          width: size,
        ),
        ReusableTextSmall(
          text: text,
        ),
      ],
    );
  }
}
