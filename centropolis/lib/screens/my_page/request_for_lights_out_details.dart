import 'dart:convert';
import 'package:centropolis/utils/utils.dart';
import 'package:centropolis/widgets/common_button_with_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/custom_colors.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_modal.dart';
import '../../widgets/home_page_app_bar.dart';

class RequestForLightsOutDetailsScreen extends StatefulWidget {
  const RequestForLightsOutDetailsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RequestForLightsOutDetailsScreenState();
  }
}

class _RequestForLightsOutDetailsScreenState
    extends State<RequestForLightsOutDetailsScreen> {
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
          child: Container(
            margin: const EdgeInsets.only(
                top: 30.0, bottom: 30.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0, ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tr("tenantCompanyInformation"),
                      style: const TextStyle(
                        fontSize: 20,
                        color: CustomColors.textColor4,
                        fontFamily: 'Regular',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: CustomColors.backgroundColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: const EdgeInsets.only(top: 17,left: 20.0, right: 20.0, ),
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 18, bottom: 18),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          tr("applicantName"),
                          style: const TextStyle(
                            fontSize: 11,
                            color: CustomColors.textColor5,
                            fontFamily: 'Regular',
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Hong Gil Dong",
                            style: TextStyle(
                              fontSize: 14,
                              color: CustomColors.textColor1,
                              fontFamily: 'Regular',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            tr("companyName"),
                            style: const TextStyle(
                              fontSize: 11,
                              color: CustomColors.textColor5,
                              fontFamily: 'Regular',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Centro Consulting",
                            style: TextStyle(
                              fontSize: 14,
                              color: CustomColors.textColor1,
                              fontFamily: 'Regular',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            tr("mobilePhoneNumber"),
                            style: const TextStyle(
                              fontSize: 11,
                              color: CustomColors.textColor5,
                              fontFamily: 'Regular',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "010-0000-0000",
                            style: TextStyle(
                              fontSize: 14,
                              color: CustomColors.textColor1,
                              fontFamily: 'Regular',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            tr("email"),
                            style: const TextStyle(
                              fontSize: 11,
                              color: CustomColors.textColor5,
                              fontFamily: 'Regular',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "welcome@centropolis.co.kr",
                            style: TextStyle(
                              fontSize: 14,
                              color: CustomColors.textColor1,
                              fontFamily: 'Regular',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                Container(
                  color: CustomColors.backgroundColor,
                  height: 10,
                  margin: const EdgeInsets.only(top: 25,),
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
                  margin: const EdgeInsets.only(top: 40,left: 20.0, right: 20.0, ),
                  child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: CommonButton(
                        buttonName: tr("apply"),
                        isIconVisible: false,
                        buttonColor: CustomColors.buttonBackgroundColor,
                        onCommonButtonTap: () {},
                      )),
                ),

              ],
            ),
          ),
        ));
  }









}
