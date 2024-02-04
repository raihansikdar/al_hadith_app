import 'package:al_hadith/presentation/utility/custom_size_extention.dart';
import 'package:al_hadith/presentation/utility/style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatelessWidget {
   CarouselSliderWidget({
    super.key,

  });

  List<String> title = [
    "A slave [of Allah] may utter a word without giving it much thought by which he slips into the fire a distance further than that between east and west. \n\n [ Bukhari and Muslim ]"
  ];


  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150.rh,
        autoPlay: true,
        viewportFraction: 1,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
      items: title.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Padding(
                  padding:  EdgeInsets.only(top: 0,left: 16.rh,right: 16.rh,bottom: 0),
                  child: Text(
                    '$i',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.rh,color: AppColors.whiteColor,fontWeight: FontWeight.w600,letterSpacing: 0.10),
                  ),
                )
            );
          },
        );
      }).toList(),
    );
  }
}