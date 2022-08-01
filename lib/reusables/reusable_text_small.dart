import 'package:flutter/material.dart';

class ReusableTextSmall extends StatelessWidget {
  //const ReusableText({ Key? key }) : super(key: key);
  final String text;
  final Color? color;
  final double size;
  double height;

  ReusableTextSmall({
    required this.text,
    this.color = Colors.black38,
    // this.color = const Color(0xFF332d2b),
    this.size = 13,
    this.height = 1.7,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: 'Lato',
        //fontWeight: FontWeight.w400,
        height: height,
      ),
    );
  }
}
