import 'package:centropolis/widgets/amenity/amenity_detail_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/my_page/my_page_detail_info.dart';

class HeatingCoolingCancelReservation extends StatefulWidget {
  final bool showAirConditionerChoice;
  const HeatingCoolingCancelReservation(
      {super.key, required this.showAirConditionerChoice});

  @override
  State<StatefulWidget> createState() =>
      _HeatingCoolingCancelReservationState();
}

enum Choice { cooling, heating }

class _HeatingCoolingCancelReservationState
    extends State<HeatingCoolingCancelReservation> {
  Choice choice = Choice.cooling;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar('', false, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            const MyPageDetailInfo(
                applicantName: 'Hong Gil Dong',
                companyName: 'Centro Consulting',
                phoneNumber: '010-0000-0000',
                emailID: 'welcome@centropolis.co.kr'),
            Container(
              color: CustomColors.backgroundColor,
              height: 10,
            ),
            Visibility(
              visible: widget.showAirConditionerChoice ? true : false,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr('choiceOfAirConditioner'),
                      style: const TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: CustomColors.textColor1),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.only(right: 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              Radio<Choice>(
                                activeColor: CustomColors.buttonBackgroundColor,
                                value: Choice.cooling,
                                groupValue: choice,
                                onChanged: (value) {
                                  setState(() {
                                    choice = value!;
                                  });
                                },
                              ),
                              Text(
                                tr('cooling'),
                                style: const TextStyle(
                                    color: CustomColors.textColor1,
                                    fontFamily: 'Regular',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Radio<Choice>(
                                activeColor: CustomColors.buttonBackgroundColor,
                                value: Choice.heating,
                                groupValue: choice,
                                onChanged: (value) {
                                  setState(() {
                                    choice = value!;
                                  });
                                },
                              ),
                              Text(
                                tr('heating'),
                                style: const TextStyle(
                                    color: CustomColors.textColor1,
                                    fontFamily: 'Regular',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: CustomColors.backgroundColor,
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.showAirConditionerChoice
                        ? tr('heatingAndCooling')
                        : tr('lightsOut'),
                    style: const TextStyle(
                        color: CustomColors.textColor1,
                        fontFamily: 'Regular',
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: const Text(
                      'April 14, 2022 20:00 ~ 22:00',
                      style: TextStyle(
                          color: CustomColors.textColor1,
                          fontFamily: 'Regular',
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: CustomColors.backgroundColor,
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('amountOfPayment'),
                    style: const TextStyle(
                        color: CustomColors.textColor1,
                        fontFamily: 'Regular',
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: const AmenityDetailRow(
                        title: 'cooling',
                        subtitle: 'KRW 0,000',
                        titleFontSize: 14,
                        titleTextColor: CustomColors.textGreyColor,
                        subtitleFontSize: 13,
                        subtitleTextColor: CustomColors.textGreyColor),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: const Divider(
                        thickness: 1,
                        color: CustomColors.textGreyColor,
                      )),
                  AmenityDetailRow(
                      title: tr('theTotalAmount'),
                      subtitle: 'KRW 0,000',
                      titleFontSize: 19,
                      titleTextColor: CustomColors.textColor1,
                      subtitleFontSize: 19,
                      subtitleTextColor: CustomColors.textColor1),
                  Container(
                    height: 40,
                  ),
                  CommonButton(
                    buttonName: tr('cancelReservation'),
                    isIconVisible: false,
                    buttonColor: CustomColors.buttonBackgroundColor,
                    onCommonButtonTap: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
