import 'dart:developer';
import 'package:flutter/material.dart';

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
          borderRadius: BorderRadius.circular(4),
        ),
        insetPadding: const EdgeInsets.only(left: 18.0, right: 18.0),
        contentPadding: const EdgeInsets.only(
            top: 30, bottom: 30.0, left: 30.0, right: 30.0),
        scrollable: true,
        content: SizedBox(
          width: width,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            SizedBox(
              child: Text(
                widget.heading,
                style: const TextStyle(
                  color: CustomColors.textColor8,
                  fontSize: 16,
                  fontFamily: 'SemiBold',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (widget.description != "")
              Container(
                margin: const EdgeInsets.only(top: 15.0),
                child: Text(
                  widget.description,
                  style: const TextStyle(
                    color: CustomColors.textColor5,
                    fontSize: 14,
                    height: 1.5,
                    fontFamily: 'Regular',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            if (widget.buttonName != "")
              Container(
                  margin: const EdgeInsets.only(top: 30.0, bottom: 2),
                  height: 46,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        // padding: const EdgeInsets.only(left: 45.0, right: 45.0),
                        primary: CustomColors.buttonBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        shadowColor: Colors.transparent),
                    child: Text(
                      widget.buttonName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: CustomColors.whiteColor,
                        fontFamily: 'Bold',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      widget.onConfirmBtnTap();
                    },
                  )),
            if (widget.firstButtonName != "" && widget.secondButtonName != "")
              Container(
                  margin: const EdgeInsets.only(top: 30.0, bottom: 2),
                  width: double.infinity,
                  height: 46,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: CustomColors.whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                  color: CustomColors.buttonBackgroundColor),
                            ),
                            shadowColor: Colors.transparent,
                          ),
                          child: Text(
                            widget.firstButtonName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: CustomColors.buttonBackgroundColor,
                              fontFamily: 'Bold',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            widget.onFirstBtnTap();
                          },
                        ),
                      )),
                      const SizedBox(
                        width: 14.0,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 46,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: CustomColors.buttonBackgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              shadowColor: Colors.transparent,
                            ),
                            child: Text(
                              widget.secondButtonName,
                              style: const TextStyle(
                                fontSize: 14,
                                color: CustomColors.whiteColor,
                                fontFamily: 'Bold',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              widget.onSecondBtnTap();
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
          ]),
        ));
  }
}
