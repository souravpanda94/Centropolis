import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/custom_colors.dart';

class ViewMoreWidget extends StatefulWidget {
  const ViewMoreWidget({super.key});

  @override
  State<ViewMoreWidget> createState() => _ViewMoreWidgetState();
}

class _ViewMoreWidgetState extends State<ViewMoreWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tr("viewMore"),
            style: const TextStyle(
                fontFamily: 'Regular',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: CustomColors.textColorBlack2),
          ),
          const SizedBox(
            width: 7,
          ),
          SvgPicture.asset(
            "assets/images/ic_drop_down_arrow.svg",
            width: 10,
            height: 7,
            color: CustomColors.textColorBlack2,
          ),
        ],
      ),
    );
  }
}
