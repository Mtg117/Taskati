import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/features/upload/upload_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      pushWithReplacement(context, UploadScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('./assets/images/logo.json'),
            Text("Taskati",
                style: getTitleTextStyle(
                  fontSize: 37,
                  fontWeight: FontWeight.bold,
                  color: AppColor.blackColor,
                )),
            Text("It's time to get organized!",
                style: getTitleTextStyle(
                  color: AppColor.greyColor,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                )),
          ],
        ),
      ),
    );
  }
}
