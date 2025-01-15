import 'dart:io';
import 'package:flutter/material.dart';
import 'package:taskati/core/utils/text_style.dart';

class header extends StatelessWidget {
  const header({
    super.key,
    required this.title,
    required this.customWidget,
  });

  final String title;
  final Widget customWidget;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: getTitleTextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              "Have a Nice Day!",
              style: getSmallTextStyle(),
            ),
          ],
        ),
        Spacer(),
       customWidget,
      ],
    );
  }
}
