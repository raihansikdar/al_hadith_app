
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlHadithApp extends StatelessWidget {
  const AlHadithApp({super.key});


  @override
  Widget build(BuildContext context) {
    // Get the screen size
    Size size = MediaQuery.of(context).size;
    // Set the screen width and height in the ScreenSizes utility class
    ScreenSizes.screenWidth = size.width;
    ScreenSizes.screenHeight = size.height;

    return GetMaterialApp(
      initialBinding: StateBinder(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(AppColors.primaryColor.value, AppColors().color),

      ),
      home: const BottomNavigationScreen(),
    );
  }
}