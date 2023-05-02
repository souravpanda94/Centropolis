import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';
import '../utils/custom_colors.dart';

class CommonModal extends StatefulWidget {
  final String heading;
  final String description;
  final String buttonName;
  final String firstButtonName;
  final String secondButtonName;

  final Function onConfirmBtnTap;
  final Function onFirstBtnTap;
  final Function onSecondBtnTap;

  const CommonModal({
    Key? key,
    required this.heading,
    required this.description,
    required this.buttonName,
    required this.firstButtonName,
    required this.secondButtonName,
    required this.onConfirmBtnTap,
    required this.onFirstBtnTap,
    required this.onSecondBtnTap,
  }) : super(key: key);

  @override
  _CommonModalState createState() => _CommonModalState();
}

class _CommonModalState extends State<CommonModal> {
  @override
  Widget build(BuildContext context) {
    AssetImage cancelImage = const AssetImage('assets/images/ic_cancel.png');
    double width = MediaQuery.of(context).size.width;

    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        insetPadding: const EdgeInsets.only(left: 18.0, right: 18.0),
        contentPadding: const EdgeInsets.only(
          top: 30,
        ),
        scrollable: true,
        content: SizedBox(
          width: width,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            SvgPicture.asset(
              'assets/images/ic_success.svg',
              semanticsLabel: 'Back',
              width: 40,
              height: 40,
              alignment: Alignment.center,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 16.0, right: 16.0),
              child: Text(
                widget.heading,
                style: const TextStyle(
                  color: CustomColors.textColor1,
                  fontSize: 20,
                  fontFamily: 'Bold',
                  // fontWeight: AppTranslations.of(context).currentLanguage == "ko" ? FontWeight.w800 : FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (widget.description != "")
              Container(
                margin:
                    const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                child: Text(
                  widget.description,
                  style: const TextStyle(
                    color: CustomColors.textColorBlack2,
                    fontSize: 15,
                    fontFamily: 'Regular',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: 1,
              color: CustomColors.borderColor,
            ),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.buttonName,
                  style: const TextStyle(
                    color: CustomColors.textColorBlack2,
                    fontSize: 16,
                    fontFamily: 'Regular',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ]),
        ));
  }
}
