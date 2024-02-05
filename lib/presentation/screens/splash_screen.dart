import 'package:al_hadith_app/presentation/screens/bottom_navigation.dart';
import 'package:al_hadith_app/presentation/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) => Get.offAll(()=> const BottomNavigationScreen()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(AssetsPath.splashScreenJPG,width: double.infinity,fit: BoxFit.cover,),
    );
  }
}
