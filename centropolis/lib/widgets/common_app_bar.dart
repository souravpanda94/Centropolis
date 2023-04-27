import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/constants.dart';
import '../utils/custom_colors.dart';

class CommonAppBar extends StatelessWidget {
  final String title;
  final bool isFilterVisible;
  final Function onBackBtnTap;
  final Function onFilterBtnTap;

  const CommonAppBar(
      this.title, this.isFilterVisible, this.onBackBtnTap, this.onFilterBtnTap,
      {Key? key})
      : super(key: key);

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
              title,
              style: const TextStyle(
                color: CustomColors.textColor8,
                fontFamily: 'SemiBold',
                fontSize: 16.0,
                // fontWeight: AppTranslations.of(context).currentLanguage == "ko" ? FontWeight.w800 : FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            leading: IconButton(
              icon: SvgPicture.asset(
                "assets/images/ic_back.svg",
                semanticsLabel: 'Back',
              ),
              onPressed: () {
                onBackBtnTap();
              },
            ),
            actions: isFilterVisible
                ? [
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/images/ic_filter.svg",
                        semanticsLabel: 'Back',
                      ),
                      onPressed: () {
                        onFilterBtnTap();
                      },
                    )
                  ]
                : null),
        // const Divider(
        //   color: CustomColors.borderColor,
        //   height: 2,
        // ),
      ],
    );
  }
}
