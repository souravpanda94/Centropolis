import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/constants.dart';
import '../utils/custom_colors.dart';

class CommonButton extends StatefulWidget {
  final buttonName;
  final isEnable;
  final buttonColor;
  final Function onCommonButtonTap;

  const CommonButton(
      {Key? key,
        this.buttonName,
        this.isEnable,
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
      child: Container(
        height: 47,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.buttonName,
              style: const TextStyle(
                fontSize: 15,
                color: CustomColors.whiteColor,
                fontFamily: 'SemiBold',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: 15,),
            SizedBox(
              child: SvgPicture.asset(
                'assets/images/ic_right_arrow_white.svg',
                semanticsLabel: 'Back',
                width: 10,
                height: 10,
                alignment: Alignment.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
