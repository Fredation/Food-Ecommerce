import 'package:flutter/material.dart';
import 'package:food_ecommerce/core/app_colors.dart';
import 'package:food_ecommerce/core/size_config/extensions.dart';
import 'package:food_ecommerce/reusables/reusable_text_small.dart';

class ExpandableText extends StatefulWidget {
  //const ExpandableText({ Key? key }) : super(key: key);
  final String text;

  ExpandableText(this.text);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool isHidden = true;
  double textHeight = 100.height;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(
        0,
        textHeight.toInt(),
      );
      secondHalf = widget.text.substring(
        textHeight.toInt() + 1,
        widget.text.length,
      );
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? ReusableTextSmall(
              text: firstHalf,
              size: 15.height,
            )
          : Column(
              children: [
                ReusableTextSmall(
                  text:
                      isHidden ? (firstHalf + '...') : (firstHalf + secondHalf),
                  size: 15.height,
                ),
                InkWell(
                  onTap: () {
                    setState(
                      () {
                        isHidden = !isHidden;
                      },
                    );
                  },
                  child: Row(
                    children: [
                      ReusableTextSmall(
                        text: isHidden ? 'Show more' : 'Show less',
                        color: AppColors.mainColor,
                      ),
                      Icon(
                        isHidden ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
