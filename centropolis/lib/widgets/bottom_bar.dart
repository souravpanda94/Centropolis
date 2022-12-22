import 'package:centropolis/utils/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/amenity.dart';
import '../screens/home.dart';
import '../screens/my_page.dart';
import '../screens/visitor_reservations/visitor_reservations.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<StatefulWidget> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedPageIndex = 0;
  final bottomBarPages = [
    const HomeScreen(),
    const AmenityScreen(),
    const VisitorReservationsScreen(),
    const MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.whiteColor,
        body: bottomBarPages[selectedPageIndex],
        bottomNavigationBar: SizedBox(
          height: 84,
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  label: tr('home'),
                  icon: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SvgPicture.asset(
                      'assets/images/ic_home.svg',
                      color: selectedPageIndex == 0
                          ? CustomColors.selectedColor
                          : CustomColors.unSelectedColor,
                    ),
                  )),
              BottomNavigationBarItem(
                label: tr('amenity'),
                icon: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SvgPicture.asset(
                    'assets/images/ic_amenity.svg',
                    color: selectedPageIndex == 1
                        ? CustomColors.selectedColor
                        : CustomColors.unSelectedColor,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: tr('visitor'),
                icon: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SvgPicture.asset(
                    'assets/images/ic_visitor.svg',
                    color: selectedPageIndex == 2
                        ? CustomColors.selectedColor
                        : CustomColors.unSelectedColor,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: tr('myPage'),
                icon: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SvgPicture.asset(
                    'assets/images/ic_my_page.svg',
                    color: selectedPageIndex == 3
                        ? CustomColors.selectedColor
                        : CustomColors.unSelectedColor,
                  ),
                ),
              ),
            ],
            currentIndex: selectedPageIndex,
            backgroundColor: CustomColors.whiteColor,
            selectedItemColor: CustomColors.selectedColor,
            unselectedItemColor: CustomColors.unSelectedColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                selectedPageIndex = index;
              });
            },
          ),
        ));
  }
}
