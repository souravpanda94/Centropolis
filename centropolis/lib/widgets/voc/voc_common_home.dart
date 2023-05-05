import 'package:centropolis/utils/custom_colors.dart';
import 'package:centropolis/widgets/common_button_with_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VocCommonHome extends StatefulWidget {
  final String image, title, subTitle, emptyTxt, buttonName;
  final Function onPressed;
  final Function onDrawerClick;
  final List<dynamic>? itemsList;
  const VocCommonHome(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.emptyTxt,
      required this.buttonName,
      required this.onDrawerClick,
      required this.onPressed,
      this.itemsList});

  @override
  State<VocCommonHome> createState() => _VocCommonHomeState();
}

class _VocCommonHomeState extends State<VocCommonHome> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //onPressed.call();
      },
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Image.asset(
                widget.image,
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
                height: 320,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 15),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      fontFamily: 'Regular',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.textColor9),
                ),
              ),
              Container(
                //height: 62,
                margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          widget.subTitle,
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: CustomColors.textColorBlack2),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        widget.onDrawerClick();
                      },
                      child: SizedBox(
                        child: SvgPicture.asset(
                          'assets/images/ic_drawer.svg',
                          semanticsLabel: 'Back',
                          width: 25,
                          height: 25,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              widget.itemsList!.isNotEmpty
                  ? Container(
                      margin:
                          const EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.itemsList?.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return InkWell(
                              onTap: () {},
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 5.0, bottom: 5.0),
                                  decoration: BoxDecoration(
                                    color: CustomColors.whiteColor,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: CustomColors.borderColor,
                                        width: 1.0),
                                  ),
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(right: 5),
                                            height: 7,
                                            width: 7,
                                            decoration: const BoxDecoration(
                                                color: CustomColors.textColor9,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                          ),
                                          Text(
                                            widget.itemsList![index]["name"],
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: "Bold",
                                                color: CustomColors.textColor8),
                                          ),
                                        ],
                                      ),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(top: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                widget.itemsList![index]
                                                    ["businessType"],
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Regular",
                                                    color: CustomColors
                                                        .textColor8),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: CustomColors
                                                      .backgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                padding: const EdgeInsets.only(
                                                    top: 5,
                                                    bottom: 5,
                                                    left: 10,
                                                    right: 10),
                                                child: Text(
                                                  widget.itemsList![index]
                                                      ["status"],
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "Bold",
                                                      color: CustomColors
                                                          .textColor9),
                                                ),
                                              )
                                            ],
                                          )),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                widget.itemsList![index]
                                                    ["type"],
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: "Regular",
                                                    color: CustomColors
                                                        .textColorBlack2),
                                              ),
                                              const Text(
                                                "  |  ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: "Regular",
                                                    color: CustomColors
                                                        .borderColor),
                                              ),
                                              Text(
                                                widget.itemsList![index]
                                                    ["dateTime"],
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: "Regular",
                                                    color: CustomColors
                                                        .textColor3),
                                              ),
                                            ],
                                          )),
                                    ],
                                  )));
                        },
                      ))
                  : Container(
                      color: CustomColors.backgroundColor,
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 40, bottom: 40),
                      child: Text(
                        widget.emptyTxt,
                        style: const TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: CustomColors.textColor5),
                      ),
                    ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(
                    left: 18, right: 18, top: 40, bottom: 30),
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CommonButtonWithIcon(
                      buttonName: widget.buttonName,
                      isEnable: true,
                      buttonColor: CustomColors.buttonBackgroundColor,
                      onCommonButtonTap: () {
                        widget.onPressed();
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
