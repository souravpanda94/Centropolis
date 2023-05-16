import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import 'fitness_tab_reservation.dart';
import 'gx_reservation.dart';
import 'paidPT_reservation.dart';
import 'paid_locker_reservation.dart';

class FitnessReservation extends StatefulWidget {
  final int position;
  const FitnessReservation({super.key, required this.position});

  @override
  State<FitnessReservation> createState() => _FitnessReservationState();
}

class _FitnessReservationState extends State<FitnessReservation> {
  List<String> fitnessTabList = [
    tr("gx"),
    tr("paidPT"),
    tr("fitness"),
    tr("paidLockers")
  ];
  int showIndex = 0;

  @override
  void initState() {
    showIndex = widget.position;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("fitnessReservation"), false, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: Column(
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
                            color: index == showIndex
                                ? CustomColors.tabColor
                                : CustomColors.backgroundColor,
                            border: Border.all(
                              color: CustomColors.borderColor,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Text(
                          fitnessTabList[index],
                          style: TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: index == showIndex
                                  ? CustomColors.whiteColor
                                  : CustomColors.textColor8),
                        ),
                      ),
                    );
                  }))),
          Expanded(
            child: showIndex == 0
                ? const GXReservation()
                : showIndex == 1
                    ? const PaidPTReservation()
                    : showIndex == 2
                        ? const FitnessTabReservation()
                        : showIndex == 3
                            ? const PaidLockerReservation()
                            : Container(),
          )
        ],
      ),
    );
  }
}
