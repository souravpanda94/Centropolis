import 'package:centropolis/widgets/common_button_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';

class FacilityHistoryDetails extends StatefulWidget {
  final String type;
  const FacilityHistoryDetails({super.key, required this.type});

  @override
  State<FacilityHistoryDetails> createState() => _FacilityHistoryDetails();
}

class _FacilityHistoryDetails extends State<FacilityHistoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("sleepingRoomReservation"), false, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: CustomColors.whiteColor,
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr("reservationInformation"),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 16,
                            color: CustomColors.textColor8),
                      ),
                      if (widget.type.toString().isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                            color: widget.type.toString() == "Before Approval"
                                ? CustomColors.backgroundColor3
                                : widget.type.toString() == "Approved"
                                    ? CustomColors.backgroundColor
                                    : widget.type.toString() == "Used"
                                        ? CustomColors.backgroundColor
                                        : widget.type.toString() == "Rejected"
                                            ? CustomColors.redColor
                                            : CustomColors.textColorBlack2,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.only(
                              top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                          child: Text(
                            widget.type,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "SemiBold",
                              color: widget.type.toString() == "Before Approval"
                                  ? CustomColors.textColor9
                                  : widget.type.toString() == "Approved"
                                      ? CustomColors.textColorBlack2
                                      : widget.type.toString() == "Used"
                                          ? CustomColors.textColor3
                                          : widget.type.toString() == "Rejected"
                                              ? CustomColors.headingColor
                                              : CustomColors.textColorBlack2,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr("nameLounge"),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
                      ),
                      const Text(
                        "Hong Gil Dong",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      color: CustomColors.backgroundColor2,
                      thickness: 1,
                      height: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr("tenantCompanyLounge"),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
                      ),
                      const Text(
                        "CBRE",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              color: CustomColors.whiteColor,
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("reservationDate"),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 16,
                        color: CustomColors.textColor8),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      children: const [
                        Text(
                          "2023.00.00",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          child: VerticalDivider(
                            color: CustomColors.textColor3,
                            thickness: 1,
                          ),
                        ),
                        Text(
                          "9:00 ~ 18:00",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              color: CustomColors.whiteColor,
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("seatNumber"),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 16,
                        color: CustomColors.textColor8),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "22",
                    style: TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 14,
                        color: CustomColors.textColor8),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        color: CustomColors.whiteColor,
        padding:
            const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 40),
        child: CommonButtonWithBorder(
            onCommonButtonTap: () {},
            buttonBorderColor: widget.type == "Approved"
                ? CustomColors.dividerGreyColor.withOpacity(0.3)
                : CustomColors.dividerGreyColor,
            buttonColor: CustomColors.whiteColor,
            buttonName: tr("cancelReservation"),
            buttonTextColor: widget.type == "Approved"
                ? CustomColors.textColor5.withOpacity(0.3)
                : CustomColors.textColor5),
      ),
    );
  }
}
