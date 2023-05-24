import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_button_with_border.dart';
import '../../widgets/common_modal.dart';

class RegisteredEmployeeDetails extends StatefulWidget {
  const RegisteredEmployeeDetails({super.key});

  @override
  State<RegisteredEmployeeDetails> createState() =>
      _RegisteredEmployeeDetailsState();
}

class _RegisteredEmployeeDetailsState extends State<RegisteredEmployeeDetails> {
  String? statusSelectedValue, typeSelectedValue;

  List<dynamic> list = [
    {
      "status": "Approved",
      "type": "Member",
    },
    {
      "status": "Denied",
      "type": "Conference Room Manager",
    },
    {
      "status": "Suspended",
      "type": "Executive Lounge Manager",
    },
    {
      "status": "Reactivate",
      "type": "Members",
    }
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
            child: CommonAppBar(tr("registeredEmployeeList"), false, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: Container(
        color: CustomColors.whiteColor,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tr("employeeDetails"),
                  style: const TextStyle(
                      fontFamily: 'SemiBold',
                      fontSize: 16,
                      color: CustomColors.textColor8),
                ),
                InkWell(
                  onTap: () {
                    showModal(tr("deleteTitle"), tr("deleteDesc"), "");
                  },
                  child: Text(
                    tr("delete"),
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: 'Regular',
                        fontSize: 12,
                        color: CustomColors.textColor3),
                  ),
                ),
              ],
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
                  Text(
                    tr("name"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 14,
                        color: CustomColors.textColor8),
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
                  Text(
                    tr("IDHeading"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 14,
                        color: CustomColors.textColor8),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "test1",
                    style: TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 14,
                        color: CustomColors.textColorBlack2),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    tr("email"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 14,
                        color: CustomColors.textColor8),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "test1@centropolis.com",
                    style: TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 14,
                        color: CustomColors.textColorBlack2),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    tr("contactNo"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 14,
                        color: CustomColors.textColor8),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "010-0000-0000",
                    style: TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 14,
                        color: CustomColors.textColorBlack2),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    tr("tenantCompany"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 14,
                        color: CustomColors.textColor8),
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
                  Text(
                    tr("registrationDate"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 14,
                        color: CustomColors.textColor8),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "2023.00.00",
                    style: TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 14,
                        color: CustomColors.textColorBlack2),
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
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: CustomColors.whiteColor,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("accountStatus"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 14,
                        color: CustomColors.textColor8),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  accountStatusWidget(),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    tr("accountType"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 14,
                        color: CustomColors.textColor8),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  accountTypeWidget(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 32, bottom: 16),
                    child: CommonButton(
                        onCommonButtonTap: () {},
                        buttonColor: CustomColors.buttonBackgroundColor,
                        buttonName: tr("save"),
                        isIconVisible: false),
                  ),
                  CommonButtonWithBorder(
                    onCommonButtonTap: () {},
                    buttonBorderColor: CustomColors.dividerGreyColor,
                    buttonName: tr("before"),
                    buttonTextColor: CustomColors.textColor5,
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  void showModal(heading, desc, btnName) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: heading,
            description: desc,
            buttonName: btnName,
            firstButtonName: btnName.toString().isEmpty ? tr("cancel") : "",
            secondButtonName: btnName.toString().isEmpty ? tr("confirm") : "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
            },
            onFirstBtnTap: () {
              Navigator.pop(context);
            },
            onSecondBtnTap: () {
              Navigator.pop(context);

              showModal(tr("deleteSuccessful"), tr("deleted"), tr("check"));
            },
          );
        });
  }

  accountStatusWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          tr('approved'),
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: list
            .map((item) => DropdownMenuItem<String>(
                  value: item["status"],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 16),
                        child: Text(
                          item["status"],
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
        value: statusSelectedValue,
        onChanged: (value) {
          setState(() {
            statusSelectedValue = value as String;
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
              EdgeInsets.only(bottom: statusSelectedValue != null ? 16 : 0),
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
                left: statusSelectedValue != null ? 0 : 16,
                bottom: statusSelectedValue != null ? 0 : 16),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.all(0),
          height: 53,
        ),
      ),
    );
  }

  accountTypeWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: const Text(
          "Member",
          style: TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: list
            .map((item) => DropdownMenuItem<String>(
                  value: item["type"],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 16),
                        child: Text(
                          item["type"],
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
        value: typeSelectedValue,
        onChanged: (value) {
          setState(() {
            typeSelectedValue = value as String;
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
          padding: EdgeInsets.only(bottom: typeSelectedValue != null ? 16 : 0),
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
                left: typeSelectedValue != null ? 0 : 16,
                bottom: typeSelectedValue != null ? 0 : 16),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.all(0),
          height: 53,
        ),
      ),
    );
  }
}
