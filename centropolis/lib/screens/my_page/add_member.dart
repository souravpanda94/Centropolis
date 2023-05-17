import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_button_with_border.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

enum Gender { male, female }

class _AddMemberState extends State<AddMember> {
  bool isChecked = false;
  Gender? gender = Gender.male;
  String genderValue = "";
  String? companySelectedValue;
  String? floorSelectedValue;

  TextEditingController consentController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController verifyPasswordController = TextEditingController();
  TextEditingController emailIDController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();

  List<dynamic> list = [
    {"company": "CBRE", "floor": "12F"},
    {"company": "ABC", "floor": "13F"},
    {"company": "XYZ", "floor": "14F"},
    {"company": "PQR", "floor": "15F"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("addMember"), false, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 40),
        child: SingleChildScrollView(
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
                                color: CustomColors.headingColor, fontSize: 12))
                      ]),
                  maxLines: 1,
                ),
              ),
              tenantCompanyDropdownWidget(),
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
                                color: CustomColors.headingColor, fontSize: 12))
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
                          fontFamily: 'Bold',
                          fontSize: 14,
                          color: CustomColors.textColor8),
                      children: const [
                        TextSpan(
                            text: ' *',
                            style: TextStyle(
                                color: CustomColors.headingColor, fontSize: 12))
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
                  hintText: tr('employeeNameHint'),
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
                margin: const EdgeInsets.only(top: 16, bottom: 8),
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
                                color: CustomColors.headingColor, fontSize: 12))
                      ]),
                  maxLines: 1,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: idController,
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
                        hintText: tr('employeeIDHint'),
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
                    buttonBorderColor: CustomColors.buttonBackgroundColor,
                    buttonTextColor: CustomColors.buttonBackgroundColor,
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
                          fontFamily: 'Bold',
                          fontSize: 14,
                          color: CustomColors.textColor8),
                      children: const [
                        TextSpan(
                            text: ' *',
                            style: TextStyle(
                                color: CustomColors.headingColor, fontSize: 12))
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
                margin: const EdgeInsets.only(top: 16, bottom: 8),
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
                                color: CustomColors.headingColor, fontSize: 12))
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
                margin: const EdgeInsets.only(top: 16, bottom: 8),
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
                                color: CustomColors.headingColor, fontSize: 12))
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
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 8),
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
                                color: CustomColors.headingColor, fontSize: 12))
                      ]),
                  maxLines: 1,
                ),
              ),
              TextField(
                controller: contactNoController,
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
                        color: CustomColors.dividerGreyColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                        color: CustomColors.dividerGreyColor, width: 1.0),
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
                margin: const EdgeInsets.only(top: 16, bottom: 8),
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
                                color: CustomColors.headingColor, fontSize: 12))
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
                            activeColor: CustomColors.buttonBackgroundColor,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: Gender.male,
                            groupValue: gender,
                            onChanged: (Gender? value) {
                              setState(() {
                                gender = value;
                                if (gender == Gender.male) {
                                  genderValue = "Male";
                                } else {
                                  genderValue = "Female";
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
                            activeColor: CustomColors.buttonBackgroundColor,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: Gender.female,
                            groupValue: gender,
                            onChanged: (Gender? value) {
                              setState(() {
                                gender = value;
                                if (gender == Gender.male) {
                                  genderValue = "Male";
                                } else {
                                  genderValue = "Female";
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
                    onCommonButtonTap: () {},
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
        items: list
            .map((item) => DropdownMenuItem<String>(
                  value: item["company"],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 16),
                        child: Text(
                          item["company"],
                          style: const TextStyle(
                            color: CustomColors.blackColor,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ))
            .toList(),
        value: companySelectedValue,
        onChanged: (value) {
          setState(() {
            companySelectedValue = value as String;
          });
        },
        dropdownStyleData: DropdownStyleData(
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
          padding:
              EdgeInsets.only(bottom: companySelectedValue != null ? 16 : 0),
          child: SvgPicture.asset(
            "assets/images/ic_drop_down_arrow.svg",
            width: 8,
            height: 8,
            color: CustomColors.textColorBlack2,
          ),
        )),
        buttonStyleData: ButtonStyleData(
            height: 53,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColors.dividerGreyColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            padding: EdgeInsets.only(
                top: 16,
                right: 16,
                left: companySelectedValue != null ? 0 : 16,
                bottom: companySelectedValue != null ? 0 : 16),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.all(0),
          height: 53,
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
        items: list
            .map((item) => DropdownMenuItem<String>(
                  value: item["floor"],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 16),
                        child: Text(
                          item["floor"],
                          style: const TextStyle(
                            color: CustomColors.blackColor,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.grey,
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
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              border: Border.all(
                color: CustomColors.dividerGreyColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
        ),
        iconStyleData: IconStyleData(
            icon: Padding(
          padding: EdgeInsets.only(bottom: floorSelectedValue != null ? 16 : 0),
          child: SvgPicture.asset(
            "assets/images/ic_drop_down_arrow.svg",
            width: 8,
            height: 8,
            color: CustomColors.textColorBlack2,
          ),
        )),
        buttonStyleData: ButtonStyleData(
            height: 53,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColors.dividerGreyColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            padding: EdgeInsets.only(
                top: 16,
                right: 16,
                left: floorSelectedValue != null ? 0 : 16,
                bottom: floorSelectedValue != null ? 0 : 16),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.all(0),
          height: 53,
        ),
      ),
    );
  }
}
