import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';

class customButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color? bgColor;
  final Color? textColor;
  final Function() onPressed;
  const customButton({
    super.key,
    required this.text,
    this.width=280,
    this.height=45,
    this.bgColor,
    this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: getTitleTextStyle(
            color:textColor ?? AppColor.whiteColor,
            fontSize: 18
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor:bgColor ?? AppColor.blueVioletColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
