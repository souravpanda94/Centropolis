import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/constants.dart';
import '../utils/custom_colors.dart';

class CommonButtonWithBorder extends StatefulWidget {
  final buttonName;
  final buttonColor;
  final buttonBorderColor;
  final buttonTextColor;
  final Function onCommonButtonTap;

  const CommonButtonWithBorder(
      {Key? key,
      this.buttonName,
      this.buttonColor,
      this.buttonBorderColor,
      this.buttonTextColor,
      required this.onCommonButtonTap})
      : super(key: key);

  @override
  _CommonButtonWithBorderState createState() => _CommonButtonWithBorderState();
}

class _CommonButtonWithBorderState extends State<CommonButtonWithBorder> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onCommonButtonTap();
      },
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: widget.buttonBorderColor, width: 1.0),
        ),
        padding: const EdgeInsets.only(left: 16,right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.buttonName,
              style: TextStyle(
                fontSize: 14,
                color: widget.buttonTextColor,
                fontFamily: 'SemiBold',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
