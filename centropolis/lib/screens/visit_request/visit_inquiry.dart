import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';

class VisitInquiryScreen extends StatefulWidget {
  const VisitInquiryScreen({super.key});

  @override
  State<VisitInquiryScreen> createState() => _VisitInquiryScreenState();
}

class _VisitInquiryScreenState extends State<VisitInquiryScreen> {
  String? currentSelectedSortingFilter;
  // For dropdown list attaching
  List<dynamic>? sortingList = [
    {"value": "", "text": "All"},
    {"value": "tenant_employee", "text": "Tenant Employee"},
    {"value": "tenant_lounge_employee", "text": "Executive Lounge"},
    {"value": "tenant_conference_employee", "text": "Conference Room"}
  ];
  List<dynamic> dataList = [
    {
      "id": 1,
      "name": "Hong Gil Dong",
      "businessType": "Centropolis",
      "type": "business discussion",
      "dateTime": "2021.03.21 13:00",
      "status": "Visit Completed"
    },
    {
      "id": 2,
      "name": "Hong Gil Dong",
      "businessType": "Centropolis",
      "type": "business discussion",
      "dateTime": "2021.03.21 13:00",
      "status": "Visit Completed"
    },
    {
      "id": 3,
      "name": "Hong Gil Dong",
      "businessType": "Centropolis",
      "type": "business discussion",
      "dateTime": "2021.03.21 13:00",
      "status": "Visit Completed"
    },
    {
      "id": 4,
      "name": "Hong Gil Dong",
      "businessType": "Centropolis",
      "type": "business discussion",
      "dateTime": "2021.03.21 13:00",
      "status": "Rejected"
    },
    {
      "id": 5,
      "name": "Hong Gil Dong",
      "businessType": "Centropolis",
      "type": "business discussion",
      "dateTime": "2021.03.21 13:00",
      "status": "Rejected"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 20.0,
                left: 16,
                right: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        tr("total"),
                        style: const TextStyle(
                          fontSize: 14,
                          color: CustomColors.textColorBlack2,
                          fontFamily: 'SemiBold',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        " ${dataList.length}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: CustomColors.textColor9,
                          fontFamily: 'SemiBold',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  sortingDropdownWidget()
                ],
              ),
            ),
            dataList.isNotEmpty
                ? Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: dataList.length,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          dataList[index]["name"],
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Bold",
                                              color: CustomColors.textColor8),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: dataList[index]["status"] ==
                                                    "Visit Completed"
                                                ? CustomColors.backgroundColor
                                                : CustomColors.backgroundColor4,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          padding: const EdgeInsets.only(
                                              top: 5,
                                              bottom: 5,
                                              left: 10,
                                              right: 10),
                                          child: Text(
                                            dataList[index]["status"],
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "Bold",
                                              color: dataList[index]
                                                          ["status"] ==
                                                      "Visit Completed"
                                                  ? CustomColors.textColor3
                                                  : CustomColors.headingColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(top: 6),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  dataList[index]
                                                      ["businessType"],
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
                                                  dataList[index]["type"],
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: "Regular",
                                                      color: CustomColors
                                                          .textColorBlack2),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Container(
                                        margin: const EdgeInsets.only(top: 6),
                                        child: Row(
                                          children: [
                                            Text(
                                              tr("visitDate"),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "Regular",
                                                  color:
                                                      CustomColors.textColor3),
                                            ),
                                            Text(
                                              dataList[index]["dateTime"],
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "Regular",
                                                  color:
                                                      CustomColors.textColor3),
                                            ),
                                          ],
                                        )),
                                  ],
                                )));
                      },
                    ))
                : Center(
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Text(
                        tr("noDataFound"),
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "Regular",
                            color: CustomColors.textColor5),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  sortingDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        alignment: AlignmentDirectional.centerEnd,
        hint: Text(
          tr('all'),
          style: const TextStyle(
            color: CustomColors.textColor5,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: sortingList
            ?.map(
              (item) => DropdownMenuItem<String>(
                value: item["value"],
                child: Text(
                  item["text"],
                  style: const TextStyle(
                    color: CustomColors.textColor5,
                    fontSize: 12,
                    fontFamily: 'SemiBold',
                  ),
                ),
              ),
            )
            .toList(),
        value: currentSelectedSortingFilter,
        onChanged: (value) {
          setState(() {
            currentSelectedSortingFilter = value as String;
          });

          //call API for sorting
          //loadEmployeeList();
        },
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          isOverButton: false,
          elevation: 0,
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              border: Border.all(color: CustomColors.borderColor, width: 1)),
        ),
        iconStyleData: IconStyleData(
            icon: Padding(
          padding: EdgeInsets.only(
              bottom: currentSelectedSortingFilter != null ? 6 : 0,
              top: currentSelectedSortingFilter != null ? 6 : 0,
              left: 0),
          child: SvgPicture.asset(
            "assets/images/ic_drop_down_arrow.svg",
            width: 8,
            height: 8,
            color: CustomColors.textColorBlack2,
          ),
        )),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
        ),
      ),
    );
  }
}
