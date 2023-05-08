import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';

class GXReservationDetail extends StatefulWidget {
  const GXReservationDetail({super.key});

  @override
  State<GXReservationDetail> createState() => _GXReservationDetailState();
}

class _GXReservationDetailState extends State<GXReservationDetail> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("gXReservation"), false, () {
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
              width: MediaQuery.of(context).size.width,
              color: CustomColors.whiteColor,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("programInformation"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 16,
                        color: CustomColors.textColor8),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        color: CustomColors.backgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("programName"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "YOGA CLASS ",
                          style: TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          tr("dayOfTheWeek"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "Mon, Wed, Fri",
                          style: TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          tr("Time"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "10:00",
                          style: TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          tr("usageAmount"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "KRW 120,000 per month (excluding tax)",
                          style: TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          tr("dateOfUse"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "2023-00-00 ~ 2023-00-00",
                          style: TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          tr("applicationPeriod"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "2023-00-00 ~ 2023-00-00",
                          style: TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          tr("application/NumberOfPeople"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "9 / 10",
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
              height: 10,
              width: MediaQuery.of(context).size.width,
              color: CustomColors.backgroundColor,
            ),
            Container(
              color: CustomColors.whiteColor,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("reservationInformation"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 16,
                        color: CustomColors.textColor8),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr("nameLounge"),
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
                      ),
                      const Text(
                        "Hong Gil Dong",
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      thickness: 1,
                      height: 1,
                      color: CustomColors.backgroundColor2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr("tenantCompanyLounge"),
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
                      ),
                      const Text(
                        "CBRE",
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            Container(
              height: 10,
              width: MediaQuery.of(context).size.width,
              color: CustomColors.backgroundColor,
            ),
            Container(
              color: CustomColors.whiteColor,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SizedBox(
                            height: 15,
                            width: 15,
                            child: Checkbox(
                              checkColor: CustomColors.whiteColor,
                              activeColor: CustomColors.buttonBackgroundColor,
                              side: const BorderSide(
                                  color: CustomColors.greyColor, width: 1),
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                  if (_isChecked) {
                                  } else {}
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                        Expanded(
                          child: Text(
                            tr("gxReservationConsent"),
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 32),
                    child: CommonButton(
                      onCommonButtonTap: () {},
                      buttonColor: CustomColors.buttonBackgroundColor,
                      buttonName: tr("apply"),
                      isIconVisible: false,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
