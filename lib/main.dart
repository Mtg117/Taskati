import 'package:flutter/material.dart';
import 'package:taskati/core/model/task_adapter.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/features/intro/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox('user');
  await Hive.openBox('task');
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.blueVioletColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.blueVioletColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.blueVioletColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                     errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                     focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(

      ),
    );
  }
}
