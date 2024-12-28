import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';

TextStyle getTitleTextStyle({double? fontSize,Color? color,FontWeight? fontWeight}){
  return TextStyle(
    fontSize: fontSize?? 30,
    color:color?? AppColor.primaryColor,
    fontWeight:fontWeight?? FontWeight.bold,
  );
}

TextStyle getSmallTextStyle({double? fontSize,Color? color,FontWeight? fontWeight}){
  return TextStyle(
    fontSize: fontSize?? 16,
    color:color?? AppColor.blueVioletColor,
    fontWeight:fontWeight?? FontWeight.normal,
  );
}