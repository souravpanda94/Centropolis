import 'dart:convert';
import 'dart:io';

import 'package:centropolis/widgets/common_button.dart';
import 'package:centropolis/widgets/common_button_with_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../models/company_model.dart';
import '../../models/floor_model.dart';
import '../../providers/company_provider.dart';
import '../../providers/floor_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_modal.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignupScreenState();
  }
}

enum Gender { male, female }

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController consentController = TextEditingController();
  TextEditingController tenantCompanyController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController verifyPasswordController = TextEditingController();
  TextEditingController emailIDController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  bool isLoading = false;
  late String language;
  late FToast fToast;
  bool isUserIdVerified = false;
  bool isChecked = false;
  bool companyTapped = false;
  bool floorTapped = false;
  Gender? gender = Gender.male;
  String genderValue = "m";
  int tenantCompany = 3;
  String floor = "5f";
  String platform = "";

  // List<CompanyModel>? companyListItem;
  // List<FloorModel>? floorListItem;
  List<dynamic> companyList = [];
  List<dynamic> companyList2 = [
    {"company_id": 9, "company_name": "testdemo123", "status": "active"},
    {"company_id": 3, "company_name": "test_43", "status": "active"},
  ];
  List<dynamic> floorList = [];
  String currentSelectedCompanyNameId = "";

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    loadCompanyList();
    loadFloorList();
    setPlatform();
  }

  @override
  Widget build(BuildContext context) {
    // companyListItem = Provider.of<CompanyProvider>(context).getCompanyList;
    // floorListItem = Provider.of<FloorProvider>(context).geFloorList;
    // debugPrint("Company list => $companyListItem");
    // debugPrint("Floor list => $floorListItem");

    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.textColor4,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isLoading,
      child: Scaffold(
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
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                                if (isChecked) {
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
                                  color: CustomColors.headingColor,
                                  fontSize: 12),
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

                    // companyNameFieldWidget(),

                    TextField(
                      controller: tenantCompanyController,
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
                                color: CustomColors.dividerGreyColor,
                                width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                                color: CustomColors.dividerGreyColor,
                                width: 1.0),
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
                                      controller: floorController,
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
                                              color:
                                                  CustomColors.textColorBlack2,
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
                                      controller: nameController,
                                      cursorColor: CustomColors.textColorBlack2,
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
                                            controller: idController,
                                            cursorColor:
                                                CustomColors.textColorBlack2,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              fillColor:
                                                  CustomColors.whiteColor,
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
                                          onCommonButtonTap: () {
                                            callVerifyUserId();
                                          },
                                          buttonName: tr("verify"),
                                          buttonBorderColor: CustomColors
                                              .buttonBackgroundColor,
                                          buttonTextColor: CustomColors
                                              .buttonBackgroundColor,
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
                                      controller: passwordController,
                                      cursorColor: CustomColors.textColorBlack2,
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
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
                                      controller: verifyPasswordController,
                                      cursorColor: CustomColors.textColorBlack2,
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
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
                                      controller: emailIDController,
                                      cursorColor: CustomColors.textColorBlack2,
                                      keyboardType: TextInputType.emailAddress,
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
                                      controller: contactNoController,
                                      cursorColor: CustomColors.textColorBlack2,
                                      keyboardType: TextInputType.number,
                                      maxLength: 11,
                                      decoration: InputDecoration(
                                        counterText: '',
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
                                                  activeColor: CustomColors
                                                      .buttonBackgroundColor,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  value: Gender.male,
                                                  groupValue: gender,
                                                  onChanged: (Gender? value) {
                                                    setState(() {
                                                      gender = value;
                                                      if (gender ==
                                                          Gender.male) {
                                                        genderValue = "m";
                                                      } else {
                                                        genderValue = "f";
                                                      }
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
                                                  activeColor: CustomColors
                                                      .buttonBackgroundColor,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  value: Gender.female,
                                                  groupValue: gender,
                                                  onChanged: (Gender? value) {
                                                    setState(() {
                                                      gender = value;
                                                      if (gender ==
                                                          Gender.male) {
                                                        genderValue = "m";
                                                      } else {
                                                        genderValue = "f";
                                                      }
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
                                          onCommonButtonTap: () {
                                            // showSignUpSuccessModal();
                                            if (isChecked) {
                                              signUpValidation();
                                            } else {
                                              showCustomToast(
                                                  fToast,
                                                  context,
                                                  "Please checked use of personal information",
                                                  "");
                                            }
                                          },
                                          buttonColor: CustomColors
                                              .buttonBackgroundColor,
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
                                                    floorController.text =
                                                        index.toString();
                                                    floor = index.toString();
                                                  });
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Text(
                                                    index.toString(),
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
                                                color: CustomColors
                                                    .dividerGreyColor,
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

                        // if (companyTapped)
                        //   Container(
                        //     height: 186,
                        //     width: MediaQuery.of(context).size.width,
                        //     margin: const EdgeInsets.only(top: 2),
                        //     decoration: BoxDecoration(
                        //       color: CustomColors.whiteColor,
                        //       border: Border.all(
                        //         color: CustomColors.dividerGreyColor,
                        //       ),
                        //       borderRadius: BorderRadius.circular(4),
                        //     ),
                        //     child: SingleChildScrollView(
                        //       child: Column(
                        //         children: List.generate(5, (index) {
                        //           return Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               InkWell(
                        //                 onTap: () {
                        //                   setState(() {
                        //                     companyTapped = false;
                        //                     tenantCompanyController.text =
                        //                         index.toString();
                        //                     tenantCompany = index.toString();
                        //                   });
                        //                 },
                        //                 child: Container(
                        //                   padding: const EdgeInsets.all(16),
                        //                   child: Text(
                        //                     index.toString(),
                        //                     textAlign: TextAlign.start,
                        //                     style: const TextStyle(
                        //                         fontFamily: 'Regular',
                        //                         fontSize: 14,
                        //                         color:
                        //                             CustomColors.textColorBlack2),
                        //                   ),
                        //                 ),
                        //               ),
                        //               const Divider(
                        //                 thickness: 1,
                        //                 height: 1,
                        //                 color: CustomColors.dividerGreyColor,
                        //               )
                        //             ],
                        //           );
                        //         }),
                        //       ),
                        //     ),
                        //   ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  void showSignUpSuccessModal(String title, String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            // heading: tr("memberRegistrationComplete"),
            // description: tr("signUpIsComplete"),
            heading: title,
            description: message,
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  void signUpValidation() {
    if (tenantCompany == -1) {
      showCustomToast(fToast, context, "Please select company name", "");
    } else if (floor == "") {
      showCustomToast(fToast, context, "Please select floor", "");
    }
    else if (nameController.text == "") {
      showCustomToast(fToast, context, "Please enter name", "");
    }
    else if (idController.text == "") {
      showCustomToast(fToast, context, "Please enter id", "");
    }
    else if(!isUserIdVerified){
      showCustomToast(fToast, context, "user id is not verified", "");
    }
    else if (!isValidPassword(passwordController.text)) {
      showCustomToast(fToast, context, "Please enter password", "");
    }
    else if (!isValidPassword(verifyPasswordController.text)) {
      showCustomToast(fToast, context, "Please enter verify password", "");
    }
    else if (verifyPasswordController.text != passwordController.text) {
      showCustomToast(fToast, context, "Password & verify password should be same", "");
    }
    else if (!isValidEmail(emailIDController.text)) {
      showCustomToast(fToast, context, "Please enter proper email id", "");
    }
    else if (!isValidPhoneNumber(contactNoController.text)) {
      showCustomToast(fToast, context, "Please enter proper contact number", "");
    }
    else if (genderValue == "") {
      showCustomToast(fToast, context, "Please select gender", "");
    } else {
      callSignupNetworkCheck();
    }
  }

  void callSignupNetworkCheck() async {
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callSignUpApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callSignUpApi() async {
    setState(() {
      isLoading = true;
    });
    hideKeyboard();
    Map<String, dynamic> body = {
      "company_id": tenantCompany,
      "name": nameController.text.trim(),
      "email": emailIDController.text.trim(),
      "mobile": contactNoController.text.trim(),
      "username": idController.text.trim(),
      "gender": genderValue.trim(),
      "floor": floor,
      "password": passwordController.text.trim(),
      "confirm_password": verifyPasswordController.text.trim(),
      "platform": platform
    };
    debugPrint("sign up input ===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.signUpdUrl, body, language.trim(), null);
    response.then((response) {
      var responseJson = json.decode(response.body);
      debugPrint("server response for sign up ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          late String title, message;

          if (responseJson['title'] != null) {
            title = responseJson['title'].toString();
          }
          if (responseJson['message'] != null) {
            message = responseJson['message'].toString();
          }
          showSignUpSuccessModal(title, message);
        } else {
          if (responseJson['message'] != null) {
            debugPrint("Server error response ${responseJson['message']}");
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void setPlatform() {
    if (Platform.isAndroid) {
      setState(() {
        platform = "android";
      });
    } else if (Platform.isIOS) {
      setState(() {
        platform = "ios";
      });
    }
  }

  void loadCompanyList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadCompanyListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callLoadCompanyListApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};

    debugPrint("Company List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getCompanyListUrl, body, language.toString(), null);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Company List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          // List<CompanyModel> companyList = List<CompanyModel>.from(responseJson['company_list'].map((x) => CompanyModel.fromJson(x)));
          //   Provider.of<CompanyProvider>(context, listen: false).setItem(companyList);

          if (responseJson['company_list'] != null) {
            setState(() {
              companyList = responseJson['company_list'];
            });
          }
        } else {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isLoading = false;
      });
    });
  }

  void loadFloorList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadFloorListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callLoadFloorListApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {
      "company_id": "3",
    };

    debugPrint("Floor List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getFloorListUrl, body, language.toString(), null);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Floor List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          // List<FloorModel> floorList = List<FloorModel>.from(
          //     responseJson['data'].map((x) => FloorModel.fromJson(x)));
          //
          // Provider.of<FloorProvider>(context, listen: false).setItem(floorList);

          if (responseJson['data'] != null) {
            setState(() {
              floorList = responseJson['data'];
            });
          }
        } else {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isLoading = false;
      });
    });
  }

  void callVerifyUserId() async {
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callVerifyUserIdApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callVerifyUserIdApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "username": idController.text.trim()};

    debugPrint("verify User Name input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.verifyUserNameUrl, body, language.toString(), null);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for verify User Name ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          setState(() {
            isUserIdVerified = true;
          });
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        } else {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget companyNameFieldWidget() {
    return Container(
      height: 47,
      margin: const EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: const [
              Icon(
                Icons.list,
                size: 16,
                color: Colors.yellow,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  'Select Item',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: companyList2
              .map((item) => DropdownMenuItem<String>(
                    value: item[''].toString(),
                    child: Text(
                      item[''],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: currentSelectedCompanyNameId,
          onChanged: (value) {
            setState(() {
              currentSelectedCompanyNameId = value as String;
            });
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            width: 160,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: Colors.redAccent,
            ),
            elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            iconEnabledColor: Colors.yellow,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 200,
            padding: null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.redAccent,
            ),
            elevation: 8,
            offset: const Offset(-20, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all<double>(6),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),

      // DropdownButtonHideUnderline(
      //   child: DropdownButton2(
      //     isExpanded: true,
      //     hint: Row(
      //       children: [
      //         Expanded(
      //           child: Text(
      //             tr('tenantCompanyHint'),
      //             style: const TextStyle(
      //               color: CustomColors.blackColor,
      //               fontSize: 14,
      //               fontFamily: 'Regular',
      //             ),
      //             overflow: TextOverflow.ellipsis,
      //           ),
      //         ),
      //       ],
      //     ),
      //     items: companyList2
      //         .map((item) => DropdownMenuItem<String>(
      //       value: item['company_id'].toString(),
      //       child: Text(
      //         item['company_name'],
      //         style: const TextStyle(
      //           color: CustomColors.blackColor,
      //           fontSize: 14,
      //           fontFamily: 'Regular',
      //         ),
      //         overflow: TextOverflow.ellipsis,
      //       ),
      //     )).toList(),
      //     value: currentSelectedCompanyNameId,
      //     onChanged: (value) {
      //       setState(() {
      //         currentSelectedCompanyNameId = value as String;
      //       });
      //     },
      //     icon: Padding(
      //       padding: const EdgeInsets.only(left: 0, top: 5),
      //       child: SvgPicture.asset(
      //         "assets/images/ic_drop_down_arrow.svg",
      //         fit: BoxFit.contain,
      //         allowDrawingOutsideViewBox: true,
      //         width: 5,
      //         height: 5,
      //         color: CustomColors.blackColor,
      //       ),
      //     ),
      //     buttonHeight: 50,
      //     buttonPadding: const EdgeInsets.only(left: 14, right: 14),
      //     buttonDecoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(25),
      //       border: Border.all(
      //         // color: CustomColors.borderColor,
      //           color:  CustomColors.borderColor,
      //           width: 1.0),
      //       color: Colors.white,
      //     ),
      //     buttonElevation: 0,
      //     itemHeight: 40,
      //     dropdownMaxHeight: 200,
      //     dropdownPadding: const EdgeInsets.only(left: 14, right: 14),
      //     dropdownDecoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(14),
      //       color: Colors.white,
      //     ),
      //     dropdownElevation: 8,
      //     offset: const Offset(0, 0),
      //   ),
      // ),
    );
  }


}
