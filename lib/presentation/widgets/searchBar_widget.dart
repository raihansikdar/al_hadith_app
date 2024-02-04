import 'package:al_hadith/presentation/utility/custom_size_extention.dart';
import 'package:al_hadith/presentation/utility/style.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
   SearchBarWidget({
    super.key,
  });
TextEditingController _searchValueController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _searchValueController,
      onChanged: (String value){

      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 4.rh,horizontal: 16.rh),
          filled: true,
          fillColor: AppColors.whiteColor,
          enabledBorder:   OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.rh),
            borderSide: const BorderSide(color: AppColors.whiteColor,width: 2),
          ),
          focusedBorder:   OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.rh),
            borderSide: const BorderSide(color: AppColors.whiteColor,width: 2),
          ),
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.rh),
            borderSide: const BorderSide(color: AppColors.whiteColor,width: 2),
          ),
          hintStyle: TextStyle(
            fontSize: Constants.k14FontSize,
            color: AppColors.searchTextColor,
            fontWeight: Constants.regularFontWeight,
            letterSpacing: 0.4,
          ),
          suffixIcon: const Icon(Icons.search),
          hintText: "Search y chapter"
      ),
    );
  }
}