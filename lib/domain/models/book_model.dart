
class BookModel{
   int? id;
   String? title;
   String? titleAr;
   int? numberOfHadis;
   String? abvrCode;
   String? bookName;
   String? BookDescr;
   String? colorCode;

  BookModel({
     this.id,
     this.title,
     this.titleAr,
     this.numberOfHadis,
     this.abvrCode,
     this.bookName,
     this.BookDescr,
     this.colorCode,
  });

  factory BookModel.formJson(Map<String,dynamic> json){
    return BookModel(
      id: json['id'],
      title: json['title'],
      titleAr: json['title_ar'],
      numberOfHadis: json['number_of_hadis'],
      abvrCode: json['abvr_code'],
      bookName: json['book_name'],
      BookDescr: json['book_descr'],
      colorCode: json['color_code'],
    );
  }


}