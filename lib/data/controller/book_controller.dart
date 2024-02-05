import 'dart:developer';


import 'package:al_hadith_app/domain/database/database_helper.dart';
import 'package:al_hadith_app/domain/models/book_model.dart';
import 'package:get/get.dart';

class BookController extends GetxController {

  bool _isLoading = false;
  List<BookModel> bookList = [];


  bool get isLoading => _isLoading;

  Future<bool> fetchBookListData() async {
    _isLoading = true;
    update();

    final db = await DatabaseHelper().database;
    final results = await db.query('books');
   // log(results.toString());
    _isLoading = false;


    if (results.isNotEmpty) {
      bookList = results.map((e) => BookModel.formJson(e)).toList();
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}