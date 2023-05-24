import 'package:centropolis/widgets/common_button_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';

class InconvenienceHistoryDetails extends StatefulWidget {
  final String type;
  const InconvenienceHistoryDetails({super.key, required this.type});

  @override
  State<InconvenienceHistoryDetails> createState() =>
      _InconvenienceHistoryDetailsState();
}

class _InconvenienceHistoryDetailsState
    extends State<InconvenienceHistoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("complaintsReceived"), false, () {
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
                      Text(tr("applicantInformation"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 16,
                              color: CustomColors.textColor8)),
                      if (widget.type.toString().isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                            color: widget.type.toString() == "Received"
                                ? CustomColors.backgroundColor3
                                : widget.type.toString() == "Answered"
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
                                  : widget.type.toString() == "Answered"
                                      ? CustomColors.textColorBlack2
                                      : widget.type.toString() == "In Progress"
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
                          "CBRE",
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
                    tr("typeOfComplaint"),
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
                    "Construct",
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
              margin: widget.type.toString() == "Answered"
                  ? null
                  : const EdgeInsets.only(bottom: 120),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("complaintTitle"),
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
                    "Inconveniences are included. Inconveniences are included. Inconveniences are included. Inconveniences are included. Inconveniences are included. Inconveniences are included. Inconveniences are included.",
                    style: TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 14,
                        color: CustomColors.textColor8),
                  ),
                  if (widget.type.toString() == "Answered")
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        "assets/images/lounge.png",
                        fit: BoxFit.fill,
                        height: 194,
                      ),
                    )
                ],
              ),
            ),
            Container(
              color: CustomColors.backgroundColor,
              width: MediaQuery.of(context).size.width,
              height: 8,
            ),
            if (widget.type.toString() == "Answered")
              Container(
                color: CustomColors.whiteColor,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 150),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr("inquiryAnswer"),
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
                      "Enter your answer. Enter your answer. Enter your answer. The content of the answer is entered. The content of the answer is entered. Enter your answer. Enter your answer. The content of the answer is entered. The content of the answer is entered. Enter your answer. Enter your answer. The content of the answer is entered. The content of the answer is entered. Enter your answer. Enter your answer. Enter your answer.",
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
      bottomSheet: widget.type.toString() != "Answered"
          ? Container(
              width: MediaQuery.of(context).size.width,
              color: CustomColors.whiteColor,
              padding: const EdgeInsets.only(
                  left: 16, top: 16, right: 16, bottom: 40),
              child: CommonButtonWithBorder(
                  onCommonButtonTap: () {},
                  buttonBorderColor: widget.type == "Approved"
                      ? CustomColors.dividerGreyColor.withOpacity(0.3)
                      : CustomColors.dividerGreyColor,
                  buttonColor: CustomColors.whiteColor,
                  buttonName: tr("delete"),
                  buttonTextColor: CustomColors.textColor5),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: CustomColors.whiteColor,
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: CommonButtonWithBorder(
                      onCommonButtonTap: () {},
                      buttonBorderColor: CustomColors.buttonBackgroundColor,
                      buttonColor: CustomColors.whiteColor,
                      buttonName: tr("addInquiry"),
                      buttonTextColor: CustomColors.buttonBackgroundColor),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: CustomColors.whiteColor,
                  padding: const EdgeInsets.only(
                      left: 16, top: 16, right: 16, bottom: 40),
                  child: CommonButtonWithBorder(
                      onCommonButtonTap: () {},
                      buttonBorderColor: CustomColors.dividerGreyColor,
                      buttonColor: CustomColors.whiteColor,
                      buttonName: tr("toList"),
                      buttonTextColor: CustomColors.textColor5),
                )
              ],
            ),
    );
  }
}
