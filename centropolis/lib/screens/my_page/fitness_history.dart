import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/custom_colors.dart';
import '../../widgets/view_more.dart';
import 'fitness_tab_reservation_history.dart';
import 'gx_reservation_history.dart';
import 'paid_locker_reservation_history.dart';
import 'paid_pt_reservation_history.dart';

class FitnessHistory extends StatefulWidget {
  const FitnessHistory({super.key});

  @override
  State<FitnessHistory> createState() => _FitnessHistoryState();
}

class _FitnessHistoryState extends State<FitnessHistory> {
  List<String> fitnessTabList = [
    tr("gx"),
    tr("paidPT"),
    tr("fitness"),
    tr("paidLockers")
  ];
  int showIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            color: CustomColors.whiteColor,
            height: 77,
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: fitnessTabList.length,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        showIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                          color: CustomColors.whiteColor,
                          border: Border.all(
                            color: index == showIndex
                                ? CustomColors.textColorBlack2
                                : CustomColors.whiteColor,
                          ),
                          borderRadius: index == showIndex
                              ? const BorderRadius.all(Radius.circular(50))
                              : null),
                      child: Text(
                        fitnessTabList[index],
                        style: TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: index == showIndex
                                ? CustomColors.textColorBlack2
                                : CustomColors.textColor3),
                      ),
                    ),
                  );
                }))),
        Expanded(
          child: showIndex == 0
              ? const GXReservationHistory()
              : showIndex == 1
                  ? const PaidPTReservationHistory()
                  : showIndex == 2
                      ? const FitnessTabReservationHistory()
                      : showIndex == 3
                          ? const PaidLockerReservationHistory()
                          : Container(),
        )
      ],
    );
  }
}
