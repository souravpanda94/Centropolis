import 'package:centropolis/models/paid_locker_history_detail_model.dart';
import 'package:centropolis/models/paid_pt_history_detail_model.dart';
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
  final String operationName;
  final PaidLockerHistoryDetailModel? paidLockerHistoryDetailModel;
  final PaidPtHistoryDetailModel? paidPtHistoryDetailModel;

  const FitnessReservation({
    super.key,
    required this.position,
    required this.operationName,
    this.paidLockerHistoryDetailModel,
    this.paidPtHistoryDetailModel,
  });

  @override
  State<FitnessReservation> createState() => _FitnessReservationState();
}

class _FitnessReservationState extends State<FitnessReservation> {
  List<String> fitnessTabList = [
    tr("fitnessReservationTab"),
    tr("gx"),
    tr("paidPT"),
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
      backgroundColor: CustomColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("fitnessReservationTitle"), false, () {
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
              height: 70,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: fitnessTabList.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        if (widget.operationName != "edit") {
                          setState(() {
                            showIndex = index;
                          });
                        }
                      },
                      child: Container(
                        height: 38,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                            color: index == showIndex
                                ? CustomColors.tabColor
                                : CustomColors.backgroundColor,
                            border: Border.all(
                                color: index == showIndex
                                    ? CustomColors.tabColor
                                    : CustomColors.borderColor,
                                width: index == showIndex ? 0 : 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Center(
                          child: Text(
                            fitnessTabList[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: index == showIndex
                                    ? CustomColors.whiteColor
                                    : CustomColors.textColor8),
                          ),
                        ),
                      ),
                    );
                  }))),
          Expanded(
            child: showIndex == 0
                ? const FitnessTabReservation()
                : showIndex == 1
                    ? const GXReservation()
                    : showIndex == 2
                        ? PaidPTReservation(
                            operationName: widget.operationName,
                            paidPtHistoryDetailModel:
                                widget.paidPtHistoryDetailModel)
                        : showIndex == 3
                            ? PaidLockerReservation(
                                operationName: widget.operationName,
                                paidLockerHistoryDetailModel:
                                    widget.paidLockerHistoryDetailModel,
                              )
                            : Container(),
          )
        ],
      ),
    );
  }
}
