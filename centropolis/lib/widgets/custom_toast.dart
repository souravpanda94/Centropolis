import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/constants.dart';
import '../utils/custom_colors.dart';

class CustomToast extends StatelessWidget {
  final String message;
  final String icon;

  const CustomToast(this.message, this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 13.0),
      margin: const EdgeInsets.only(left: 15.0,right: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: CustomColors.whiteColor,
        border: Border.all(
          color: CustomColors.blackColor,
          style: BorderStyle.solid,
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != "")
            SvgPicture.asset(
              "assets/images/ic_check_red.svg",
              semanticsLabel: 'Back',
            ),
          if (icon != "")
            const SizedBox(
              width: 13.0,
            ),
          Flexible(
            flex: 1,
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                color: CustomColors.blackColor,
                fontFamily: 'SemiBold',
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
