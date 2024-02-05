class HadithModel {
  int? id;
  int? bookId;
  String? bookName;
  int? chapterId;
  int? sectionId;
  String? hadithKey;
  int? hadithId;
  String? narrator;
  String? bn;
  String? ar;
  String? arDiacless;
  String? note;
  int? gradeId;
  String? grade;
  String? gradeColor;

  HadithModel({ this.id,
    this.bookId,
    this.bookName,
    this.chapterId,
    this.sectionId,
    this.hadithKey,
    this.hadithId,
    this.narrator,
    this.bn,
    this.ar,
    this.arDiacless,
    this.note,
    this.gradeId,
    this.grade,
    this.gradeColor,
  }
  );

  factory HadithModel.fromJson(Map<String,dynamic> json){
    return HadithModel(
        id: json['id'],
        bookId: json['book_id'],
        bookName: json['book_name'],
        chapterId: json['chapter_id'],
        sectionId: json['section_id'],
        hadithKey: json['hadith_key'],
        hadithId: json['hadith_id'],
        narrator: json['narrator'],
        bn: json['bn'],
        ar: json['ar'],
        arDiacless: json['ar_diacless'],
         note: json['note'],
      gradeId: json['grade_id'],
      grade: json['grade'],
      gradeColor: json['grade_color']
    );
  }

}