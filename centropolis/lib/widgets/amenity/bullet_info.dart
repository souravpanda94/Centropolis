import 'package:flutter/material.dart';

import '../../utils/custom_colors.dart';

class BulletInfo extends StatelessWidget {
  final String info;
  final bool bulletVisibility;
  const BulletInfo(
      {super.key, required this.info, required this.bulletVisibility});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Visibility(
            visible: bulletVisibility,
            child: const Padding(
              padding: EdgeInsets.only(right: 5, top: 5),
              child: Icon(
                Icons.circle,
                color: CustomColors.textGreyColor,
                size: 5,
              ),
            ),
          ),
          Expanded(
            child: Text(
              info,
              style: const TextStyle(
                  color: CustomColors.textGreyColor,
                  fontFamily: 'Regular',
                  fontSize: 11,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
