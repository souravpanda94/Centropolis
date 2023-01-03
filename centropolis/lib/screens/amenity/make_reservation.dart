import 'package:centropolis/screens/amenity/amenity_reservation_payment.dart';
import 'package:centropolis/widgets/amenity/amenity_detail_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';

class AmenityMakeReservation extends StatefulWidget {
  const AmenityMakeReservation({super.key});

  @override
  State<StatefulWidget> createState() => _AmenityMakeReservationState();
}

class _AmenityMakeReservationState extends State<AmenityMakeReservation> {
  bool value1 = false, value2 = true, value3 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.borderColor2,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("homeRowBook"), false, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: CustomColors.whiteColor,
              child: Container(
                margin: const EdgeInsets.only(
                    left: 16, right: 16, top: 24, bottom: 10),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('selectMeetingDate'),
                          style: const TextStyle(
                              color: CustomColors.textColor1,
                              fontFamily: 'Regular',
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: const Divider(
                            thickness: 1,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 10),
              color: CustomColors.whiteColor,
              child: Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
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
                            tr('meetingStart'),
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
                            hintText: '13:30',
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
                            tr('endOfMeeting'),
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
                            hintText: '15:30',
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
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 10),
              color: CustomColors.whiteColor,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr('numberOfParticipants'),
                      style: const TextStyle(
                          color: CustomColors.textColor1,
                          fontFamily: 'Regular',
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start,
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset('assets/images/ic_remove.svg'),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'One',
                              style: TextStyle(
                                  color: CustomColors.textColor1,
                                  fontFamily: 'Regular',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SvgPicture.asset('assets/images/ic_add.svg'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 10),
                color: CustomColors.whiteColor,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('additionalRequirements'),
                        style: const TextStyle(
                            color: CustomColors.textColor1,
                            fontFamily: 'Regular',
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: (() {
                                    setState(() {
                                      value1 = !value1;
                                    });
                                  }),
                                  child: SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: !value1
                                        ? SvgPicture.asset(
                                            'assets/images/ic_uncheck.svg')
                                        : SvgPicture.asset(
                                            'assets/images/ic_check.svg'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  'Additional equipment 1',
                                  style: TextStyle(
                                      color: CustomColors.textColor1,
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                SvgPicture.asset('assets/images/info.svg')
                              ],
                            ),
                            const Text(
                              'free',
                              style: TextStyle(
                                  color: CustomColors.textGreyColor,
                                  fontFamily: 'Regular',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: (() {
                                    setState(() {
                                      value2 = !value2;
                                    });
                                  }),
                                  child: SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: !value2
                                        ? SvgPicture.asset(
                                            'assets/images/ic_uncheck.svg')
                                        : SvgPicture.asset(
                                            'assets/images/ic_check.svg'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  'additional equipment 2',
                                  style: TextStyle(
                                      color: CustomColors.textColor1,
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                SvgPicture.asset('assets/images/info.svg')
                              ],
                            ),
                            const Text(
                              'free',
                              style: TextStyle(
                                  color: CustomColors.textColor1,
                                  fontFamily: 'Regular',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: (() {
                                    setState(() {
                                      value3 = !value3;
                                    });
                                  }),
                                  child: SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: !value3
                                        ? SvgPicture.asset(
                                            'assets/images/ic_uncheck.svg')
                                        : SvgPicture.asset(
                                            'assets/images/ic_check.svg'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  'additional equipment 3',
                                  style: TextStyle(
                                      color: CustomColors.textColor1,
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                SvgPicture.asset('assets/images/info.svg')
                              ],
                            ),
                            const Text(
                              'Paid / 10,000 won',
                              style: TextStyle(
                                  color: CustomColors.textColor1,
                                  fontFamily: 'Regular',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 10),
              color: CustomColors.whiteColor,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr('amountOfPayment'),
                      style: const TextStyle(
                          color: CustomColors.textColor1,
                          fontFamily: 'Regular',
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: Column(
                        children: [
                          const AmenityDetailRow(
                              title: 'Meeting Room - Conference Room 1',
                              subtitle: '99,000 won',
                              titleFontSize: 14,
                              titleTextColor: CustomColors.textGreyColor,
                              subtitleFontSize: 14,
                              subtitleTextColor: CustomColors.textGreyColor),
                          const SizedBox(
                            height: 8,
                          ),
                          const AmenityDetailRow(
                              title: 'additional equipment',
                              subtitle: '+ 10,000 won',
                              titleFontSize: 14,
                              titleTextColor: CustomColors.textGreyColor,
                              subtitleFontSize: 14,
                              subtitleTextColor: CustomColors.textGreyColor),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            thickness: 1,
                            color: CustomColors.textGreyColor,
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          AmenityDetailRow(
                              title: tr('theTotalAmount'),
                              subtitle: 'KRW 109,000',
                              titleFontSize: 19,
                              titleTextColor: CustomColors.textColor1,
                              subtitleFontSize: 19,
                              subtitleTextColor: CustomColors.textColor1),
                        ],
                      ),
                    ),
                    CommonButton(
                      buttonName: tr('next'),
                      isIconVisible: false,
                      buttonColor: CustomColors.buttonBackgroundColor,
                      onCommonButtonTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AmenityReservationPayment(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
