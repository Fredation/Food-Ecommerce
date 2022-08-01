import 'package:flutter/material.dart';

class ReusableIcon extends StatelessWidget {
  //const ReusableIcon({Key? key}) : super(key: key);
  final IconData icon;
  final double backgroundSize;
  final Color iconColor;
  final Color backgroundColor;
  final double iconSize;
  final Function() onpressed;

  ReusableIcon({
    required this.icon,
    this.backgroundSize = 35,
    this.iconColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.iconSize = 16,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: backgroundSize,
      width: backgroundSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(backgroundSize / 2),
        color: backgroundColor,
      ),
      child: Center(
        child: IconButton(
          onPressed: onpressed,
          icon: Icon(
            icon,
            size: iconSize,
          ),
          color: iconColor,
        ),
      ),
    );
  }
}
