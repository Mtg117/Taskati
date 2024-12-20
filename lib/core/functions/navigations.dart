import 'package:flutter/material.dart';
import 'package:taskati/features/upload/upload_screen.dart';

pushTo(BuildContext context, Widget newScreen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return newScreen;
  }));
}

pushWithReplacement(BuildContext context, Widget newScreen) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return newScreen;
  }));
}
