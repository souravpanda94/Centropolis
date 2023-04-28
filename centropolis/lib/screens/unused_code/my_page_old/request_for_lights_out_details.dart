import 'package:centropolis/widgets/my_page/my_page_detail_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/custom_colors.dart';
import '../../../utils/utils.dart';
import '../../../widgets/amenity/amenity_detail_row.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/common_button.dart';
import 'cancel_reservation.dart';

class RequestForLightsOutDetailsScreen extends StatefulWidget {
  const RequestForLightsOutDetailsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RequestForLightsOutDetailsScreenState();
  }
}

class _RequestForLightsOutDetailsScreenState
    extends State<RequestForLightsOutDetailsScreen> {
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
              child: CommonAppBar(tr("requestForLightsOut"), false, () {
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
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Divider(
                              thickness: 1,
                              color: CustomColors.borderColor2,
                            ),
                          ),
                          Container(
                            color: CustomColors.backgroundColor,
                            height: 10,
                          ),
                        ],
                      ),
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
                              tr('lightsOutStart'),
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
                                    color: CustomColors.borderColor,
                                    width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: CustomColors.borderColor,
                                    width: 1.0),
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
                              tr('lightsOutEnd'),
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
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: CustomColors.borderColor,
                                    width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: CustomColors.borderColor,
                                    width: 1.0),
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
                        ],
                      ),
                    ),

                    // Container(
                    //   margin: const EdgeInsets.only(top: 40),
                    //   child: Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: Text(
                    //       tr("contactPersonInformation"),
                    //       style: const TextStyle(
                    //         fontSize: 20,
                    //         color: CustomColors.textColor4,
                    //         fontFamily: 'Regular',
                    //       ),
                    //       textAlign: TextAlign.left,
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: CustomColors.backgroundColor,
                    //     borderRadius: BorderRadius.circular(5),
                    //   ),
                    //   margin: const EdgeInsets.only(top: 17),
                    //   padding: const EdgeInsets.only(
                    //       left: 12, right: 12, top: 18, bottom: 18),
                    //   child: Column(
                    //     children: [
                    //       Align(
                    //         alignment: Alignment.centerLeft,
                    //         child: Text(
                    //           tr("personInCharge"),
                    //           style: const TextStyle(
                    //             fontSize: 11,
                    //             color: CustomColors.textColor5,
                    //             fontFamily: 'Regular',
                    //           ),
                    //           textAlign: TextAlign.left,
                    //         ),
                    //       ),
                    //       Container(
                    //         margin: const EdgeInsets.only(top: 5),
                    //         child: const Align(
                    //           alignment: Alignment.centerLeft,
                    //           child: Text(
                    //             "Hong Gil Dong",
                    //             style: TextStyle(
                    //               fontSize: 14,
                    //               color: CustomColors.textColor1,
                    //               fontFamily: 'Regular',
                    //             ),
                    //             textAlign: TextAlign.left,
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         margin: const EdgeInsets.only(top: 20),
                    //         child: Align(
                    //           alignment: Alignment.centerLeft,
                    //           child: Text(
                    //             tr("tenantCompanyName"),
                    //             style: const TextStyle(
                    //               fontSize: 11,
                    //               color: CustomColors.textColor5,
                    //               fontFamily: 'Regular',
                    //             ),
                    //             textAlign: TextAlign.left,
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         margin: const EdgeInsets.only(top: 5),
                    //         child: const Align(
                    //           alignment: Alignment.centerLeft,
                    //           child: Text(
                    //             "Centro Consulting 2",
                    //             style: TextStyle(
                    //               fontSize: 14,
                    //               color: CustomColors.textColor1,
                    //               fontFamily: 'Regular',
                    //             ),
                    //             textAlign: TextAlign.left,
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         margin: const EdgeInsets.only(top: 20),
                    //         child: Align(
                    //           alignment: Alignment.centerLeft,
                    //           child: Text(
                    //             tr("mobilePhoneNumber"),
                    //             style: const TextStyle(
                    //               fontSize: 11,
                    //               color: CustomColors.textColor5,
                    //               fontFamily: 'Regular',
                    //             ),
                    //             textAlign: TextAlign.left,
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         margin: const EdgeInsets.only(top: 5),
                    //         child: const Align(
                    //           alignment: Alignment.centerLeft,
                    //           child: Text(
                    //             "010-0000-0000",
                    //             style: TextStyle(
                    //               fontSize: 14,
                    //               color: CustomColors.textColor1,
                    //               fontFamily: 'Regular',
                    //             ),
                    //             textAlign: TextAlign.left,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    Container(
                      margin: const EdgeInsets.only(
                        top: 40,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: CommonButton(
                            buttonName: tr("apply"),
                            isIconVisible: false,
                            buttonColor: CustomColors.buttonBackgroundColor,
                            onCommonButtonTap: () {
                              setState(() {
                                showCancelReservationPage = true;
                              });
                            },
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
                visible: showCancelReservationPage,
                child: const CancelReservation(
                  showAirConditionerChoice: false,
                ))
          ],
        )));
  }
}
