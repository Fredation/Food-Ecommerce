import 'package:flutter/material.dart';

class ReusableTextBig extends StatelessWidget {
  //const ReusableText({ Key? key }) : super(key: key);
  final String text;
  final Color? color;
  final double size;
  TextOverflow overFlow;

  ReusableTextBig({
    required this.text,
    this.color = const Color(0xFF332d2b),
    this.size = 20,
    this.overFlow = TextOverflow.ellipsis,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
