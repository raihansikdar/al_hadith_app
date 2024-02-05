import 'package:al_hadith_app/presentation/utility/custom_size_extention.dart';
import 'package:flutter/material.dart';

class AppColors{
  Map<int, Color> color =
  {
    50:const Color.fromRGBO(4,131,184, .1),
    100:const Color.fromRGBO(4,131,184, .2),
    200:const Color.fromRGBO(4,131,184, .3),
    300:const Color.fromRGBO(4,131,184, .4),
    400:const Color.fromRGBO(4,131,184, .5),
    500:const Color.fromRGBO(4,131,184, .6),
    600:const Color.fromRGBO(4,131,184, .7),
    700:const Color.fromRGBO(4,131,184, .8),
    800:const Color.fromRGBO(4,131,184, .9),
    900:const Color.fromRGBO(4,131,184, 1),
  };
  static const Color primaryColor = Color(0xFF19A382);
  static const Color whiteColor = Colors.white;
  static const Color boxColor = Color(0xFFF6F8F6);
  static const Color searchTextColor = Color(0xFF5C768D);
  static const Color TileTitleTextColor = Color(0xFF5D646F);
  static const Color TileSubTitleTextColor = Color(0x7F353535);
  static const Color bookTitleTextColor = Color(0xFF101010);
  static const Color bookSubTitleTextColor = Color(0x7F101010);
}

class Constants{
  Constants._();

  /*font start*/
  static const boldFontWeight = FontWeight.w700;
  static const titleFontWeight = FontWeight.w600;
  static const mediumFontWeight = FontWeight.w500;
  static const regularFontWeight = FontWeight.w400;
/*font end*/


/*font size start*/
  static final appbarTitleSize = 20.rh;
  static final textFontSize = 18.rh;
  static final titleFontSize = 22.rh;
  static final k20TitleFontSize = 20.rh;
  static final textSmallFontSize = 16.rh;
  static final k15FontSize = 15.rh;
  static final k14FontSize = 14.rh;
  static final k12FontSize = 12.rh;
  static const k10FontSize = 10.0;

/*font size end*/

}