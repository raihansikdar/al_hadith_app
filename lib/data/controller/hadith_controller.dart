import 'dart:developer';

import 'package:al_hadith_app/domain/database/database_helper.dart';
import 'package:al_hadith_app/domain/models/hadith_model.dart';
import 'package:get/get.dart';

class HadithController extends GetxController{
  bool _isLoading = false;
  List<HadithModel> hadithList = [];

  bool get isLoading => _isLoading;
  //List<HadithModel> get hadithList => _hadithList;

  Future<bool>fetchHadithListData({required int chapterId}) async{
   try{
     _isLoading = true;
     update();

     final db = await DatabaseHelper().database;
     final results = await db.query('hadith', where: 'chapter_id = ?', whereArgs: [chapterId]);
     log(results.toString());
     _isLoading = false;

     if(results.isNotEmpty){
       hadithList.clear();
       hadithList = results.map((e) => HadithModel.fromJson(e)).toList();
       // log(hadithList.toString());
       // for(final result in results){
       //   HadithModel hadithModel = HadithModel.fromJson(result);
       //   hadithList.add(hadithModel);
       // }
       // log(hadithList.toString());
       update();
       return true;
     }else{
       update();
       return false;
     }
   }catch(e){
     log('Error fetching data: $e');
     throw Exception(e.toString());
   }
  }
}