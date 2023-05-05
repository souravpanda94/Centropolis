import 'package:centropolis/utils/custom_colors.dart';
import 'package:centropolis/utils/utils.dart';
import 'package:centropolis/widgets/common_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AirIncLightList extends StatefulWidget {
  final String emptyTxt;

  final List<dynamic>? itemsList;
  const AirIncLightList({super.key, required this.emptyTxt, this.itemsList});

  @override
  State<AirIncLightList> createState() => _AirIncLightListState();
}

class _AirIncLightListState extends State<AirIncLightList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("otherReservationCard3"), false, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: widget.itemsList!.isNotEmpty
          ? Container(
              margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.itemsList?.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return InkWell(
                      onTap: () {},
                      child: Container(
                          margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          decoration: BoxDecoration(
                            color: CustomColors.whiteColor,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: CustomColors.borderColor, width: 1.0),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
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
                                  margin: const EdgeInsets.only(top: 15),
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
                                            color: CustomColors.textColor8),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: CustomColors.backgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                            left: 10,
                                            right: 10),
                                        child: Text(
                                          widget.itemsList![index]["status"],
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: "Bold",
                                              color: CustomColors.textColor9),
                                        ),
                                      )
                                    ],
                                  )),
                              Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.itemsList![index]["type"],
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Regular",
                                            color:
                                                CustomColors.textColorBlack2),
                                      ),
                                      const Text(
                                        "  |  ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Regular",
                                            color: CustomColors.borderColor),
                                      ),
                                      Text(
                                        widget.itemsList![index]["dateTime"],
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Regular",
                                            color: CustomColors.textColor3),
                                      ),
                                    ],
                                  )),
                            ],
                          )));
                },
              ))
          : Container(
              color: CustomColors.backgroundColor,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
    );
  }
}
