import 'package:centropolis/models/amenity_history_model.dart';
import 'package:centropolis/widgets/common_button_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';

class ConferenceHistoryDetails extends StatefulWidget {
  final AmenityHistoryModel? conferenceListItem;
  const ConferenceHistoryDetails(this.conferenceListItem, {super.key,});

  @override
  State<ConferenceHistoryDetails> createState() =>
      _ConferenceHistoryDetailsState();
}

class _ConferenceHistoryDetailsState extends State<ConferenceHistoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("conferenceRoomReservation"), false, () {
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
                      if (widget.conferenceListItem?.status.toString()!= "")
                        Container(
                          decoration: BoxDecoration(
                            color: widget.conferenceListItem?.status.toString() == "Before Approval"
                                ? CustomColors.backgroundColor3
                                : widget.conferenceListItem?.status.toString() == "Approved"
                                    ? CustomColors.backgroundColor
                                    : widget.conferenceListItem?.status.toString() == "Used"
                                        ? CustomColors.backgroundColor
                                        : widget.conferenceListItem?.status.toString() == "Rejected"
                                            ? CustomColors.redColor
                                            : CustomColors.textColorBlack2,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.only(
                              top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                          child: Text(
                            widget.conferenceListItem?.displayStatus ?? "",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "SemiBold",
                              color: widget.conferenceListItem?.status.toString() == "Before Approval"
                                  ? CustomColors.textColor9
                                  : widget.conferenceListItem?.status.toString() == "Approved"
                                      ? CustomColors.textColorBlack2
                                      : widget.conferenceListItem?.status.toString() == "used"
                                          ? CustomColors.textColor3
                                          : widget.conferenceListItem?.status.toString() == "rejected"
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
                    tr("enterRentalInformation"),
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
                    "It is scheduled to be used by 10 people for a regular meeting, and additional services are not used.",
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
            buttonBorderColor: widget.conferenceListItem?.status == "Approved"
                ? CustomColors.dividerGreyColor.withOpacity(0.3)
                : CustomColors.dividerGreyColor,
            buttonColor: CustomColors.whiteColor,
            buttonName: tr("cancelReservation"),
            buttonTextColor: widget.conferenceListItem?.status == "Approved"
                ? CustomColors.textColor5.withOpacity(0.3)
                : CustomColors.textColor5),
      ),
    );
  }
}
