import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/custom_colors.dart';
import '../../widgets/view_more.dart';
import 'conference_history_details.dart';

class ConferenceHistory extends StatefulWidget {
  const ConferenceHistory({super.key});

  @override
  State<ConferenceHistory> createState() => _ConferenceHistoryState();
}

class _ConferenceHistoryState extends State<ConferenceHistory> {
  List<dynamic> list = [
    {
      "name": "Hong Gil Dong",
      "type": "Before Approval",
      "date": "2023.00.00",
      "participants": "12"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Before Approval",
      "date": "2023.00.00",
      "participants": "5"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Before Approval",
      "date": "2023.00.00",
      "participants": "9"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Approved",
      "date": "2023.00.00",
      "participants": "12"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Used",
      "date": "2023.00.00",
      "participants": "10"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Approved",
      "date": "2023.00.00",
      "participants": "8"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Rejected",
      "date": "2023.00.00",
      "participants": "8"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Used",
      "date": "2023.00.00",
      "participants": "9"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Used",
      "date": "2023.00.00",
      "participants": "5"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Used",
      "date": "2023.00.00",
      "participants": "7"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Used",
      "date": "2023.00.00",
      "participants": "4"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Rejected",
      "date": "2023.00.00",
      "participants": "12"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Approved",
      "date": "2023.00.00",
      "participants": "6"
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
            padding: const EdgeInsets.only(left: 16, right: 16, top: 33),
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
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          child: Text(
                            "38",
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColor9),
                          ),
                        ),
                        const Text(
                          "명",
                          style: TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          tr("all"),
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColor5),
                        ),
                        const SizedBox(
                          width: 11,
                        ),
                        SvgPicture.asset("assets/images/ic_drop_down_arrow.svg",
                            color: CustomColors.textColor5)
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 9,
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
                                builder: (context) => ConferenceHistoryDetails(
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
                                    Text(
                                      list[index]["name"],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: 'SemiBold',
                                          fontSize: 14,
                                          color: CustomColors.textColor8),
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
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Text(
                                        list[index]["date"],
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
                                      const VerticalDivider(
                                        thickness: 1,
                                        color: CustomColors.borderColor,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        tr("participants"),
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
                                      Text(
                                        list[index]["participants"],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: 'Regular',
                                            fontSize: 12,
                                            color: CustomColors.textColor3),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })),
                ),
                const ViewMoreWidget(),
              ],
            ),
          );
  }
}
