import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/amenity/amenity_detail_row.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/my_page/my_page_detail_info.dart';
import 'cancel_reservation.dart';

class HeatingCoolingDetail extends StatefulWidget {
  const HeatingCoolingDetail({super.key});

  @override
  State<StatefulWidget> createState() => _HeatingCoolingDetailState();
}

enum Choice { cooling, heating }

class _HeatingCoolingDetailState extends State<HeatingCoolingDetail> {
  Choice choice = Choice.cooling;
  bool showCancelReservationPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("heatingCoolingExtensionApplication"), false,
                () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Visibility(
            visible: showCancelReservationPage ? false : true,
            child: Container(
              margin: const EdgeInsets.only(top: 30.0, bottom: 30.0),
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 18),
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
                                    activeColor:
                                        CustomColors.buttonBackgroundColor,
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
                                    activeColor:
                                        CustomColors.buttonBackgroundColor,
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
                  Container(
                    color: CustomColors.backgroundColor,
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.only(top: 30, left: 18, right: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('selectDate'),
                          style: const TextStyle(
                              color: CustomColors.textColor1,
                              fontFamily: 'Regular',
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Divider(
                            thickness: 1,
                            color: CustomColors.borderColor2,
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
                    padding:
                        const EdgeInsets.only(top: 30, left: 18, right: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('timeSelection'),
                          style: const TextStyle(
                              color: CustomColors.textColor1,
                              fontFamily: 'Regular',
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Text(
                            tr('extensionStart'),
                            style: const TextStyle(
                                color: CustomColors.textColor1,
                                fontFamily: 'Regular',
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        TextField(
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: CustomColors.whiteColor,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 17.0,
                              horizontal: 12.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: CustomColors.borderColor, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: CustomColors.borderColor, width: 1.0),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: SvgPicture.asset(
                                'assets/images/ic_drop_down_arrow.svg',
                                color: CustomColors.textColorBlack2,
                                semanticsLabel: 'Back',
                              ),
                            ),
                            hintText: '20:00',
                            hintStyle: const TextStyle(
                              color: CustomColors.unSelectedColor,
                              fontSize: 14,
                              fontFamily: 'Regular',
                            ),
                          ),
                          style: const TextStyle(
                            color: CustomColors.textColorBlack2,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: Text(
                            tr('extensionEnd'),
                            style: const TextStyle(
                                color: CustomColors.textColor1,
                                fontFamily: 'Regular',
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        TextField(
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: CustomColors.whiteColor,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 17.0,
                              horizontal: 12.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: CustomColors.borderColor, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: CustomColors.borderColor, width: 1.0),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: SvgPicture.asset(
                                'assets/images/ic_drop_down_arrow.svg',
                                color: CustomColors.textColorBlack2,
                                semanticsLabel: 'Back',
                              ),
                            ),
                            hintText: '22:00',
                            hintStyle: const TextStyle(
                              color: CustomColors.unSelectedColor,
                              fontSize: 14,
                              fontFamily: 'Regular',
                            ),
                          ),
                          style: const TextStyle(
                            color: CustomColors.textColorBlack2,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: CustomColors.backgroundColor,
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.only(top: 30, left: 18, right: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                tr('amountOfPayment'),
                                style: const TextStyle(
                                    color: CustomColors.textColor1,
                                    fontFamily: 'Regular',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      tr('providedByTheTenantCompany'),
                                      style: const TextStyle(
                                          color: CustomColors.textColor1,
                                          fontFamily: 'Regular',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    'assets/images/info.svg',
                                    height: 12,
                                    width: 12,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 30,
                        ),
                        AmenityDetailRow(
                            title: tr('cooling'),
                            subtitle: 'KRW 0,000',
                            titleFontSize: 14,
                            titleTextColor: CustomColors.textGreyColor,
                            subtitleFontSize: 13,
                            subtitleTextColor: CustomColors.textGreyColor),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: const Divider(
                            thickness: 1,
                            color: CustomColors.textGreyColor,
                          ),
                        ),
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
                          buttonName: tr('apply'),
                          isIconVisible: false,
                          buttonColor: CustomColors.buttonBackgroundColor,
                          onCommonButtonTap: () {
                            setState(() {
                              showCancelReservationPage = true;
                            });
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Visibility(
              visible: showCancelReservationPage,
              child: const CancelReservation(
                showAirConditionerChoice: true,
              ))
        ],
      )),
    );
  }
}
