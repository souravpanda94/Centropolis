import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';
import '../utils/custom_colors.dart';

class AppBarForDialog extends StatelessWidget {
  final title;
  final Function onExitBtnTap;

  const AppBarForDialog(this.title, this.onExitBtnTap, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
          // backgroundColor: CustomColors.backgroundColor,
          title: Text(
            title,
            style: const TextStyle(
              color: CustomColors.blackColor,
              fontFamily: 'SemiBold',
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/images/ic_exit.svg",
                semanticsLabel: 'Back',
              ),
              onPressed: () {
                onExitBtnTap();
              },
            ),
          ]),
      const Divider(
        color: CustomColors.backgroundColor2,
        height: 2,
      ),
    ]);
  }
}
