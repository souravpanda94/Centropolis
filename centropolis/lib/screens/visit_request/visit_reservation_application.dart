import 'package:centropolis/widgets/common_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';

class VisitReservationApplication extends StatefulWidget {
  const VisitReservationApplication({super.key});

  @override
  State<VisitReservationApplication> createState() =>
      _VisitReservationApplicationState();
}

class _VisitReservationApplicationState
    extends State<VisitReservationApplication> {
  TextEditingController consentController = TextEditingController();
  TextEditingController visitorNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController purposeVisitController = TextEditingController();

  bool _isChecked = false, timeTapped = false, purposeVisitTapped = false;
  String time = "";

  List<dynamic> timeList = [
    "10:00",
    "12:00",
    "11:00",
    "13:00",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("visitReservationApplication"), false, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: CustomColors.whiteColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr("signUpConsent"),
                      style: const TextStyle(
                          fontFamily: 'Bold',
                          fontSize: 16,
                          color: CustomColors.textColor8),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      tr("visitReservationApplicationWarning"),
                      style: const TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 14,
                          color: CustomColors.textColorBlack2),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: CustomColors.dividerGreyColor,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      height: 264,
                      child: SingleChildScrollView(
                        child: TextField(
                          controller: consentController,
                          cursorColor: CustomColors.textColorBlack2,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: CustomColors.whiteColor,
                            filled: true,
                            contentPadding: const EdgeInsets.all(16),
                            hintText: tr('signUpConsentHint'),
                            hintStyle: const TextStyle(
                              color: CustomColors.textColor3,
                              fontSize: 14,
                              fontFamily: 'Regular',
                            ),
                          ),
                          style: const TextStyle(
                            color: CustomColors.blackColor,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            tr("signUpConsentConfirmation"),
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
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
                color: CustomColors.backgroundColor,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                color: CustomColors.whiteColor,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr("personInChargeInformation"),
                      style: const TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 16,
                          color: CustomColors.textColor8),
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
                          RichText(
                            text: TextSpan(
                                text: tr("nameOfPersonInCharge"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8),
                                children: const [
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: CustomColors.headingColor,
                                          fontSize: 12))
                                ]),
                            maxLines: 1,
                          ),
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
                          RichText(
                            text: TextSpan(
                                text: tr("tenantCompany"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8),
                                children: const [
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: CustomColors.headingColor,
                                          fontSize: 12))
                                ]),
                            maxLines: 1,
                          ),
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
                          RichText(
                            text: TextSpan(
                                text: tr("visitBuilding"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8),
                                children: const [
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: CustomColors.headingColor,
                                          fontSize: 12))
                                ]),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Tower A",
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          RichText(
                            text: TextSpan(
                                text: tr("landingFloor"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8),
                                children: const [
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: CustomColors.headingColor,
                                          fontSize: 12))
                                ]),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "11F",
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 10,
                color: CustomColors.backgroundColor,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                color: CustomColors.whiteColor,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr("visitorInformation"),
                      style: const TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 16,
                          color: CustomColors.textColor8),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    RichText(
                      text: TextSpan(
                          text: tr("visitorName"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                          children: const [
                            TextSpan(
                                text: ' *',
                                style: TextStyle(
                                    color: CustomColors.headingColor,
                                    fontSize: 12))
                          ]),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: visitorNameController,
                      cursorColor: CustomColors.textColorBlack2,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: CustomColors.whiteColor,
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        hintText: tr('visitorNameHint'),
                        hintStyle: const TextStyle(
                          color: CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.blackColor,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                          text: tr("companyName"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                          children: const [
                            TextSpan(
                                text: ' *',
                                style: TextStyle(
                                    color: CustomColors.headingColor,
                                    fontSize: 12))
                          ]),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: companyNameController,
                      cursorColor: CustomColors.textColorBlack2,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: CustomColors.whiteColor,
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        hintText: tr('companyNameHint'),
                        hintStyle: const TextStyle(
                          color: CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.blackColor,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                          text: tr("email"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                          children: const [
                            TextSpan(
                                text: ' *',
                                style: TextStyle(
                                    color: CustomColors.headingColor,
                                    fontSize: 12))
                          ]),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: emailController,
                      cursorColor: CustomColors.textColorBlack2,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: CustomColors.whiteColor,
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        hintText: tr('emailDemoHint'),
                        hintStyle: const TextStyle(
                          color: CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.blackColor,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                          text: tr("contact"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                          children: const [
                            TextSpan(
                                text: ' *',
                                style: TextStyle(
                                    color: CustomColors.headingColor,
                                    fontSize: 12))
                          ]),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: contactController,
                      cursorColor: CustomColors.textColorBlack2,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: CustomColors.whiteColor,
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        hintText: tr('contactHint'),
                        hintStyle: const TextStyle(
                          color: CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.blackColor,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                          text: tr("dateOfVisit"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                          children: const [
                            TextSpan(
                                text: ' *',
                                style: TextStyle(
                                    color: CustomColors.headingColor,
                                    fontSize: 12))
                          ]),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: dateController,
                      cursorColor: CustomColors.textColorBlack2,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: CustomColors.whiteColor,
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SvgPicture.asset(
                            "assets/images/ic_date.svg",
                            width: 8,
                            height: 4,
                            color: CustomColors.textColorBlack2,
                          ),
                        ),
                        hintText: "YYYY.MM.DD",
                        hintStyle: const TextStyle(
                          color: CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.blackColor,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                          text: tr("visitTime"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                          children: const [
                            TextSpan(
                                text: ' *',
                                style: TextStyle(
                                    color: CustomColors.headingColor,
                                    fontSize: 12))
                          ]),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      readOnly: true,
                      controller: timeController,
                      cursorColor: CustomColors.textColorBlack2,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: CustomColors.whiteColor,
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SvgPicture.asset(
                            "assets/images/ic_drop_down_arrow.svg",
                            width: 8,
                            height: 4,
                            color: CustomColors.textColorBlack2,
                          ),
                        ),
                        hintText: tr("visitTimeHint"),
                        hintStyle: const TextStyle(
                          color: CustomColors.textColorBlack2,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.blackColor,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                      onTap: () {
                        setState(() {
                          timeTapped = true;
                        });
                      },
                    ),
                    Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: tr("purposeOfVisit"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8),
                                  children: const [
                                    TextSpan(
                                        text: ' *',
                                        style: TextStyle(
                                            color: CustomColors.headingColor,
                                            fontSize: 12))
                                  ]),
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              readOnly: true,
                              controller: purposeVisitController,
                              cursorColor: CustomColors.textColorBlack2,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: CustomColors.whiteColor,
                                filled: true,
                                contentPadding: const EdgeInsets.all(16),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      color: CustomColors.dividerGreyColor,
                                      width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      color: CustomColors.dividerGreyColor,
                                      width: 1.0),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: SvgPicture.asset(
                                    "assets/images/ic_drop_down_arrow.svg",
                                    width: 8,
                                    height: 4,
                                    color: CustomColors.textColorBlack2,
                                  ),
                                ),
                                hintText: "business discussion",
                                hintStyle: const TextStyle(
                                  color: CustomColors.textColorBlack2,
                                  fontSize: 14,
                                  fontFamily: 'Regular',
                                ),
                              ),
                              style: const TextStyle(
                                color: CustomColors.blackColor,
                                fontSize: 14,
                                fontFamily: 'Regular',
                              ),
                              onTap: () {
                                setState(() {
                                  purposeVisitTapped = true;
                                });
                              },
                            ),
                            if (purposeVisitTapped)
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(top: 2),
                                decoration: BoxDecoration(
                                  color: CustomColors.whiteColor,
                                  border: Border.all(
                                    color: CustomColors.dividerGreyColor,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(4, (index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                purposeVisitTapped = false;
                                                purposeVisitController.text =
                                                    timeList[index];
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              child: Text(
                                                timeList[index],
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontFamily: 'Regular',
                                                    fontSize: 14,
                                                    color: CustomColors
                                                        .textColorBlack2),
                                              ),
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            height: 1,
                                            color:
                                                CustomColors.dividerGreyColor,
                                          )
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (timeTapped)
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 2),
                            decoration: BoxDecoration(
                              color: CustomColors.whiteColor,
                              border: Border.all(
                                color: CustomColors.dividerGreyColor,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(4, (index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            timeTapped = false;
                                            timeController.text =
                                                timeList[index];

                                            time =
                                                timeController.text.toString();
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          child: Text(
                                            timeList[index],
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                fontFamily: 'Regular',
                                                fontSize: 14,
                                                color: CustomColors
                                                    .textColorBlack2),
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        height: 1,
                                        color: CustomColors.dividerGreyColor,
                                      )
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 10,
                color: CustomColors.backgroundColor,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: CustomColors.whiteColor,
                padding: const EdgeInsets.only(
                    top: 16, left: 16, right: 16, bottom: 40),
                child: CommonButton(
                  onCommonButtonTap: () {},
                  buttonColor: CustomColors.buttonBackgroundColor,
                  buttonName: tr("visitReservationApplication"),
                  isIconVisible: false,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
