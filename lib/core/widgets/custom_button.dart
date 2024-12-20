import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';

class customButton extends StatelessWidget {
  final String text;
  const customButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          text,
          style: getTitleTextStyle(
            color: AppColor.whiteColor,
            fontSize: 18
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.blueVioletColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
