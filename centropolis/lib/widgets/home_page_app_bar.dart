import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/constants.dart';
import '../utils/custom_colors.dart';

class HomePageAppBar extends StatefulWidget {
  final String title;
  final int selectedPage;
  final int unreadNotificationCount;
  final Function onSettingBtnTap;
  final Function onNotificationBtnTap;

  const HomePageAppBar(
      {super.key,
      required this.title,
      required this.selectedPage,
      required this.unreadNotificationCount,
      required this.onSettingBtnTap,
      required this.onNotificationBtnTap});

  @override
  State<StatefulWidget> createState() {
    return _HomePageAppBarState();
  }
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
            toolbarHeight: 54,
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            elevation: 0,
            backgroundColor: CustomColors.whiteColor,
            title: Text(
              widget.title,
              style: const TextStyle(
                color: CustomColors.textColor8,
                fontFamily: 'SemiBold',
                fontSize: 16.0,
                // fontWeight: AppTranslations.of(context).currentLanguage == "ko" ? FontWeight.w800 : FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            // leading: IconButton(
            //   icon: SvgPicture.asset(
            //     "assets/images/ic_scanner.svg",
            //     semanticsLabel: 'Back',
            //   ),
            //   onPressed: () {
            //     onScannerBtnTap();
            //   },
            // ),
            actions: [
              if (widget.selectedPage == 4)
                IconButton(
                  icon: SvgPicture.asset(
                    "assets/images/ic_setting.svg",
                    semanticsLabel: 'Back',
                  ),
                  onPressed: () {
                    widget.onSettingBtnTap();
                  },
                ),
              if (widget.selectedPage != 4)
                widget.unreadNotificationCount > 0
                    ? IconButton(
                        icon: SvgPicture.asset(
                          "assets/images/ic_notification_with_indicator.svg",
                          semanticsLabel: 'Back',
                        ),
                        onPressed: () {
                          widget.onNotificationBtnTap();
                        },
                      )
                    : IconButton(
                        icon: SvgPicture.asset(
                          "assets/images/ic_notification_black.svg",
                          semanticsLabel: 'Back',
                        ),
                        onPressed: () {
                          widget.onNotificationBtnTap();
                        },
                      )
            ]),
        // const Divider(
        //   color: CustomColors.borderColor,
        //   height: 2,
        // ),
      ],
    );
  }
}
