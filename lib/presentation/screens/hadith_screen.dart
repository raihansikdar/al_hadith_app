import 'dart:developer';

import 'package:al_hadith_app/data/controller/chapter_controller.dart';
import 'package:al_hadith_app/data/controller/hadith_controller.dart';
import 'package:al_hadith_app/presentation/utility/assets_path.dart';
import 'package:al_hadith_app/presentation/utility/bangla_text.dart';
import 'package:al_hadith_app/presentation/utility/custom_size_extention.dart';
import 'package:al_hadith_app/presentation/utility/style.dart';
import 'package:al_hadith_app/presentation/widgets/hadith_alert_dialog.dart';
import 'package:al_hadith_app/presentation/widgets/text_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              child: const Icon(Icons.arrow_back_ios,color: AppColors.whiteColor,)),
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
                                                  text: BanglaText.hadith_text + " : ${_hadithController.hadithList.first.hadithId.toString() ?? ''}",
                                                  color: AppColors.bookTitleTextColor,
                                                  fontSize: Constants.textSmallFontSize,
                                                  fontWeight: Constants.mediumFontWeight,
                                                  height: 0.0,
                                                ),
                                                TextComponent(
                                                  text: _hadithController.hadithList.first.bookName ?? '',
                                                  color: AppColors.bookTitleTextColor.withOpacity(0.7),
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
                                           GestureDetector(
                                               onTap: (){
                                                 showModalBottomSheet(context: context, builder: (context){
                                                   return Container(
                                                     height: 400,
                                                     width: double.infinity,
                                                     child: Padding(
                                                       padding: const EdgeInsets.all(16.0),
                                                       child: Column(
                                                         children: [
                                                           Row(
                                                             children: [
                                                               TextComponent(
                                                                 text: 'More Option',
                                                                 color: AppColors.bookTitleTextColor,
                                                                 fontSize: Constants.titleFontSize,
                                                                 fontWeight: Constants.titleFontWeight,
                                                                 height: 0.0,
                                                               ),
                                                               const Spacer(),
                                                               GestureDetector(
                                                                   onTap: (){
                                                                     Navigator.pop(context);
                                                                   },
                                                                   child: const Icon(Icons.close))
                                                             ],
                                                           ),
                                                           SizedBox(height: 16.rh,),
                                                           Row(
                                                             children: [
                                                               SvgPicture.asset(AssetsPath.goToMainSVG,width: 23.rh,),
                                                               SizedBox(width: 8.rw,),
                                                               TextComponent(
                                                                 text: 'Go To Main Hadith',
                                                                 color: AppColors.TileTitleTextColor,
                                                                 fontSize: Constants.textSmallFontSize,
                                                                 fontWeight: Constants.mediumFontWeight,
                                                                 height: 0.0,
                                                               ),
                                                             ],
                                                           ),
                                                           SizedBox(height: 16.rh,),
                                                           Row(
                                                             children: [
                                                               SvgPicture.asset(AssetsPath.collectionSVG,width: 20.rh,),
                                                               SizedBox(width: 8.rw,),
                                                               TextComponent(
                                                                 text: 'Add to Collection',
                                                                 color: AppColors.TileTitleTextColor,
                                                                 fontSize: Constants.textSmallFontSize,
                                                                 fontWeight: Constants.mediumFontWeight,
                                                                 height: 0.0,
                                                               ),
                                                             ],
                                                           ),
                                                           SizedBox(height: 16.rh,),
                                                           Row(
                                                             children: [
                                                               SvgPicture.asset(AssetsPath.copySVG,width: 20.rh),
                                                               SizedBox(width: 8.rw,),
                                                               TextComponent(
                                                                 text: 'Bangla Copy',
                                                                 color: AppColors.TileTitleTextColor,
                                                                 fontSize: Constants.textSmallFontSize,
                                                                 fontWeight: Constants.mediumFontWeight,
                                                                 height: 0.0,
                                                               ),
                                                             ],
                                                           ),
                                                           SizedBox(height: 16.rh,),
                                                           Row(
                                                             children: [
                                                               SvgPicture.asset(AssetsPath.copySVG,width: 20.rh),
                                                               SizedBox(width: 8.rw,),
                                                               TextComponent(
                                                                 text: 'English Copy',
                                                                 color: AppColors.TileTitleTextColor,
                                                                 fontSize: Constants.textSmallFontSize,
                                                                 fontWeight: Constants.mediumFontWeight,
                                                                 height: 0.0,
                                                               ),
                                                             ],
                                                           ),
                                                           SizedBox(height: 16.rh,),
                                                           Row(
                                                             children: [
                                                               SvgPicture.asset(AssetsPath.copySVG,width: 20.rh),
                                                               SizedBox(width: 8.rw,),
                                                               TextComponent(
                                                                 text: 'Arabic Copy',
                                                                 color: AppColors.TileTitleTextColor,
                                                                 fontSize: Constants.textSmallFontSize,
                                                                 fontWeight: Constants.mediumFontWeight,
                                                                 height: 0.0,
                                                               ),
                                                             ],
                                                           ),
                                                           SizedBox(height: 16.rh,),
                                                           Row(
                                                             children: [
                                                               SvgPicture.asset(AssetsPath.addSVG,width: 20.rh),
                                                               SizedBox(width: 8.rw,),
                                                               TextComponent(
                                                                 text: 'Add Hifz',
                                                                 color: AppColors.TileTitleTextColor,
                                                                 fontSize: Constants.textSmallFontSize,
                                                                 fontWeight: Constants.mediumFontWeight,
                                                                 height: 0.0,
                                                               ),
                                                             ],
                                                           ),
                                                           SizedBox(height: 16.rh,),
                                                           Row(
                                                             children: [
                                                               SvgPicture.asset(AssetsPath.addSVG,width: 20.rh),
                                                               SizedBox(width: 8.rw,),
                                                               TextComponent(
                                                                 text: 'Add Note',
                                                                 color: AppColors.TileTitleTextColor,
                                                                 fontSize: Constants.textSmallFontSize,
                                                                 fontWeight: Constants.mediumFontWeight,
                                                                 height: 0.0,
                                                               ),
                                                             ],
                                                           ),
                                                           SizedBox(height: 16.rh,),
                                                           Row(
                                                             children: [
                                                               SvgPicture.asset(AssetsPath.shareSVG,width: 20.rh),
                                                               SizedBox(width: 8.rw,),
                                                               TextComponent(
                                                                 text: 'Share',
                                                                 color: AppColors.TileTitleTextColor,
                                                                 fontSize: Constants.textSmallFontSize,
                                                                 fontWeight: Constants.mediumFontWeight,
                                                                 height: 0.0,
                                                               ),
                                                             ],
                                                           ),
                                                           SizedBox(height: 16.rh,),
                                                           Row(
                                                             children: [
                                                               SvgPicture.asset(AssetsPath.reportSVG,width: 20.rh),
                                                               SizedBox(width: 8.rw,),
                                                               TextComponent(
                                                                 text: 'Report',
                                                                 color: AppColors.TileTitleTextColor,
                                                                 fontSize: Constants.textSmallFontSize,
                                                                 fontWeight: Constants.mediumFontWeight,
                                                                 height: 0.0,
                                                               ),
                                                             ],
                                                           ),
                                                         ],
                                                       ),
                                                     ),
                                                   );
                                                 });
                                               },
                                               child: Icon(Icons.more_vert,size: 40.rSp,),
                                           )
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

