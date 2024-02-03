import 'dart:developer';

import 'package:al_hadith/data/controller/chapter_controller.dart';
import 'package:al_hadith/data/controller/hadith_controller.dart';
import 'package:al_hadith/presentation/utility/bangla_text.dart';
import 'package:al_hadith/presentation/utility/custom_size_extention.dart';
import 'package:al_hadith/presentation/utility/style.dart';
import 'package:al_hadith/presentation/widgets/hadith_alert_dialog.dart';
import 'package:al_hadith/presentation/widgets/text_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class HadithScreen extends StatefulWidget {
  final int chapterId;
  const HadithScreen({Key? key, required this.chapterId}) : super(key: key);

  @override
  State<HadithScreen> createState() => _HadithScreenState();
}

class _HadithScreenState extends State<HadithScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<HadithController>().fetchHadithListData(chapterId: widget.chapterId);
    });
    log("chapter id : ${widget.chapterId}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.primaryColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)),
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GetBuilder<ChapterController>(
                builder: (_chapterController) {
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
                        height: 16.rh,
                      ),
                      TextComponent(
                          text: _chapterController.chapterList.first.title ?? '',
                          color: AppColors.whiteColor,
                          fontSize: Constants.k12FontSize,
                          fontWeight: Constants.mediumFontWeight,
                          height: 0.10),
                    ],
                  );
                }
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.rh),
              topRight: Radius.circular(20.rh),
            ),
            color: AppColors.boxColor,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.rh),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<HadithController>(
                          builder: (_hadithController) {

                            if(_hadithController.isLoading){
                              return SizedBox(
                                  height: MediaQuery.of(context).size.height,  // center er jonno
                                  child: const Center(child: CircularProgressIndicator()));
                            } else if(_hadithController.hadithList.isEmpty){
                              return const Center(child: Text("no data found"));
                            }

                            return  Column(
                              children: [
                                Card(
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.rh)
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.all(16.rh),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          children: [
                                            Container(
                                              width: 46.rh,
                                              height: 46.rh,
                                              decoration: ShapeDecoration(
                                                color: _hadithController.hadithList.first.gradeColor!= null
                                                    ? HexColor(_hadithController.hadithList.first.gradeColor!)
                                                    : Colors.transparent,
                                                shape: const StarBorder.polygon(
                                                  sides: 6,
                                                ),
                                              ),
                                              child: Center(
                                                child: TextComponent(
                                                  text: 'B',
                                                  color: AppColors.whiteColor,
                                                  fontSize: Constants.titleFontSize,
                                                  fontWeight: Constants.mediumFontWeight,
                                                  height: 0.0,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10.rh,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextComponent(
                                                  text: _hadithController.hadithList.first.bookName ?? '',
                                                  color: AppColors.bookTitleTextColor.withOpacity(0.7),
                                                  fontSize: Constants.textSmallFontSize,
                                                  fontWeight: Constants.mediumFontWeight,
                                                  height: 0.0,
                                                ),
                                                TextComponent(
                                                  text: BanglaText.hadith_text + " : ${_hadithController.hadithList.first.hadithId.toString() ?? ''}",
                                                  color: AppColors.bookTitleTextColor,
                                                  fontSize: Constants.textSmallFontSize,
                                                  fontWeight: Constants.mediumFontWeight,
                                                  height: 0.0,
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              width: 110.rh,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                    backgroundColor: AppColors.primaryColor.withOpacity(0.6),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20.rh),
                                                    )
                                                ),
                                                onPressed: (){
                                                  showDialog(
                                                      context: context, builder: (context){
                                                    return HadithAlertDialog(text: _hadithController.hadithList.first.grade ?? '',);
                                                  });
                                                },
                                                child:  TextComponent(
                                                  text: _hadithController.hadithList.first.grade ?? '',
                                                  color: AppColors.whiteColor,
                                                  fontSize: Constants.textSmallFontSize,
                                                  fontWeight: Constants.mediumFontWeight,
                                                  height: 0.0,
                                                ),),
                                            ),

                                          ],
                                        ),
                                        SizedBox(height: 24.rh,),
                                        TextComponent(
                                          text: _hadithController.hadithList.first.ar ?? '',
                                          textAlign: TextAlign.end,
                                          color:
                                          AppColors.bookTitleTextColor.withOpacity(0.7),
                                          fontSize: Constants.textSmallFontSize,
                                          fontWeight: Constants.titleFontWeight,
                                          height: 0.0,
                                        ),
                                        SizedBox(height: 32.rh,),
                                        TextComponent(
                                          text: "${_hadithController.hadithList.first.narrator ?? ''} থেকে বর্ণিত : ",
                                          textAlign: TextAlign.start,
                                          color: AppColors.TileTitleTextColor,
                                          fontSize: Constants.textSmallFontSize,
                                          fontWeight: Constants.titleFontWeight,
                                          height: 0.0,
                                        ),
                                        SizedBox(height: 16.rh,),
                                        TextComponent(
                                          text: _hadithController.hadithList.first.bn ?? '',
                                          color: AppColors.TileSubTitleTextColor,
                                          fontSize: Constants.textSmallFontSize,
                                          fontWeight: Constants.mediumFontWeight,
                                          textAlign: TextAlign.justify,
                                          height: 0.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                            // return ListView.separated(
                            //   shrinkWrap: true,
                            //   primary: false,
                            //   itemCount: 2,
                            //   itemBuilder: (context,index){
                            //     Card(
                            //       elevation: 0.0,
                            //       child: Padding(
                            //         padding: EdgeInsets.all(16.rh),
                            //         child: Column(
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           children: [
                            //             TextComponent(
                            //               text: _hadithController.hadithList[index].ar ?? '',
                            //               color: AppColors.TileTitleTextColor.withOpacity(0.7),
                            //               fontSize: Constants.textSmallFontSize,
                            //               fontWeight: Constants.titleFontWeight,
                            //               height: 0.0,
                            //             ),
                            //             TextComponent(
                            //               text:_hadithController.hadithList[index].bn ?? '',
                            //               color: AppColors.TileTitleTextColor.withOpacity(0.7),
                            //               fontSize: Constants.textSmallFontSize,
                            //               fontWeight: Constants.titleFontWeight,
                            //               height: 0.0,
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     );
                            //   },
                            //   separatorBuilder: (context,index)=>SizedBox(height: 16.rh,),
                            // );
                          }
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }
}

