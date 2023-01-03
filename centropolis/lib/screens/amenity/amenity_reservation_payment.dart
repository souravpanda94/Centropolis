import 'package:centropolis/widgets/amenity/amenity_detail_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_modal.dart';

class AmenityReservationPayment extends StatefulWidget {
  const AmenityReservationPayment({super.key});

  @override
  State<StatefulWidget> createState() => _AmenityReservationPaymentState();
}

class _AmenityReservationPaymentState extends State<AmenityReservationPayment> {
  bool isCheck = false;

  void showModal() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: "Your reservation is complete.",
            description:
                "The conference room reservation is complete. \nPlease pay the payment amount on site. \nIf the meeting room is not used without cancellation, the free deduction time will be automatically deducted.",
            buttonName: tr("confirm"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {},
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                width: MediaQuery.of(context).size.width,
                color: CustomColors.whiteColor,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('meetingInformation'),
                        style: const TextStyle(
                            color: CustomColors.textColor1,
                            fontFamily: 'Regular',
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 15),
                        child: AmenityDetailRow(
                            title: tr('meetingDate'),
                            subtitle: '2022.04.14 13:30 - 15:30',
                            titleFontSize: 15,
                            titleTextColor: CustomColors.textColor1,
                            subtitleFontSize: 15,
                            subtitleTextColor: CustomColors.textColor1),
                      ),
                      const Divider(
                        thickness: 1,
                        color: CustomColors.borderColor2,
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 15, bottom: 30),
                          child: AmenityDetailRow(
                              title: tr('conferenceRoomType'),
                              subtitle: 'Conference 1',
                              titleFontSize: 15,
                              titleTextColor: CustomColors.textColor1,
                              subtitleFontSize: 15,
                              subtitleTextColor: CustomColors.textColor1)),
                      const Divider(
                        thickness: 1,
                        color: CustomColors.borderColor2,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr('meetingName'),
                              style: const TextStyle(
                                  color: CustomColors.textColor1,
                                  fontFamily: 'Regular',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 15,
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
                                      color: CustomColors.borderColor,
                                      width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: CustomColors.borderColor,
                                      width: 1.0),
                                ),
                                hintText: tr('meetingHint'),
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
                              height: 15,
                            ),
                            const Divider(
                              thickness: 1,
                              color: CustomColors.borderColor2,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tr('hostingMeeting'),
                                    style: const TextStyle(
                                        color: CustomColors.textColor1,
                                        fontFamily: 'Regular',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SvgPicture.asset(
                                      'assets/images/ic_payment_edit.svg')
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                              color: CustomColors.borderColor2,
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 15),
                                child: AmenityDetailRow(
                                    title: tr('additionalEquipment'),
                                    subtitle: 'video conferencing, laptop',
                                    titleFontSize: 15,
                                    titleTextColor: CustomColors.textColor1,
                                    subtitleFontSize: 15,
                                    subtitleTextColor:
                                        CustomColors.textColor1)),
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
                        tr('reservationInformation'),
                        style: const TextStyle(
                            color: CustomColors.textColor1,
                            fontFamily: 'Regular',
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 30, bottom: 15),
                          child: AmenityDetailRow(
                              title: tr('tenantCompany'),
                              subtitle: 'Centropolis resident company',
                              titleFontSize: 15,
                              titleTextColor: CustomColors.textColor1,
                              subtitleFontSize: 15,
                              subtitleTextColor: CustomColors.textColor1)),
                      const Divider(
                        thickness: 1,
                        color: CustomColors.borderColor2,
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: AmenityDetailRow(
                              title: tr('reservationAgent'),
                              subtitle: 'Hong Gil Dong',
                              titleFontSize: 15,
                              titleTextColor: CustomColors.textColor1,
                              subtitleFontSize: 15,
                              subtitleTextColor: CustomColors.textColor1)),
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
                        tr('paymentDetails'),
                        style: const TextStyle(
                            color: CustomColors.textColor1,
                            fontFamily: 'Regular',
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 30, bottom: 15),
                          child: AmenityDetailRow(
                              title: tr('theTotalAmount'),
                              subtitle: 'KRW 109,000',
                              titleFontSize: 15,
                              titleTextColor: CustomColors.textColor1,
                              subtitleFontSize: 15,
                              subtitleTextColor: CustomColors.textColor1)),
                      const Divider(
                        thickness: 1,
                        color: CustomColors.borderColor2,
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: const AmenityDetailRow(
                              title: 'Conference Room - Conference 1',
                              subtitle: '90,000 won',
                              titleFontSize: 14,
                              titleTextColor: CustomColors.textGreyColor,
                              subtitleFontSize: 13,
                              subtitleTextColor: CustomColors.textGreyColor)),
                      Container(
                          margin: const EdgeInsets.only(top: 9),
                          child: const AmenityDetailRow(
                              title: 'additional equipment',
                              subtitle: '+ 10,000 won',
                              titleFontSize: 14,
                              titleTextColor: CustomColors.textGreyColor,
                              subtitleFontSize: 13,
                              subtitleTextColor: CustomColors.textGreyColor)),
                      Container(
                          margin: const EdgeInsets.only(top: 9, bottom: 15),
                          child: const AmenityDetailRow(
                              title: 'VAT',
                              subtitle: '+ 9,000 won',
                              titleFontSize: 14,
                              titleTextColor: CustomColors.textGreyColor,
                              subtitleFontSize: 13,
                              subtitleTextColor: CustomColors.textGreyColor)),
                      const Divider(
                        thickness: 1,
                        color: CustomColors.borderColor2,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        child: const Divider(
                          thickness: 1,
                          color: CustomColors.textColor1,
                        ),
                      ),
                      AmenityDetailRow(
                          title: tr('theTotalAmount'),
                          subtitle: '10,000 won',
                          titleFontSize: 19,
                          titleTextColor: CustomColors.textColor1,
                          subtitleFontSize: 19,
                          subtitleTextColor: CustomColors.textColor1)
                    ],
                  ),
                )),
            Container(
                margin: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                color: CustomColors.whiteColor,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (() {
                              setState(() {
                                isCheck = !isCheck;
                              });
                            }),
                            child: SizedBox(
                              height: 15,
                              width: 15,
                              child: !isCheck
                                  ? SvgPicture.asset(
                                      'assets/images/ic_uncheck.svg')
                                  : SvgPicture.asset(
                                      'assets/images/ic_check.svg'),
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(tr('paymentTerms'),
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: CustomColors.textGreyColor,
                                    fontFamily: 'Regular',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CommonButton(
                        buttonName: tr('makePayment'),
                        isIconVisible: false,
                        buttonColor: CustomColors.buttonBackgroundColor,
                        onCommonButtonTap: () {
                          showModal();
                        },
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
