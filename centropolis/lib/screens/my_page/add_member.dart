import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:remove_emoji_input_formatter/remove_emoji_input_formatter.dart';

import '../../models/user_info_model.dart';
import '../../providers/user_info_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/firebase_analytics_events.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_button_with_border.dart';
import '../../widgets/common_modal.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

enum Gender { male, female }

class _AddMemberState extends State<AddMember> {
  late String language, apiKey;
  String companyName = "";
  String name = "";
  String email = "";
  String mobile = "";
  Gender? gender = Gender.male;
  String genderValue = "m";
  String? companySelectedValue;
  String? floorSelectedValue;
  bool isLoading = false;
  late FToast fToast;
  String platform = "";
  bool isUserIdVerified = false;
  List<dynamic> companyList = [];
  List<dynamic> floorList = [];
  bool isLoadingRequired = false;
  String tenantCompanyName = "";
  String tenantCompanyId = "";

  TextEditingController consentController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController verifyPasswordController = TextEditingController();
  TextEditingController emailIDController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    // email = user.userData['email_key'].toString();
    // mobile = user.userData['mobile'].toString();
    // name = user.userData['user_name'].toString();
    // companyName = user.userData['company_name'].toString();

    setPlatform();
    loadPersonalInformation();

    //loadCompanyList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: GestureDetector(
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
                  child: CommonAppBar(tr("addMember"), false, () {
                    //onBackButtonPress(context);
                    Navigator.pop(context, isLoadingRequired);
                  }, () {}),
                ),
              ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 40),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tr("enterEmployeeDetails"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
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
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                            children: const [
                              TextSpan(
                                  //text: ' *',
                                  style: TextStyle(
                                      color: CustomColors.headingColor,
                                      fontSize: 12))
                            ]),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                        height: 46,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                            color: CustomColors.backgroundColor,
                            border: Border.all(
                              color: CustomColors.dividerGreyColor,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
                        child: Center(
                            child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            tenantCompanyName,
                            style: const TextStyle(
                              color: CustomColors.blackColor,
                              fontSize: 14,
                              fontFamily: 'Regular',
                            ),
                          ),
                        ))),
                    //tenantCompanyDropdownWidget(),

                    Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 8),
                      width: MediaQuery.of(context).size.width,
                      child: RichText(
                        text: TextSpan(
                            text: tr("floor"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                            children: const [
                              TextSpan(
                                  //text: ' *',
                                  style: TextStyle(
                                      color: CustomColors.headingColor,
                                      fontSize: 12))
                            ]),
                        maxLines: 1,
                      ),
                    ),
                    floorDropdownWidget(),
                    Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 8),
                      width: MediaQuery.of(context).size.width,
                      child: RichText(
                        text: TextSpan(
                            text: tr("name"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                            children: const [
                              TextSpan(
                                  //text: ' *',
                                  style: TextStyle(
                                      color: CustomColors.headingColor,
                                      fontSize: 12))
                            ]),
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 46,
                      child: TextField(
                        inputFormatters: [
                                RemoveEmojiInputFormatter()
                              ],
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.allow(
                        //       RegExp("[a-zA-Z_\\s-]")),
                        // ],
                        maxLines: 1,
                        maxLength:100,
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
                          hintText: tr('employeeNameHint'),
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
                      margin: const EdgeInsets.only(top: 16, bottom: 8),
                      width: MediaQuery.of(context).size.width,
                      child: RichText(
                        text: TextSpan(
                            text: tr("IDHeading"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                            children: const [
                              TextSpan(
                                  //text: ' *',
                                  style: TextStyle(
                                      color: CustomColors.headingColor,
                                      fontSize: 12))
                            ]),
                        maxLines: 1,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 46,
                            child: TextField(
                              inputFormatters: [
                                RemoveEmojiInputFormatter()
                              ],
                              maxLines: 1,
                              maxLength: 16,
                              controller: idController,
                              cursorColor: CustomColors.textColorBlack2,
                              keyboardType: TextInputType.text,
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
                                hintText: tr('employeeIDHint'),
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
                          width: 109,
                          height: 46,
                          child: CommonButtonWithBorder(
                            onCommonButtonTap: () {
                              callVerifyUserId();
                            },
                            buttonName: tr("verify"),
                            buttonBorderColor:
                                CustomColors.buttonBackgroundColor,
                            buttonTextColor: CustomColors.buttonBackgroundColor,
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 8),
                      width: MediaQuery.of(context).size.width,
                      child: RichText(
                        text: TextSpan(
                            text: tr("passwordHeading"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                            children: const [
                              TextSpan(
                                  //text: ' *',
                                  style: TextStyle(
                                      color: CustomColors.headingColor,
                                      fontSize: 12))
                            ]),
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 46,
                      child: TextField(
                        inputFormatters: [
                                RemoveEmojiInputFormatter()
                              ],
                              maxLines: 1,
                              maxLength: 16,
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
                      margin: const EdgeInsets.only(top: 16, bottom: 8),
                      width: MediaQuery.of(context).size.width,
                      child: RichText(
                        text: TextSpan(
                            text: tr("verifyPassword"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                            children: const [
                              TextSpan(
                                  //text: ' *',
                                  style: TextStyle(
                                      color: CustomColors.headingColor,
                                      fontSize: 12))
                            ]),
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 46,
                      child: TextField(
                        inputFormatters: [
                                RemoveEmojiInputFormatter()
                              ],
                              maxLines: 1,
                              maxLength: 16,
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
                          hintText: tr('verifyAddMemberPasswordHint'),
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
                      margin: const EdgeInsets.only(top: 16, bottom: 8),
                      width: MediaQuery.of(context).size.width,
                      child: RichText(
                        text: TextSpan(
                            text: tr("email"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                            children: const [
                              TextSpan(
                                  //text: ' *',
                                  style: TextStyle(
                                      color: CustomColors.headingColor,
                                      fontSize: 12))
                            ]),
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 46,
                      child: TextField(
                        inputFormatters: [
                                RemoveEmojiInputFormatter()
                              ],
                              maxLength:100,
                        controller: emailIDController,
                        cursorColor: CustomColors.textColorBlack2,
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 1,
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
                      margin: const EdgeInsets.only(top: 16, bottom: 8),
                      width: MediaQuery.of(context).size.width,
                      child: RichText(
                        text: TextSpan(
                            text: tr("contactNo").replaceAll(".", ""),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                            children: const [
                              TextSpan(
                                  //text: ' *',
                                  style: TextStyle(
                                      color: CustomColors.headingColor,
                                      fontSize: 12))
                            ]),
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 46,
                      child: TextField(
                        inputFormatters: [
                                RemoveEmojiInputFormatter()
                              ],
                        controller: contactNoController,
                        cursorColor: CustomColors.textColorBlack2,
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        maxLines: 1,
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
                      margin: const EdgeInsets.only(top: 16, bottom: 8),
                      width: MediaQuery.of(context).size.width,
                      child: RichText(
                        text: TextSpan(
                            text: tr("gender"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                            children: const [
                              TextSpan(
                                  // text: ' *',
                                  style: TextStyle(
                                      color: CustomColors.headingColor,
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
                            addMemberValidation();
                          },
                          buttonColor: CustomColors.buttonBackgroundColor,
                          buttonName: tr("save"),
                          isIconVisible: false),
                    ),
                    CommonButtonWithBorder(
                      onCommonButtonTap: () {
                        Navigator.pop(context);
                      },
                      buttonBorderColor: CustomColors.dividerGreyColor,
                      buttonName: tr("before"),
                      buttonTextColor: CustomColors.textColor5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  tenantCompanyDropdownWidget() {
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
            .map((item) => DropdownMenuItem<String>(
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
                ))
            .toList(),
        value: companySelectedValue,
        onChanged: (value) {
          setState(() {
            companySelectedValue = value as String;
            floorSelectedValue = null;
          });
          loadFloorList();
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
              EdgeInsets.only(bottom: companySelectedValue != null ? 12 : 0),
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
                left: companySelectedValue != null ? 0 : 13,
                bottom: companySelectedValue != null ? 0 : 11),
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

  floorDropdownWidget() {
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
            .map((item) => DropdownMenuItem<String>(
                  value: item["floor"],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 9),
                        child: Text(
                          item["floor"].toString().toUpperCase(),
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
                ))
            .toList(),
        value: floorSelectedValue,
        onChanged: (value) {
          setState(() {
            floorSelectedValue = value as String;
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
          padding: EdgeInsets.only(bottom: floorSelectedValue != null ? 12 : 0),
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
                left: floorSelectedValue != null ? 0 : 13,
                bottom: floorSelectedValue != null ? 0 : 11),
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
      "company_id": tenantCompanyId.toString().trim(),
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
    hideKeyboard();
    if (idController.text.trim().isEmpty) {
      showErrorModal(tr("pleaseEnterYourId"));
    } else if (!isValidUserId(idController.text.trim())) {
      showErrorModal(tr("onlyValidIdIsAllowed"));
    } else {
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

  void addMemberValidation() {
    hideKeyboard();
    if (tenantCompanyName == "") {
      showErrorModal(tr("pleaseSelectCompany"));
    } else if (floorSelectedValue == null || floorSelectedValue == "") {
      showErrorModal(tr("pleaseSelectFloor"));
    } else if (nameController.text.trim() == "") {
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
      showErrorModal(tr("onlyValidPasswordIsAllowed"));
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
    } else if (genderValue == "") {
      showErrorModal(tr("pleaseSelectGender"));
    } else {
      callAddMemberNetworkCheck();
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

  void callAddMemberNetworkCheck() async {
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callAddMemberApi();
    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callAddMemberApi() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> body = {
      "name": nameController.text.trim(),
      "username": idController.text.trim(),
      "mobile": contactNoController.text.trim(),
      "email": emailIDController.text.trim(),
      "gender": genderValue.trim(),
      "password": passwordController.text.trim(),
      "confirm_password": verifyPasswordController.text.trim(),
      "platform": platform,
      "floor": floorSelectedValue.toString().trim(),
      //"ip_address": "49.36.221.206"
    };

    debugPrint("add member input ===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.addMemberUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for add member ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          setState(() {
            isLoadingRequired = true;
          });
          nameController.clear();
          consentController.clear();
          idController.clear();
          passwordController.clear();
          verifyPasswordController.clear();
          emailIDController.clear();
          contactNoController.clear();

          showAddMemberSuccessModal(responseJson['message'].toString());
          setFirebaseEventForAddDeleteEmployee(
              eventName: "cp_add_employee",
              memberId: responseJson['employee_id'] ?? "");
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

  void showAddMemberSuccessModal(String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: message,
            description: "",
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
              Navigator.pop(context, isLoadingRequired);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  void loadPersonalInformation() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadPersonalInformationApi();
    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callLoadPersonalInformationApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};

    debugPrint("Get personal info input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getPersonalInfoUrl, body, language, apiKey.trim());
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Get personal info ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          UserInfoModel userInfoModel = UserInfoModel.fromJson(responseJson);
          Provider.of<UserInfoProvider>(context, listen: false)
              .setItem(userInfoModel);
          setState(() {
            tenantCompanyName = userInfoModel.companyName.toString();
            tenantCompanyId = userInfoModel.companyId.toString();
          });
          loadFloorList();
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
      setState(() {
        isLoading = false;
      });
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
}
