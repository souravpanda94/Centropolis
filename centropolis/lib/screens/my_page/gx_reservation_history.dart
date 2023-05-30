import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/custom_colors.dart';
import '../../widgets/view_more.dart';
import 'gx_history_details.dart';

class GXReservationHistory extends StatefulWidget {
  const GXReservationHistory({super.key});

  @override
  State<GXReservationHistory> createState() => _GXReservationHistoryState();
}

class _GXReservationHistoryState extends State<GXReservationHistory> {
  String? currentSelectedSortingFilter;
  // For dropdown list attaching
  List<dynamic>? sortingList = [
    {"value": "", "text": "All"},
    {"value": "tenant_employee", "text": "Tenant Employee"},
    {"value": "tenant_lounge_employee", "text": "Executive Lounge"},
    {"value": "tenant_conference_employee", "text": "Conference Room"}
  ];
  List<dynamic> list = [
    {
      "title": "YOGA CLASS",
      "type": "Before Approval",
      "startDate": "2023.00.00",
      "endDate": "2023-00-00"
    },
    {
      "title": "YOGA CLASS",
      "type": "Approved",
      "startDate": "2023.00.00",
      "endDate": "2023-00-00"
    },
    {
      "title": "YOGA CLASS",
      "type": "Before Approval",
      "startDate": "2023.00.00",
      "endDate": "2023-00-00"
    },
    {
      "title": "CORE TRAINING & STRETCHING",
      "type": "Before Approval",
      "startDate": "2023.00.00",
      "endDate": "2023-00-00"
    },
    {
      "title": "JUST 10 MINUTES",
      "type": "Approved",
      "startDate": "2023.00.00",
      "endDate": "2023-00-00"
    },
    {
      "title": "CORE TRAINING & STRETCHING",
      "type": "Approved",
      "startDate": "2023.00.00",
      "endDate": "2023-00-00"
    },
    {
      "title": "YOGA CLASS",
      "type": "Rejected",
      "startDate": "2023.00.00",
      "endDate": "2023-00-00"
    },
    {
      "title": "JUST 10 MINUTES",
      "type": "Used",
      "startDate": "2023.00.00",
      "endDate": "2023-00-00"
    },
    {
      "title": "CORE TRAINING & STRETCHING",
      "type": "Rejected",
      "startDate": "2023.00.00",
      "endDate": "2023-00-00"
    },
    {
      "title": "YOGA CLASS",
      "type": "Before Approval",
      "startDate": "2023.00.00",
      "endDate": "2023-00-00"
    },
    {
      "title": "CORE TRAINING & STRETCHING",
      "type": "Used",
      "startDate": "2023.00.00",
      "endDate": "2023-00-00"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            padding: const EdgeInsets.all(24),
            child: Text(
              tr("noReservationHistory"),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'Regular',
                  fontSize: 14,
                  color: CustomColors.textColor5),
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          tr("total"),
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Text(
                            list.length.toString(),
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColor9),
                          ),
                        ),
                        Text(
                          tr("items"),
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                      ],
                    ),
                    sortingDropdownWidget()
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GXHistoryDetails(
                                    type: list[index]["type"].toString()),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: CustomColors.whiteColor,
                                border: Border.all(
                                  color: CustomColors.borderColor,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4))),
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        list[index]["title"],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: 'SemiBold',
                                            fontSize: 14,
                                            color: CustomColors.textColor8),
                                      ),
                                    ),
                                    if (list[index]["type"]
                                        .toString()
                                        .isNotEmpty)
                                      Container(
                                        decoration: BoxDecoration(
                                          color: list[index]["type"]
                                                      .toString() ==
                                                  "Before Approval"
                                              ? CustomColors.backgroundColor3
                                              : list[index]["type"]
                                                          .toString() ==
                                                      "Approved"
                                                  ? CustomColors.backgroundColor
                                                  : list[index]["type"]
                                                              .toString() ==
                                                          "Used"
                                                      ? CustomColors
                                                          .backgroundColor
                                                      : list[index]["type"]
                                                                  .toString() ==
                                                              "Rejected"
                                                          ? CustomColors
                                                              .redColor
                                                          : CustomColors
                                                              .textColorBlack2,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 5.0,
                                            bottom: 5.0,
                                            left: 10.0,
                                            right: 10.0),
                                        child: Text(
                                          list[index]["type"],
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "SemiBold",
                                            color: list[index]["type"]
                                                        .toString() ==
                                                    "Before Approval"
                                                ? CustomColors.textColor9
                                                : list[index]["type"]
                                                            .toString() ==
                                                        "Approved"
                                                    ? CustomColors
                                                        .textColorBlack2
                                                    : list[index]["type"]
                                                                .toString() ==
                                                            "Used"
                                                        ? CustomColors
                                                            .textColor3
                                                        : list[index]
                                                                        ["type"]
                                                                    .toString() ==
                                                                "Rejected"
                                                            ? CustomColors
                                                                .headingColor
                                                            : CustomColors
                                                                .textColorBlack2,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      list[index]["startDate"],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: 'Regular',
                                          fontSize: 12,
                                          color: CustomColors.textColor3),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text(
                                      "~",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: 'Regular',
                                          fontSize: 12,
                                          color: CustomColors.textColor3),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      list[index]["endDate"],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: 'Regular',
                                          fontSize: 12,
                                          color: CustomColors.textColor3),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      })),
                ),
                ViewMoreWidget(
                  onViewMoreTap: () {},
                ),
              ],
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
