import 'package:centropolis/widgets/common_button_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';

class AirConditioningHistoryDetails extends StatefulWidget {
  final String type;
  const AirConditioningHistoryDetails({super.key, required this.type});

  @override
  State<AirConditioningHistoryDetails> createState() =>
      _AirConditioningHistoryDetailsState();
}

class _AirConditioningHistoryDetailsState
    extends State<AirConditioningHistoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              color: CustomColors.whiteColor,
              child: CommonAppBar(tr("AirConditioning"), false, () {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(tr("tenantCompanyInformation"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 16,
                                color: CustomColors.textColor8)),
                        if (widget.type.toString().isNotEmpty)
                          Container(
                            decoration: BoxDecoration(
                              color: widget.type.toString() == "Received"
                                  ? CustomColors.backgroundColor3
                                  : widget.type.toString() == "Approved"
                                      ? CustomColors.backgroundColor
                                      : widget.type.toString() == "In Progress"
                                          ? CustomColors.greyColor2
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
                                color: widget.type.toString() == "Received"
                                    ? CustomColors.textColor9
                                    : widget.type.toString() == "Approved"
                                        ? CustomColors.textColorBlack2
                                        : widget.type.toString() ==
                                                "In Progress"
                                            ? CustomColors.brownColor
                                            : CustomColors.textColorBlack2,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: CustomColors.backgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tr("nameLounge"),
                              style: const TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 14,
                                  color: CustomColors.textColor8)),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Hong Gil Dong",
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(tr("tenantCompanyLounge"),
                              style: const TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 14,
                                  color: CustomColors.textColor8)),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Centropolis",
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(tr("email"),
                              style: const TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 14,
                                  color: CustomColors.textColor8)),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "test1@centropolis.com",
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(tr("contactNo"),
                              style: const TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 14,
                                  color: CustomColors.textColor8)),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "010-0000-0000",
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: CustomColors.backgroundColor,
                width: MediaQuery.of(context).size.width,
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
                      tr("applicationFloor"),
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
                      "11F",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 14,
                          color: CustomColors.textColor8),
                    ),
                  ],
                ),
              ),
              Container(
                color: CustomColors.backgroundColor,
                width: MediaQuery.of(context).size.width,
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
                      tr("airConditioning/Heading"),
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
                      "Air conditioning",
                      style: TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 14,
                          color: CustomColors.textColor8),
                    ),
                  ],
                ),
              ),
              Container(
                color: CustomColors.backgroundColor,
                width: MediaQuery.of(context).size.width,
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
                      tr("dateOfApplication"),
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
                          Expanded(
                            child: Text(
                              "2023.00.00",
                              style: TextStyle(
                                  fontFamily: 'Regular',
                                  fontSize: 14,
                                  color: CustomColors.textColor8),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              child: VerticalDivider(
                                thickness: 1,
                                color: CustomColors.textColor3,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "20:00 ~ 22:00",
                              style: TextStyle(
                                  fontFamily: 'Regular',
                                  fontSize: 14,
                                  color: CustomColors.textColor8),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              child: VerticalDivider(
                                thickness: 1,
                                color: CustomColors.textColor3,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "2 hours (--KRW)",
                              style: TextStyle(
                                  fontFamily: 'Regular',
                                  fontSize: 14,
                                  color: CustomColors.textColor8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: CustomColors.backgroundColor,
                width: MediaQuery.of(context).size.width,
                height: 8,
              ),
              Container(
                color: CustomColors.whiteColor,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 140),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr("otherRequests"),
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
                      "Enter other requested information. Other request details are included.Other request details are entered.",
                      style: TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 14,
                          color: CustomColors.textColor8),
                    ),
                  ],
                ),
              ),
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
              buttonBorderColor: CustomColors.dividerGreyColor,
              buttonColor: CustomColors.whiteColor,
              buttonName: tr("cancelRequest"),
              buttonTextColor: CustomColors.textColor5),
        ));
  }
}
