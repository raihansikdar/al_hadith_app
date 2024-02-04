import 'dart:async';
import 'dart:developer';

import 'package:al_hadith/domain/database/database_helper.dart';
import 'package:al_hadith/domain/models/chapter_model.dart';
import 'package:get/get.dart';

class ChapterController extends GetxController {
  bool _isLoading = false;
  List<ChapterModel> chapterList = [];
  List<ChapterModel> _searchList = [];

  bool get isLoading => _isLoading;
  List<ChapterModel> get searchList => _searchList;

  Future<bool> fetchChapterListData({required int id}) async {
    _isLoading = true;
    update();

    final db = await DatabaseHelper().database;
    final results = await db.query('chapter', where: 'book_id = ?', whereArgs: [id]);

   //log(results.toString());
    _isLoading = false;

    if (results.isNotEmpty) {
     chapterList.clear();
      for (final result in results) {
        final chapterModel = ChapterModel.fromJson(result);
        chapterList.add(chapterModel);
      }
      _searchList = chapterList;
      update();
      return true;
    } else {
      update();
      return false;
    }
  }

  void searchData(String searchValue){
    if (searchValue.isEmpty){
      _searchList = chapterList;
    }else{
      _searchList = chapterList.where((element) => element.title!.contains(searchValue)).toList();

    }
    update();
  }

}


