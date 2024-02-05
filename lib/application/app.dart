
import 'package:al_hadith_app/application/state_binders_controller.dart';
import 'package:al_hadith_app/presentation/screens/splash_screen.dart';
import 'package:al_hadith_app/presentation/utility/custom_size_extention.dart';
import 'package:al_hadith_app/presentation/utility/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlHadithApp extends StatelessWidget {
  const AlHadithApp({super.key});


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    ScreenSizes.screenWidth = size.width;
    ScreenSizes.screenHeight = size.height;

    return GetMaterialApp(
      initialBinding: StateBinder(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(AppColors.primaryColor.value, AppColors().color),
      ),
      home: const SplashScreen(),
    );
  }
}