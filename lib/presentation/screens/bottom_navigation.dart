import 'package:al_hadith_app/presentation/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<BottomNavigationScreen> {
  int _currentIndex =0;
  final _pages = [
    const HomePage(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft:Radius.circular(20),
            )
        ),

        height: 56,
        child: BottomNavigationBar(
          backgroundColor: Colors.amber,
          elevation: 4,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: SvgPicture.asset(AssetsPath.homeSVG),
            ),

            BottomNavigationBarItem(
              label: '',
              icon: SvgPicture.asset(AssetsPath.bookSVG),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: SvgPicture.asset(AssetsPath.listSVG),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: SvgPicture.asset(AssetsPath.saveSVG),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: SvgPicture.asset(AssetsPath.profileSVG),
            ),
          ],
        ),
      ),
    );
  }
}