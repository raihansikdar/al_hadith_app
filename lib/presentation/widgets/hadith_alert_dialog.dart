import 'package:al_hadith_app/presentation/utility/bangla_text.dart';
import 'package:al_hadith_app/presentation/utility/custom_size_extention.dart';
import 'package:al_hadith_app/presentation/utility/style.dart';
import 'package:al_hadith_app/presentation/widgets/text_component.dart';
import 'package:flutter/material.dart';

class HadithAlertDialog extends StatelessWidget {
  const HadithAlertDialog({
    super.key, required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.primaryColor,
      titlePadding: EdgeInsets.only(left: 16.rh,right: 8.rh,bottom: 8.rh,top: 8.rh),
      title: Row(
        children: [
          TextComponent(
            text: text,
            color: AppColors.whiteColor,
            fontSize: Constants.appbarTitleSize,
            fontWeight: Constants.mediumFontWeight,
            height: 0.0,
          ),
          const Spacer(),
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.clear,color: AppColors.whiteColor,))
        ],
      ),
      contentPadding: EdgeInsets.only(left: 16.rh,right: 24.rh,bottom: 16.rh,top: 8.rh),
      content: TextComponent(
        text: BanglaText.sohi_hadith_text,
        textAlign: TextAlign.justify,
        color: AppColors.whiteColor,
        fontSize: Constants.textSmallFontSize,
        fontWeight: Constants.mediumFontWeight,
        height: 0.0,
      ),
    );
  }
}