import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/custom_colors.dart';
import '../../widgets/view_more.dart';
import 'lights_out_history_details.dart';

class LightsOutHistory extends StatefulWidget {
  const LightsOutHistory({super.key});

  @override
  State<LightsOutHistory> createState() => _LightsOutHistoryState();
}

class _LightsOutHistoryState extends State<LightsOutHistory> {
  List<dynamic> list = [
    {
      "title": "Centropolis",
      "status": "Received",
      "date": "2023.00.00 13:00",
      "floor": "11F"
    },
    {
      "title": "Centropolis",
      "status": "Received",
      "date": "2023.00.00 13:00",
      "floor": "11F"
    },
    {
      "title": "Centropolis",
      "status": "Received",
      "date": "2023.00.00 13:00",
      "floor": "11F"
    },
    {
      "title": "Centropolis",
      "status": "Received",
      "date": "2023.00.00 13:00",
      "floor": "11F"
    },
    {
      "title": "Centropolis",
      "status": "Received",
      "date": "2023.00.00 13:00",
      "floor": "11F"
    },
    {
      "title": "Centropolis",
      "status": "Received",
      "date": "2023.00.00 13:00",
      "floor": "11F"
    },
    {
      "title": "Centropolis",
      "status": "Received",
      "date": "2023.00.00 13:00",
      "floor": "11F"
    },
    {
      "title": "Centropolis",
      "status": "Approved",
      "date": "2023.00.00 13:00",
      "floor": "11F"
    },
    {
      "title": "Centropolis",
      "status": "Approved",
      "date": "2023.00.00 13:00",
      "floor": "11F"
    },
    {
      "title": "Centropolis",
      "status": "Approved",
      "date": "2023.00.00 13:00",
      "floor": "11F"
    },
    {
      "title": "Centropolis",
      "status": "Approved",
      "date": "2023.00.00 13:00",
      "floor": "11F"
    },
    {
      "title": "Centropolis",
      "status": "Approved",
      "date": "2023.00.00 13:00",
      "floor": "11F"
    },
    {
      "title": "Centropolis",
      "status": "Approved",
      "date": "2023.00.00 13:00",
      "floor": "11F"
    },
    {
      "title": "Centropolis",
      "status": "Approved",
      "date": "2023.00.00 13:00",
      "floor": "11F"
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
                        Text(
                          tr("items"),
                          style: const TextStyle(
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
                                builder: (context) => LightsOutHistoryDetails(
                                    type: list[index]["status"].toString()),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        list[index]["title"],
                                        style: const TextStyle(
                                            fontFamily: 'SemiBold',
                                            fontSize: 14,
                                            color: CustomColors.textColor8),
                                      ),
                                    ),
                                    if (list[index]["status"]
                                        .toString()
                                        .isNotEmpty)
                                      Container(
                                        decoration: BoxDecoration(
                                          color: list[index]["status"]
                                                      .toString() ==
                                                  "Received"
                                              ? CustomColors.backgroundColor3
                                              : list[index]["status"]
                                                          .toString() ==
                                                      "Approved"
                                                  ? CustomColors.backgroundColor
                                                  : list[index]["status"]
                                                              .toString() ==
                                                          "In Progress"
                                                      ? CustomColors.greyColor2
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
                                          list[index]["status"],
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "SemiBold",
                                            color: list[index]["status"]
                                                        .toString() ==
                                                    "Received"
                                                ? CustomColors.textColor9
                                                : list[index]["status"]
                                                            .toString() ==
                                                        "Answered"
                                                    ? CustomColors
                                                        .textColorBlack2
                                                    : list[index]["status"]
                                                                .toString() ==
                                                            "In Progress"
                                                        ? CustomColors
                                                            .brownColor
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
                                        list[index]["floor"],
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
                                        list[index]["date"],
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
