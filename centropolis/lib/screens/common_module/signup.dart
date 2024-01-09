import 'dart:convert';
import 'dart:io';
import 'package:centropolis/widgets/common_button.dart';
import 'package:centropolis/widgets/common_button_with_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:loading_overlay/loading_overlay.dart';
import 'package:remove_emoji_input_formatter/remove_emoji_input_formatter.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_modal.dart';
import 'login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignupScreenState();
  }
}

enum Gender { male, female }

class _SignupScreenState extends State<SignupScreen> {
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
  // String personalInfomationContent = "";
  List<dynamic> companyList = [];
  List<dynamic> floorList = [];
  String? currentSelectedCompanyNameId;
  String? currentSelectedFloor;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    loadCompanyList();
    setPlatform();
    // loadPersonalInformation();
  }

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    // companyListItem = Provider.of<CompanyProvider>(context).getCompanyList;

    return GestureDetector(
      onTap: () => hideKeyboard(),
      child: LoadingOverlay(
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
                child: CommonAppBar(tr("signUpHeading"), false, () {
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("signUpConsent"),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 16,
                              color: CustomColors.textColor8),
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
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                // personalInfomationContent,
                                tr("signup_personal_info"),
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    height: 1.5,
                                    color: CustomColors.textColor3),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5, left: 2),
                              child: SizedBox(
                                height: 15,
                                width: 15,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: Checkbox(
                                    checkColor: CustomColors.whiteColor,
                                    activeColor:
                                        CustomColors.buttonBackgroundColor,
                                    side: const BorderSide(
                                        color: CustomColors.greyColor,
                                        width: 1),
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
                            ),
                            const SizedBox(
                              width: 9,
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: language == "ko" ? 4 : 3),
                                child: Text(
                                  tr("signUpConsentConfirmation"),
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColorBlack2),
                                ),
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
                        margin: const EdgeInsets.only(top: 24, bottom: 6),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(tr("tenantCompany"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8)),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: Text(" *",
                                  style: TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.headingColor)),
                            ),
                          ],
                        ),
                      ),
                      companyNameFieldWidget(),
                      Container(
                        margin: const EdgeInsets.only(top: 14, bottom: 6),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(tr("floor"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8)),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: Text(" *",
                                  style: TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.headingColor)),
                            ),
                          ],
                        ),
                      ),
                      floorFieldWidget(),
                      Container(
                        margin: const EdgeInsets.only(top: 14, bottom: 6),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(tr("name"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8)),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: Text(" *",
                                  style: TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.headingColor)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 46,
                        child: TextField(
                          maxLines: 1,
                          maxLength:100,
                          inputFormatters: [RemoveEmojiInputFormatter()],
                          // inputFormatters: [
                          //    FilteringTextInputFormatter.allow(
                          //           RegExp("[a-zA-Z_\\s-]")),
                          // ],
                          controller: nameController,
                          cursorColor: CustomColors.textColorBlack2,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: CustomColors.whiteColor,
                            filled: true,
                            contentPadding: const EdgeInsets.only(left: 16,right: 16),
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
                            hintText: tr('nameHint'),
                            hintStyle: const TextStyle(
                              height: 1.5,
                              color: CustomColors.textColor3,
                              fontSize: 14,
                              fontFamily: 'Regular',
                            ),
                          ),
                          style: const TextStyle(
                            height: 1.5,
                            color: CustomColors.blackColor,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 14, bottom: 6),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("IDHeading"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          )),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 46,
                              child: TextField(
                                maxLines: 1,
                                inputFormatters: [RemoveEmojiInputFormatter()],
                                controller: idController,
                                maxLength: 16,
                                cursorColor: CustomColors.textColorBlack2,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  fillColor: CustomColors.whiteColor,
                                  filled: true,
                                  contentPadding: const EdgeInsets.only(left: 16,right: 16),
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
                                  hintText: tr('IDHint'),
                                  hintStyle: const TextStyle(
                                    height: 1.5,
                                    color: CustomColors.textColor3,
                                    fontSize: 14,
                                    fontFamily: 'Regular',
                                  ),
                                ),
                                style: const TextStyle(
                                  height: 1.5,
                                  color: CustomColors.blackColor,
                                  fontSize: 14,
                                  fontFamily: 'Regular',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            height: 46,
                            child: CommonButtonWithBorder(
                              onCommonButtonTap: () {
                                callVerifyUserId();
                              },
                              buttonName: tr("verify"),
                              buttonBorderColor:
                                  CustomColors.buttonBackgroundColor,
                              buttonTextColor:
                                  CustomColors.buttonBackgroundColor,
                            ),
                          )
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 14, bottom: 6),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("passwordHeading"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 46,
                        child: TextField(
                          maxLines: 1,
                          maxLength: 16,
                          inputFormatters: [RemoveEmojiInputFormatter()],
                          controller: passwordController,
                          cursorColor: CustomColors.textColorBlack2,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            fillColor: CustomColors.whiteColor,
                            filled: true,
                            contentPadding: const EdgeInsets.only(left: 16,right: 16),
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
                            hintText: tr('passwordHint'),
                            hintStyle: const TextStyle(
                              height: 1.5,
                              color: CustomColors.textColor3,
                              fontSize: 14,
                              fontFamily: 'Regular',
                            ),
                          ),
                          style: const TextStyle(
                            height: 1.5,
                            color: CustomColors.blackColor,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 14, bottom: 6),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("verifyPassword"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 46,
                        child: TextField(
                          maxLines: 1,
                          maxLength: 16,
                          inputFormatters: [RemoveEmojiInputFormatter()],
                          controller: verifyPasswordController,
                          cursorColor: CustomColors.textColorBlack2,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            fillColor: CustomColors.whiteColor,
                            filled: true,
                            contentPadding: const EdgeInsets.only(left: 16,right: 16),
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
                            hintText: tr('verifyPasswordHint'),
                            hintStyle: const TextStyle(
                              height: 1.5,
                              color: CustomColors.textColor3,
                              fontSize: 14,
                              fontFamily: 'Regular',
                            ),
                          ),
                          style: const TextStyle(
                            color: CustomColors.blackColor,
                            fontSize: 14,
                            height: 1.5,
                            fontFamily: 'Regular',
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 14, bottom: 6),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("email"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 46,
                        child: TextField(
                          maxLines: 1,
                          maxLength:100,
                          inputFormatters: [RemoveEmojiInputFormatter()],
                          controller: emailIDController,
                          cursorColor: CustomColors.textColorBlack2,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: CustomColors.whiteColor,
                            filled: true,
                            contentPadding: const EdgeInsets.only(left: 16,right: 16),
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
                            hintText: tr('emailDemoHint'),
                            hintStyle: const TextStyle(
                              color: CustomColors.textColor3,
                              fontSize: 14,
                              height: 1.5,
                              fontFamily: 'Regular',
                            ),
                          ),
                          style: const TextStyle(
                            height: 1.5,
                            color: CustomColors.blackColor,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 14, bottom: 6),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("contactNo"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 46,
                        child: TextField(
                          maxLines: 1,
                          inputFormatters: [RemoveEmojiInputFormatter()],
                          controller: contactNoController,
                          cursorColor: CustomColors.textColorBlack2,
                          keyboardType: TextInputType.number,
                          maxLength: 11,
                          decoration: InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            fillColor: CustomColors.whiteColor,
                            filled: true,
                            contentPadding: const EdgeInsets.only(left: 16,right: 16),
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
                            hintText: tr('contactNoHint'),
                            hintStyle: const TextStyle(
                              height: 1.5,
                              color: CustomColors.textColor3,
                              fontSize: 14,
                              fontFamily: 'Regular',
                            ),
                          ),
                          style: const TextStyle(
                            height: 1.5,
                            color: CustomColors.blackColor,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 14, bottom: 6),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("gender"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          )),
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
                                        MaterialTapTargetSize.shrinkWrap,
                                    value: Gender.male,
                                    groupValue: gender,
                                    onChanged: (Gender? value) {
                                      setState(() {
                                        gender = value;
                                        if (gender == Gender.male) {
                                          genderValue = "m";
                                        } else {
                                          genderValue = "f";
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    tr("male"),
                                    style: const TextStyle(
                                        fontFamily: 'Regular',
                                        color: CustomColors.textColorBlack2,
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
                                        MaterialTapTargetSize.shrinkWrap,
                                    value: Gender.female,
                                    groupValue: gender,
                                    onChanged: (Gender? value) {
                                      setState(() {
                                        gender = value;
                                        if (gender == Gender.male) {
                                          genderValue = "m";
                                        } else {
                                          genderValue = "f";
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    tr("female"),
                                    style: const TextStyle(
                                        fontFamily: 'Regular',
                                        color: CustomColors.textColorBlack2,
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
                        margin: const EdgeInsets.only(top: 34, bottom: 16),
                        child: CommonButton(
                            onCommonButtonTap: () {
                              signUpValidation();
                            },
                            buttonColor: CustomColors.buttonBackgroundColor,
                            buttonName: tr("signUp"),
                            isIconVisible: false),
                      ),
                      CommonButtonWithBorder(
                        onCommonButtonTap: () {
                          onBackButtonPress(context);
                        },
                        buttonBorderColor: CustomColors.dividerGreyColor,
                        buttonName: tr("cancel"),
                        buttonTextColor: CustomColors.textColor5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(top: 24, bottom: 20),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset("assets/images/ic_warning.svg"),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  tr("warning"),
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      color: CustomColors.textColorBlack2,
                                      height: 1.5,
                                      fontSize: 12),
                                ),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
              ],
            )),
          ),
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
            heading: title,
            description: message,
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
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
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
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
            debugPrint("Server error response ${responseJson['message']}");
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
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
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callLoadFloorListApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {
      "company_id": currentSelectedCompanyNameId.toString().trim(),
    };

    debugPrint("Floor List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getFloorListUrl, body, language.toString(), null);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Floor List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              floorList = responseJson['data'];
            });
          }
        } else {
          if (responseJson['message'] != null) {
            debugPrint("Server error response ${responseJson['message']}");
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  void callVerifyUserId() async {
    if (idController.text.trim().isEmpty) {
      showErrorModal(tr("pleaseEnterYourId"));
    } else if (!isValidUserId(idController.text.trim())) {
      showErrorModal(tr("onlyValidIdIsAllowed"));
    } else {
      hideKeyboard();
      final InternetChecking internetChecking = InternetChecking();
      if (await internetChecking.isInternet()) {
        callVerifyUserIdApi();
      } else {
        //showCustomToast(fToast, context, tr("noInternetConnection"), "");
        showErrorCommonModal(
            context: context,
            heading: tr("noInternet"),
            description: tr("connectionFailedDescription"),
            buttonName: tr("check"));
      }
    }
  }

  void callVerifyUserIdApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "username": idController.text.trim().replaceAll(' ', '')
    };

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
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          }
        } else {
          if (responseJson['message'] != null) {
            debugPrint("Server error response ${responseJson['message']}");
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  // void loadPersonalInformation() async {
  //   final InternetChecking internetChecking = InternetChecking();
  //   if (await internetChecking.isInternet()) {
  //     callLoadPersonalInformationApi();
  //   } else {
  //     showCustomToast(fToast, context, tr("noInternetConnection"), "");
  //   }
  // }
  //
  // void callLoadPersonalInformationApi() {
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   Map<String, String> body = {
  //     "cms_key": "signup_terms",
  //   };
  //
  //   debugPrint("get Personal Information input ===> $body");
  //
  //   Future<http.Response> response = WebService().callPostMethodWithRawData(
  //       ApiEndPoint.getPersonalInformationUrl, body, language.toString(), null);
  //   response.then((response) {
  //     var responseJson = json.decode(response.body);
  //
  //     debugPrint(
  //         "server response for get Personal Information ===> $responseJson");
  //
  //     if (responseJson != null) {
  //       if (response.statusCode == 200 && responseJson['success']) {
  //         if (language == "en") {
  //           if (responseJson['description_en'] != null) {
  //             setState(() {
  //               personalInfomationContent =
  //                   responseJson['description_en'].toString();
  //             });
  //           }
  //         } else {
  //           if (responseJson['description_ko'] != null) {
  //             setState(() {
  //               personalInfomationContent =
  //                   responseJson['description_ko'].toString();
  //             });
  //           }
  //         }
  //       } else {
  //         if (responseJson['message'] != null) {
  //           showCustomToast(
  //               fToast, context, responseJson['message'].toString(), "");
  //         }
  //       }
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   }).catchError((onError) {
  //     debugPrint("catchError ================> $onError");
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  // }

  Widget companyNameFieldWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          tr('tenantCompanyHint'),
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: companyList
            .map(
              (item) => DropdownMenuItem<String>(
                value: item["company_id"].toString(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 9),
                      child: Text(
                        item["company_name"],
                        style: const TextStyle(
                          color: CustomColors.blackColor,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    if (item != companyList.last)
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: CustomColors.dividerGreyColor,
                      )
                  ],
                ),
                // onTap: () {
                //   if (item["value"] == "manual") {
                //     startTimeSelectedValue = null;
                //     endTimeSelectedValue = null;
                //   } else {
                //     setState(() {
                //       startTimeSelectedValue = item["start_time"];
                //       endTimeSelectedValue = item["end_time"];
                //     });
                //   }
                // },
              ),
            )
            .toList(),
        value: currentSelectedCompanyNameId,
        onChanged: (value) {
          setState(() {
            currentSelectedCompanyNameId = value as String;
            currentSelectedFloor = null;
          });
          loadFloorList();
        },
        dropdownStyleData: DropdownStyleData(
          padding: const EdgeInsets.only(top: 0, bottom: 0),
          maxHeight: 200,
          isOverButton: false,
          elevation: 0,
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              border: Border.all(
                color: CustomColors.dividerGreyColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
        ),
        iconStyleData: IconStyleData(
            icon: Padding(
          padding: EdgeInsets.only(
              bottom: currentSelectedCompanyNameId != null ? 12 : 0),
          child: SvgPicture.asset(
            "assets/images/ic_drop_down_arrow.svg",
            width: 8,
            height: 8,
            color: CustomColors.textColorBlack2,
          ),
        )),
        buttonStyleData: ButtonStyleData(
            height: 46,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColors.dividerGreyColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            padding: EdgeInsets.only(
                top: 10,
                right: 12,
                left: currentSelectedCompanyNameId != null ? 0 : 13,
                bottom: currentSelectedCompanyNameId != null ? 0 : 11),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          overlayColor:
              MaterialStatePropertyAll(CustomColors.dropdownHoverColor),
          padding: EdgeInsets.only(top: 14),
          height: 46,
        ),
      ),
    );
  }

  Widget floorFieldWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          tr('floorHint'),
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: floorList
            .map(
              (item) => DropdownMenuItem<String>(
                value: item["floor"],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 9),
                      child: Text(
                        item["floor"],
                        style: const TextStyle(
                          color: CustomColors.blackColor,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    if (item != floorList.last)
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: CustomColors.dividerGreyColor,
                      )
                  ],
                ),
              ),
            )
            .toList(),
        value: currentSelectedFloor,
        onChanged: (value) {
          setState(() {
            currentSelectedFloor = value as String;
          });
        },
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          isOverButton: false,
          elevation: 0,
          padding: const EdgeInsets.only(top: 0, bottom: 0),
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              border: Border.all(
                color: CustomColors.dividerGreyColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
        ),
        iconStyleData: IconStyleData(
            icon: Padding(
          padding:
              EdgeInsets.only(bottom: currentSelectedFloor != null ? 12 : 0),
          child: SvgPicture.asset(
            "assets/images/ic_drop_down_arrow.svg",
            width: 8,
            height: 8,
            color: CustomColors.textColorBlack2,
          ),
        )),
        buttonStyleData: ButtonStyleData(
            height: 46,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColors.dividerGreyColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            padding: EdgeInsets.only(
                top: 10,
                right: 12,
                left: currentSelectedFloor != null ? 0 : 13,
                bottom: currentSelectedFloor != null ? 0 : 11),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          overlayColor:
              MaterialStatePropertyAll(CustomColors.dropdownHoverColor),
          padding: EdgeInsets.only(top: 14),
          height: 46,
        ),
      ),
    );
  }

  void signUpValidation() {
    hideKeyboard();
    if (currentSelectedCompanyNameId?.trim() == null ||
        currentSelectedCompanyNameId?.trim() == "") {
      showErrorModal(tr("pleaseSelectCompany"));
    } else if (currentSelectedFloor?.trim() == null ||
        currentSelectedFloor?.trim() == "") {
      showErrorModal(tr("pleaseSelectFloor"));
    } else if (nameController.text.trim().isEmpty) {
      showErrorModal(tr("pleaseEnterYourName"));
    } else if (idController.text.trim().isEmpty) {
      showErrorModal(tr("pleaseEnterYourId"));
    } else if (!isValidUserId(idController.text.trim())) {
      showErrorModal(tr("onlyValidIdIsAllowed"));
    } else if (!isUserIdVerified) {
      showErrorModal(tr("yourIdIsNotVerified"));
    } else if (passwordController.text.trim().isEmpty) {
      showErrorModal(tr("pleaseEnterPassword"));
    } else if (!isValidPassword(passwordController.text.trim())) {
      showErrorModal(tr("onlyValidPasswordIsAllowed"));
    } else if (verifyPasswordController.text.trim().isEmpty) {
      showErrorModal(tr("pleaseConfirmThePassword"));
    } else if (!isValidPassword(verifyPasswordController.text.trim())) {
      showErrorModal(tr("pleaseConfirmThePassword"));
    } else if (verifyPasswordController.text.trim() !=
        passwordController.text.trim()) {
      showErrorModal(tr("youHaveEnteredDifferentPassword"));
    } else if (emailIDController.text.trim().isEmpty) {
      showErrorModal(tr("emailValidation"));
    } else if (!isValidEmail(emailIDController.text.trim())) {
      showErrorModal(tr("onlyValidEmailIsApplicable"));
    } else if (contactNoController.text.trim().isEmpty) {
      showErrorModal(tr("contactValidation"));
    } else if (!isValidPhoneNumber(contactNoController.text.trim()) ||
        !contactNoController.text.trim().startsWith("010")) {
      showErrorModal(tr("onlyValidContactInformationIsApplicable"));
    } else if (genderValue.trim().isEmpty) {
      showErrorModal(tr("pleaseSelectGender"));
    } else if (!isChecked) {
      showErrorModal(tr("pleaseConsentToCollect"));
    } else {
      callSignupNetworkCheck();
    }
  }

  void showErrorModal(String heading) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: heading,
            description: "",
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

  void callSignupNetworkCheck() async {
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callSignUpApi();
    } else {
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callSignUpApi() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> body = {
      "company_id": currentSelectedCompanyNameId.toString().trim(),
      "floor": currentSelectedFloor.toString().trim(),
      "name": nameController.text.trim(),
      "username": idController.text.trim(),
      "password": passwordController.text.trim(),
      "confirm_password": verifyPasswordController.text.trim(),
      "email": emailIDController.text.trim(),
      "mobile": contactNoController.text.trim(),
      "gender": genderValue.trim(),
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
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
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
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }
}
