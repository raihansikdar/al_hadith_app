import 'package:al_hadith_app/data/controller/book_controller.dart';
import 'package:al_hadith_app/presentation/screens/chapter_screen.dart';
import 'package:al_hadith_app/presentation/utility/assets_path.dart';
import 'package:al_hadith_app/presentation/utility/custom_size_extention.dart';
import 'package:al_hadith_app/presentation/utility/style.dart';
import 'package:al_hadith_app/presentation/widgets/carousel_slider_widget.dart';
import 'package:al_hadith_app/presentation/widgets/text_component.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<BookController>().fetchBookListData();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor:  AppColors.primaryColor,
          elevation: 0,
          leading: SvgPicture.asset(AssetsPath.menuSVG,color: AppColors.whiteColor,),
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextComponent(
              text: 'Al Hadith',
              color: AppColors.whiteColor,
              fontSize: Constants.appbarTitleSize,
              fontWeight: Constants.titleFontWeight,
              height: 0.04,
            ),
          ),
          actions: [
            Padding(
              padding:  EdgeInsets.only(right: 16.rh),
              child: SvgPicture.asset(AssetsPath.searchSVG,color: AppColors.whiteColor,),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 400.rh,
                // decoration:  BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage(
                //       AssetsPath.islamicCalligraphyPNG,
                //     ),
                //     fit: BoxFit.cover,

                //   ),
                // ),

                child: Stack(
                  children: [
                    Container(
                      height: 350.rh,
                      width: double.infinity,
                      decoration:  BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            AssetsPath.mosquePNG,
                          ),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            AppColors.primaryColor.withOpacity(.2),
                            BlendMode.modulate,
                          ),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.rh),
                          bottomRight: Radius.circular(20.rh),
                        ),
                        color: AppColors.primaryColor,

                      ),
                      child: CarouselSliderWidget(),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 0,
                      left: 0,
                      child: SizedBox(
                          height: 100.rh,
                          // width: 415.rh,
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: 0.0,horizontal: 16.rh),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.rh),
                              ),
                              elevation: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  FadeInImage(
                                    placeholder: AssetImage(AssetsPath.clockPNG),
                                    image: AssetImage(AssetsPath.clockPNG),
                                  ),
                                  FadeInImage(
                                    placeholder: AssetImage(AssetsPath.goPNG),
                                    image: AssetImage(AssetsPath.goPNG),
                                  ),
                                  FadeInImage(
                                    placeholder: AssetImage(AssetsPath.appPNG),
                                    image: AssetImage(AssetsPath.appPNG),
                                  ),
                                  FadeInImage(
                                    placeholder: AssetImage(AssetsPath.heartPNG),
                                    image: AssetImage(AssetsPath.heartPNG),
                                  ),

                                ],
                              ),
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.all( 8.rh),
                child: TextComponent(text: "All Hadith Book",
                    color: AppColors.bookTitleTextColor,
                    fontSize: Constants.k15FontSize,
                    fontWeight: Constants.titleFontWeight,
                    height: 0.0),
              ),
              GetBuilder<BookController>(
                  builder: (_bookController) {
                    if(_bookController.isLoading){
                      return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: const Center(child: CircularProgressIndicator()));
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _bookController.bookList.length,
                      itemBuilder: (context,index){
                        return ListTile(
                          onTap: (){
                            Get.to(()=>ChapterScreen(bookId: _bookController.bookList[index].id ?? 0,));
                          },
                          tileColor: AppColors.whiteColor,
                          leading: Container(
                            width: 46.rh,
                            height: 46.rh,
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(16.rh)
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 46.rh,
                                    height: 46.rh,
                                    decoration: ShapeDecoration(
                                      color: _bookController.bookList[index].colorCode != null
                                          ? HexColor(_bookController.bookList[index].colorCode!)
                                          : Colors.transparent,
                                      shape: const StarBorder.polygon(
                                        sides: 6,
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: TextComponent(
                                    text: _bookController.bookList[index].abvrCode ?? '',
                                    color: AppColors.whiteColor,
                                    fontSize: Constants.titleFontSize,
                                    fontWeight: Constants.mediumFontWeight,
                                    height: 0.06,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          title: Row(
                            children: [
                              TextComponent(
                                text: _bookController.bookList[index].title ?? '',
                                color: AppColors.TileTitleTextColor,
                                fontSize: Constants.k14FontSize,
                                fontWeight: Constants.mediumFontWeight,
                                height: 0.10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              TextComponent(
                                text: _bookController.bookList[index].numberOfHadis.toString(),
                                color: AppColors.TileTitleTextColor,
                                fontSize: Constants.k14FontSize,
                                fontWeight: Constants.mediumFontWeight,
                                height: 0.10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              TextComponent(
                                text: _bookController.bookList[index].bookName ?? '',
                                color: AppColors.TileSubTitleTextColor,
                                fontSize: Constants.k12FontSize,
                                fontWeight: Constants.mediumFontWeight,
                                height: 0.10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              TextComponent(
                                text: _bookController.bookList[index].bookName ?? '',
                                color: AppColors.TileSubTitleTextColor,
                                fontSize: Constants.k12FontSize,
                                fontWeight: Constants.mediumFontWeight,
                                height: 0.10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context,index)=>SizedBox(height: 8.rh,), );
                  }
              ),
            ],
          ),
        )
    );
  }
}




