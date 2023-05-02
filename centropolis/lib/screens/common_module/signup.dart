import 'package:centropolis/widgets/common_button.dart';
import 'package:centropolis/widgets/common_button_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignupScreenState();
  }
}

enum Gender { male, female }

class _SignupScreenState extends State<SignupScreen> {
  bool _isChecked = false, companyTapped = false, floorTapped = false;
  Gender? gender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("signUp"), false, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: [
                Text(
                  tr("signUpConsent"),
                  style: const TextStyle(
                      fontFamily: 'Bold',
                      fontSize: 16,
                      color: CustomColors.textColor8),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 24, bottom: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CustomColors.dividerGreyColor,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  height: 264,
                  child: SingleChildScrollView(
                    child: TextField(
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
              ]),
            ),
            Container(
              height: 8,
              color: CustomColors.greyColor2,
              margin: const EdgeInsets.symmetric(vertical: 20),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr("enterPersonalInformation"),
                        style: const TextStyle(
                            fontFamily: 'Bold',
                            fontSize: 16,
                            color: CustomColors.textColor8),
                      ),
                      RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                            text: '* ',
                            style: const TextStyle(
                                color: CustomColors.headingColor, fontSize: 12),
                            children: [
                              TextSpan(
                                text: tr("requiredInput"),
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 12,
                                    color: CustomColors.textColor8),
                              )
                            ]),
                        maxLines: 1,
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 24, bottom: 8),
                    width: MediaQuery.of(context).size.width,
                    child: RichText(
                      text: TextSpan(
                          text: tr("tenantCompany"),
                          style: const TextStyle(
                              fontFamily: 'Bold',
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
                  ),
                  TextField(
                    cursorColor: CustomColors.textColorBlack2,
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    showCursor: false,
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
                        hintText: tr('tenantCompanyHint'),
                        hintStyle: const TextStyle(
                          color: CustomColors.textColorBlack2,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SvgPicture.asset(
                            "assets/images/ic_drop_down_arrow.svg",
                            width: 8,
                            height: 4,
                            color: CustomColors.textColorBlack2,
                          ),
                        )),
                    style: const TextStyle(
                      color: CustomColors.blackColor,
                      fontSize: 14,
                      fontFamily: 'Regular',
                    ),
                    onTap: () {
                      setState(() {
                        companyTapped = true;
                      });
                    },
                  ),
                  Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 16, bottom: 8),
                            width: MediaQuery.of(context).size.width,
                            child: RichText(
                              text: TextSpan(
                                  text: tr("floor"),
                                  style: const TextStyle(
                                      fontFamily: 'Bold',
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
                          ),
                          Stack(
                            children: [
                              Column(
                                children: [
                                  TextField(
                                    onTap: () {
                                      setState(() {
                                        floorTapped = true;
                                      });
                                    },
                                    cursorColor: CustomColors.textColorBlack2,
                                    keyboardType: TextInputType.text,
                                    readOnly: true,
                                    showCursor: false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        fillColor: CustomColors.whiteColor,
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                              color:
                                                  CustomColors.dividerGreyColor,
                                              width: 1.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                              color:
                                                  CustomColors.dividerGreyColor,
                                              width: 1.0),
                                        ),
                                        hintText: tr('floorHint'),
                                        hintStyle: const TextStyle(
                                          color: CustomColors.textColorBlack2,
                                          fontSize: 14,
                                          fontFamily: 'Regular',
                                        ),
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: SvgPicture.asset(
                                            "assets/images/ic_drop_down_arrow.svg",
                                            width: 8,
                                            height: 4,
                                            color: CustomColors.textColorBlack2,
                                          ),
                                        )),
                                    style: const TextStyle(
                                      color: CustomColors.blackColor,
                                      fontSize: 14,
                                      fontFamily: 'Regular',
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 16, bottom: 8),
                                    width: MediaQuery.of(context).size.width,
                                    child: RichText(
                                      text: TextSpan(
                                          text: tr("name"),
                                          style: const TextStyle(
                                              fontFamily: 'Bold',
                                              fontSize: 14,
                                              color: CustomColors.textColor8),
                                          children: const [
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    color: CustomColors
                                                        .headingColor,
                                                    fontSize: 12))
                                          ]),
                                      maxLines: 1,
                                    ),
                                  ),
                                  TextField(
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
                                            color:
                                                CustomColors.dividerGreyColor,
                                            width: 1.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: const BorderSide(
                                            color:
                                                CustomColors.dividerGreyColor,
                                            width: 1.0),
                                      ),
                                      hintText: tr('nameHint'),
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
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 16, bottom: 8),
                                    width: MediaQuery.of(context).size.width,
                                    child: RichText(
                                      text: TextSpan(
                                          text: tr("IDHeading"),
                                          style: const TextStyle(
                                              fontFamily: 'Bold',
                                              fontSize: 14,
                                              color: CustomColors.textColor8),
                                          children: const [
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    color: CustomColors
                                                        .headingColor,
                                                    fontSize: 12))
                                          ]),
                                      maxLines: 1,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          cursorColor:
                                              CustomColors.textColorBlack2,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            fillColor: CustomColors.whiteColor,
                                            filled: true,
                                            contentPadding:
                                                const EdgeInsets.all(16),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: const BorderSide(
                                                  color: CustomColors
                                                      .dividerGreyColor,
                                                  width: 1.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: const BorderSide(
                                                  color: CustomColors
                                                      .dividerGreyColor,
                                                  width: 1.0),
                                            ),
                                            hintText: tr('IDHint'),
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
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      CommonButtonWithBorder(
                                        onCommonButtonTap: () {},
                                        buttonName: tr("verify"),
                                        buttonBorderColor:
                                            CustomColors.buttonBackgroundColor,
                                        buttonTextColor:
                                            CustomColors.buttonBackgroundColor,
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 16, bottom: 8),
                                    width: MediaQuery.of(context).size.width,
                                    child: RichText(
                                      text: TextSpan(
                                          text: tr("passwordHeading"),
                                          style: const TextStyle(
                                              fontFamily: 'Bold',
                                              fontSize: 14,
                                              color: CustomColors.textColor8),
                                          children: const [
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    color: CustomColors
                                                        .headingColor,
                                                    fontSize: 12))
                                          ]),
                                      maxLines: 1,
                                    ),
                                  ),
                                  TextField(
                                    cursorColor: CustomColors.textColorBlack2,
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: CustomColors.whiteColor,
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(16),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: const BorderSide(
                                            color:
                                                CustomColors.dividerGreyColor,
                                            width: 1.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: const BorderSide(
                                            color:
                                                CustomColors.dividerGreyColor,
                                            width: 1.0),
                                      ),
                                      hintText: tr('passwordHint'),
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
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 16, bottom: 8),
                                    width: MediaQuery.of(context).size.width,
                                    child: RichText(
                                      text: TextSpan(
                                          text: tr("verifyPassword"),
                                          style: const TextStyle(
                                              fontFamily: 'Bold',
                                              fontSize: 14,
                                              color: CustomColors.textColor8),
                                          children: const [
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    color: CustomColors
                                                        .headingColor,
                                                    fontSize: 12))
                                          ]),
                                      maxLines: 1,
                                    ),
                                  ),
                                  TextField(
                                    cursorColor: CustomColors.textColorBlack2,
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: CustomColors.whiteColor,
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(16),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: const BorderSide(
                                            color:
                                                CustomColors.dividerGreyColor,
                                            width: 1.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: const BorderSide(
                                            color:
                                                CustomColors.dividerGreyColor,
                                            width: 1.0),
                                      ),
                                      hintText: tr('verifyPasswordHint'),
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
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 16, bottom: 8),
                                    width: MediaQuery.of(context).size.width,
                                    child: RichText(
                                      text: TextSpan(
                                          text: tr("email"),
                                          style: const TextStyle(
                                              fontFamily: 'Bold',
                                              fontSize: 14,
                                              color: CustomColors.textColor8),
                                          children: const [
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    color: CustomColors
                                                        .headingColor,
                                                    fontSize: 12))
                                          ]),
                                      maxLines: 1,
                                    ),
                                  ),
                                  TextField(
                                    cursorColor: CustomColors.textColorBlack2,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: CustomColors.whiteColor,
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(16),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: const BorderSide(
                                            color:
                                                CustomColors.dividerGreyColor,
                                            width: 1.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: const BorderSide(
                                            color:
                                                CustomColors.dividerGreyColor,
                                            width: 1.0),
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
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 16, bottom: 8),
                                    width: MediaQuery.of(context).size.width,
                                    child: RichText(
                                      text: TextSpan(
                                          text: tr("contactNo"),
                                          style: const TextStyle(
                                              fontFamily: 'Bold',
                                              fontSize: 14,
                                              color: CustomColors.textColor8),
                                          children: const [
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    color: CustomColors
                                                        .headingColor,
                                                    fontSize: 12))
                                          ]),
                                      maxLines: 1,
                                    ),
                                  ),
                                  TextField(
                                    cursorColor: CustomColors.textColorBlack2,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: CustomColors.whiteColor,
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(16),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: const BorderSide(
                                            color:
                                                CustomColors.dividerGreyColor,
                                            width: 1.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: const BorderSide(
                                            color:
                                                CustomColors.dividerGreyColor,
                                            width: 1.0),
                                      ),
                                      hintText: tr('contactNoHint'),
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
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 16, bottom: 8),
                                    width: MediaQuery.of(context).size.width,
                                    child: RichText(
                                      text: TextSpan(
                                          text: tr("gender"),
                                          style: const TextStyle(
                                              fontFamily: 'Bold',
                                              fontSize: 14,
                                              color: CustomColors.textColor8),
                                          children: const [
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    color: CustomColors
                                                        .headingColor,
                                                    fontSize: 12))
                                          ]),
                                      maxLines: 1,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Radio<Gender>(
                                                activeColor:
                                                    CustomColors.buttonBackgroundColor,
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                value: Gender.male,
                                                groupValue: gender,
                                                onChanged: (Gender? value) {
                                                  setState(() {
                                                    gender = value;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                tr("male"),
                                                style: const TextStyle(
                                                    fontFamily: 'Regular',
                                                    color: CustomColors
                                                        .textColorBlack2,
                                                    fontSize: 14),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Radio<Gender>(
                                                activeColor:
                                                    CustomColors.buttonBackgroundColor,
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                value: Gender.female,
                                                groupValue: gender,
                                                onChanged: (Gender? value) {
                                                  setState(() {
                                                    gender = value;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                tr("female"),
                                                style: const TextStyle(
                                                    fontFamily: 'Regular',
                                                    color: CustomColors
                                                        .textColorBlack2,
                                                    fontSize: 14),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(
                                        top: 34, bottom: 16),
                                    child: CommonButton(
                                        onCommonButtonTap: () {},
                                        buttonColor: CustomColors.buttonBackgroundColor,
                                        buttonName: tr("signUp"),
                                        isIconVisible: false),
                                  ),
                                  CommonButtonWithBorder(
                                    onCommonButtonTap: () {},
                                    buttonBorderColor:
                                        CustomColors.dividerGreyColor,
                                    buttonName: tr("cancel"),
                                    buttonTextColor: CustomColors.textColor5,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(top: 24),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                              "assets/images/ic_warning.svg"),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Text(
                                              tr("warning"),
                                              style: const TextStyle(
                                                  fontFamily: 'Regular',
                                                  color: CustomColors
                                                      .textColorBlack2,
                                                  fontSize: 12),
                                            ),
                                          )
                                        ]),
                                  )
                                ],
                              ),
                              if (floorTapped)
                                Container(
                                  height: 186,
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
                                      children: List.generate(5, (index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  floorTapped = false;
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Text(
                                                  "Floor ${index.toString()}",
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
                          )
                        ],
                      ),
                      if (companyTapped)
                        Container(
                          height: 186,
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
                              children: List.generate(5, (index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          companyTapped = false;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        child: Text(
                                          "Index ${index.toString()}",
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 14,
                                              color:
                                                  CustomColors.textColorBlack2),
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
          ],
        )),
      ),
    );
  }
}
