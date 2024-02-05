class ChapterModel {
   int? id;
   int? chapterId;
   int? bookId;
   String? title;
   String? hadisRange;
   int? number;
   String? bookName;

  ChapterModel({
     this.id,
     this.chapterId,
     this.bookId,
     this.title,
     this.hadisRange,
     this.number,
     this.bookName,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['id'],
      chapterId: json['chapter_id'],
      bookId: json['book_id'],
      title: json['title'],
      hadisRange: json['hadis_range'],
      number: json['number'],
      bookName: json['book_name'],
    );
  }
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['chapter_id'] = chapterId;
  //   data['book_id'] = bookId;
  //   data['title'] = title;
  //   data['hadis_range'] = hadisRange;
  //   data['book_name'] = bookName;
  //   return data;
  // }
}
