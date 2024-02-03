import 'package:al_hadith/data/controller/chapter_controller.dart';
import 'package:al_hadith/data/debouncer.dart';
import 'package:al_hadith/presentation/screen/hadith_screen.dart';
import 'package:al_hadith/presentation/utility/assets_path.dart';
import 'package:al_hadith/presentation/utility/bangla_text.dart';
import 'package:al_hadith/presentation/utility/custom_size_extention.dart';
import 'package:al_hadith/presentation/utility/style.dart';
import 'package:al_hadith/presentation/widgets/searchBar_widget.dart';
import 'package:al_hadith/presentation/widgets/text_component.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChapterScreen extends StatefulWidget {
  final int bookId;

  ChapterScreen({super.key, required this.bookId});

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<ChapterController>().fetchChapterListData(id: widget.bookId);
    });

    //  print("========>${widget.bookId}");
    super.initState();
  }

  final _debouncer = Debouncer(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        // background color issue solve when keyboard solve
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 8.rh),
            child: GetBuilder<ChapterController>(builder: (_chapterController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent(
                      text:  _chapterController.chapterList.isNotEmpty
                          ? _chapterController.chapterList.first.bookName ?? ''
                          : 'No Book Name',
                      color: AppColors.whiteColor,
                      fontSize: Constants.textSmallFontSize,
                      fontWeight: Constants.titleFontWeight,
                      height: 0.06),
                  SizedBox(
                    height: 14.rh,
                  ),
                  TextComponent(
                      text: "7525 Hadith",
                      color: AppColors.whiteColor,
                      fontSize: Constants.k12FontSize,
                      fontWeight: Constants.mediumFontWeight,
                      height: 0.10),
                ],
              );
            }),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 8.rh),
              child: SvgPicture.asset(AssetsPath.dothSVG),
            ),
          ],
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
        ),

        body: GetBuilder<ChapterController>(builder: (_chapterController) {
          if (_chapterController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container(
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.rh),
                topRight: Radius.circular(20.rh),
              ),
              color: AppColors.boxColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(16.rh),
              child: Column(
                children: [
                  TextFormField(
                    // controller: _searchValueController,
                    onChanged: (String value) {
                      _debouncer.run(() {
                        _chapterController.searchData(value);
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 4.rh, horizontal: 16.rh),
                      filled: true,
                      fillColor: AppColors.whiteColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.rh),
                        borderSide: const BorderSide(
                            color: AppColors.whiteColor, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.rh),
                        borderSide: const BorderSide(
                            color: AppColors.whiteColor, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.rh),
                        borderSide: const BorderSide(
                            color: AppColors.whiteColor, width: 2),
                      ),
                      hintStyle: TextStyle(
                        fontSize: Constants.k15FontSize,
                        color: AppColors.searchTextColor.withOpacity(0.6),
                        fontWeight: Constants.mediumFontWeight,
                        letterSpacing: 0.4,
                      ),
                      suffixIcon: const Icon(Icons.search),
                      hintText: BanglaText.search_text,
                    ),
                  ),
                  SizedBox(
                    height: 8.rh,
                  ),
                  Expanded(
                    child: _chapterController.searchList.isEmpty
                        ? Center(
                      child: Column(
                        children: [
                          Image.asset(AssetsPath.noDataFoundPNG),
                          Text(
                            BanglaText.no_data_found_text,
                            style: TextStyle(
                              fontSize: Constants.appbarTitleSize,
                              color:
                              AppColors.searchTextColor.withOpacity(0.5),
                              fontWeight: Constants.boldFontWeight,
                            ),
                          ),
                        ],
                      ),
                    )
                        : ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _chapterController.searchList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(10.rh),
                          ),
                          child: ListTile(
                            onTap: (){
                              Get.to(()=>HadithScreen(chapterId: _chapterController.chapterList[index].chapterId!,));
                              print("======>${_chapterController.chapterList[index].chapterId}");
                            },
                            tileColor: AppColors.whiteColor,
                            leading: Container(
                              height: 40.rh,
                              width: 40.rh,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius:
                                BorderRadius.circular(20.rh),
                              ),
                              child: Center(
                                child: TextComponent(
                                    text: _chapterController.chapterList[index].number.toString(),
                                    textAlign: TextAlign.center,
                                    color: AppColors.whiteColor,
                                    fontSize: Constants.textFontSize,
                                    fontWeight:
                                    Constants.regularFontWeight,
                                    height: 1.0),
                              ),
                            ),
                            title: TextComponent(
                              text: _chapterController
                                  .searchList[index].title ?? '',
                              color: AppColors.TileTitleTextColor.withOpacity(0.7),
                              fontSize: Constants.textSmallFontSize,
                              fontWeight: Constants.titleFontWeight,
                              height: 0.0,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: TextComponent(
                                text: BanglaText.hadith_range_text + " : ${_chapterController.searchList[index].hadisRange ?? ''}",
                                color: AppColors.TileSubTitleTextColor,
                                fontSize: Constants.k12FontSize,
                                fontWeight: Constants.mediumFontWeight,
                                height: 0.10),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 8.rh,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}