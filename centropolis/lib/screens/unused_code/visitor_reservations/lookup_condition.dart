import 'dart:convert';
import 'package:centropolis/utils/utils.dart';
import 'package:centropolis/widgets/common_button_with_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/custom_colors.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/common_button.dart';


class LookupConditionScreen extends StatefulWidget {
  const LookupConditionScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LookupConditionScreenState();
  }
}

class _LookupConditionScreenState extends State<LookupConditionScreen> {
  DateTime selectedDate = DateTime.now();
  String startDate = "";
  String endDate = "";
  List<dynamic> periodOfUseList = [
    {
      "id": 1,
      "title": tr("oneWeek"),
    },
    {
      "id": 2,
      "title": tr("oneMonth"),
    },
    {
      "id": 3,
      "title": tr("monthly"),
    },
    {
      "id": 4,
      "title": tr("directInput"),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.whiteColor,
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              color: CustomColors.whiteColor,
              child: CommonAppBar(tr("visitReservationViewAll"), true, () {
                onBackButtonPress(context);
              }, () {}),
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 20.0, bottom: 30.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  tr("reservationStatus"),
                  style: const TextStyle(
                    fontSize: 16,
                    color: CustomColors.textColor4,
                    fontFamily: 'Regular',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8.0, bottom: 30),
                child: TextField(
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: CustomColors.whiteColor,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 17.0,
                      horizontal: 15.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                          color: CustomColors.borderColor, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: CustomColors.borderColor, width: 1.0),
                    ),
                    hintText: "before approval",
                    hintStyle: const TextStyle(
                      color: CustomColors.textColorBlack2,
                      fontSize: 14,
                      fontFamily: 'Regular',
                    ),
                  ),
                  style: const TextStyle(
                    color: CustomColors.textColorBlack2,
                    fontSize: 14,
                    fontFamily: 'Regular',
                  ),
                  onChanged: (text) => {
                    // setState(() {
                    //   userPassword = text;
                    // }),
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  tr("periodOfUse"),
                  style: const TextStyle(
                    fontSize: 16,
                    color: CustomColors.textColor4,
                    fontFamily: 'Regular',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 8.0,
                ),
                // child: ListView.builder(
                //   physics: const AlwaysScrollableScrollPhysics(),
                //   shrinkWrap: true,
                //   // scrollDirection: Axis.horizontal,
                //   scrollDirection: Axis.vertical,
                //   itemCount: periodOfUseList.length,
                //   itemBuilder: (BuildContext ctxt, int index) {
                //     return InkWell(
                //         onTap: () {},
                //         child: Container(
                //           height: 50,
                //           width: 50,
                //           margin: const EdgeInsets.only(right: 8),
                //           decoration: BoxDecoration(
                //             color: CustomColors.whiteColor,
                //             borderRadius: BorderRadius.circular(5),
                //             border: Border.all(color: CustomColors.borderColor, width: 1.0),
                //           ),
                //           child: Align(
                //             alignment: Alignment.center,
                //             child: Text(
                //               periodOfUseList[index]['title'],
                //               style: const TextStyle(
                //                 fontSize: 16,
                //                 color: CustomColors.textColor4,
                //                 fontFamily: 'Regular',
                //               ),
                //               textAlign: TextAlign.center,
                //             ),
                //           ),
                //         )
                //     );
                //   },
                // ),
              ),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: CustomColors.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: CustomColors.borderColor, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(
                        top: 16.0, bottom: 16.0, left: 12.0, right: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            // "00/00/2022 - 00/00/2022",
                            startDate != "" && endDate != ""
                                ? "$startDate - $endDate"
                                : "Please select date",
                            style: const TextStyle(
                              fontSize: 14,
                              color: CustomColors.textColor4,
                              fontFamily: 'Regular',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/images/ic_calender.svg',
                          semanticsLabel: 'Back',
                          width: 15,
                          height: 15,
                          alignment: Alignment.center,
                        ),
                      ],
                    )),
              ),
              Expanded(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CommonButton(
                      buttonName: tr("lookup"),
                      isIconVisible: false,
                      buttonColor: CustomColors.buttonBackgroundColor,
                      onCommonButtonTap: () {},
                    )),
              ),
            ],
          ),
        ));
  }

  Future<void> _selectDate(BuildContext context) async {
    setState(() {
      startDate =
          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    });
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        // firstDate: DateTime(2015, 8),
        firstDate:
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        endDate =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }
}
