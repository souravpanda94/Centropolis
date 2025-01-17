import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/constants.dart';
import '../utils/custom_colors.dart';

class CommonButton extends StatefulWidget {
  final buttonName;
  final isIconVisible;
  final buttonColor;
  final Function onCommonButtonTap;

  const CommonButton(
      {Key? key,
      this.buttonName,
      this.isIconVisible,
      this.buttonColor,
      required this.onCommonButtonTap})
      : super(key: key);

  @override
  _CommonButtonState createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onCommonButtonTap();
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                widget.buttonName,
                style: const TextStyle(
                  fontSize: 14,
                  color: CustomColors.whiteColor,
                  fontFamily: 'SemiBold',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            widget.isIconVisible
                ? Container(
                    margin: const EdgeInsets.only(left: 15.0),
                    child: SvgPicture.asset(
                      'assets/images/ic_right_arrow_white.svg',
                      semanticsLabel: 'Back',
                      color: CustomColors.whiteColor,
                      width: 11,
                      height: 11,
                      alignment: Alignment.center,
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
