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
  TextEditingController accountStatusController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();
  bool accountStatus = false, accountType = false;

  List<dynamic> accountStatusList = [
    "Approved",
    "Denied",
    "Suspended",
    "Reactivate",
  ];
  List<dynamic> accountTypeList = [
    "Member",
    "Conference Room Manager",
    "Executive Lounge Manager",
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
                  TextField(
                    controller: accountStatusController,
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
                        hintText: tr('approved'),
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
                        accountStatus = true;
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
                          TextField(
                            controller: accountTypeController,
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
                                hintText: "Member",
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
                                accountType = true;
                              });
                            },
                          ),
                          Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(
                                        top: 32, bottom: 16),
                                    child: CommonButton(
                                        onCommonButtonTap: () {},
                                        buttonColor:
                                            CustomColors.buttonBackgroundColor,
                                        buttonName: tr("save"),
                                        isIconVisible: false),
                                  ),
                                  CommonButtonWithBorder(
                                    onCommonButtonTap: () {},
                                    buttonBorderColor:
                                        CustomColors.dividerGreyColor,
                                    buttonName: tr("before"),
                                    buttonTextColor: CustomColors.textColor5,
                                  ),
                                ],
                              ),
                              if (accountType)
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
                                      children: List.generate(3, (index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  accountType = false;
                                                  accountTypeController.text =
                                                      accountTypeList[index];
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Text(
                                                  accountTypeList[index],
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
                      if (accountStatus)
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          accountStatus = false;
                                          accountStatusController.text =
                                              accountStatusList[index];
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        child: Text(
                                          accountStatusList[index],
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
}
