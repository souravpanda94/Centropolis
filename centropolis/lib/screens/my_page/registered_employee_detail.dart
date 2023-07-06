import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/employee_detail_model.dart';
import '../../providers/employee_detail_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_button_with_border.dart';
import '../../widgets/common_modal.dart';

class RegisteredEmployeeDetails extends StatefulWidget {
  final String id;
  const RegisteredEmployeeDetails({super.key, required this.id});

  @override
  State<RegisteredEmployeeDetails> createState() =>
      _RegisteredEmployeeDetailsState();
}

class _RegisteredEmployeeDetailsState extends State<RegisteredEmployeeDetails> {
  String? statusSelectedValue;
  String? typeSelectedValue;
  late String language, apiKey, email, mobile, name, companyName;
  bool isLoading = false;
  late FToast fToast;
  List<dynamic> accountStatusList = [];
  List<dynamic> accountTypeList = [];
  EmployeeDetailModel? employeeDetails;
  bool isLoadingRequired = false;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    email = user.userData['email_key'].toString();
    mobile = user.userData['mobile'].toString();
    name = user.userData['user_name'].toString();
    companyName = user.userData['company_name'].toString();
    loadAccountStatusList();
    loadAccountTypeList();
    loadEmployeeDetails();
  }

  @override
  Widget build(BuildContext context) {
    employeeDetails =
        Provider.of<EmployeeDetailProvider>(context).getEmplloyeeDetailModel;

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
              child: CommonAppBar(tr("registeredEmployeeList"), false, () {
                //onBackButtonPress(context);
                Navigator.pop(context, isLoadingRequired);
              }, () {}),
            ),
          ),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                color: CustomColors.whiteColor,
                padding: const EdgeInsets.all(16),
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
                      margin: const EdgeInsets.only(top: 16, bottom: 0),
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
                          Text(
                            employeeDetails?.name.toString() ?? "",
                            style: const TextStyle(
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
                          Text(
                            employeeDetails?.username.toString() ?? "",
                            style: const TextStyle(
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
                          Text(
                            employeeDetails?.email.toString() ?? "",
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            tr("contactNo").replaceAll(".", ""),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            formatNumberStringWithDash(
                                employeeDetails?.mobile.toString() ?? ""),
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            tr("tenantCompanyLounge"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            employeeDetails?.companyName.toString() ?? "",
                            style: const TextStyle(
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
                          Text(
                            employeeDetails?.registrationDate.toString() ?? "",
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                        ],
                      ),
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
                      tr("accountStatus"),
                      style: const TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 14,
                          color: CustomColors.textColor8),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    accountStatusDropdownWidget(
                        employeeDetails?.displayStatus.toString() ?? ""),
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
                    accountTypeDropdownWidget(
                        employeeDetails?.displayAccountType.toString() ?? ""),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 32, bottom: 16),
                      child: CommonButton(
                          onCommonButtonTap: () {
                            updateValidationCheck(
                                employeeDetails?.status.toString() ?? "",
                                employeeDetails?.accountType.toString() ?? "");
                          },
                          buttonColor: CustomColors.buttonBackgroundColor,
                          buttonName: tr("savebutton"),
                          isIconVisible: false),
                    ),
                    CommonButtonWithBorder(
                      onCommonButtonTap: () {
                        Navigator.pop(context);
                      },
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
              Navigator.pop(context, isLoadingRequired);
            },
            onFirstBtnTap: () {
              Navigator.pop(context);
            },
            onSecondBtnTap: () {
              callDeleteEmployeeNetworkCheck();
              Navigator.pop(context);
            },
          );
        });
  }

  accountStatusDropdownWidget(String status) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          status.toString().capitalizeByWord(),
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: accountStatusList
            .map((item) => DropdownMenuItem<String>(
                  value: item["value"],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 9),
                        child: Text(
                          item["text"].toString().capitalizeByWord(),
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
                      if (item != accountStatusList.last)
                        const Divider(
                          thickness: 1,
                          height: 1,
                          color: CustomColors.dividerGreyColor,
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
              EdgeInsets.only(bottom: statusSelectedValue != null ? 12 : 0),
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
                left: statusSelectedValue != null ? 0 : 13,
                bottom: statusSelectedValue != null ? 0 : 11),
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

  accountTypeDropdownWidget(String type) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          type.toString().capitalizeByWord(),
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: accountTypeList
            .map((item) => DropdownMenuItem<String>(
                  value: item["value"],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 9),
                        child: Text(
                          item["text"].toString().capitalizeByWord(),
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
                      if (item != accountTypeList.last)
                        const Divider(
                          thickness: 1,
                          height: 1,
                          color: CustomColors.dividerGreyColor,
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
          padding: EdgeInsets.only(bottom: typeSelectedValue != null ? 12 : 0),
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
                left: typeSelectedValue != null ? 0 : 13,
                bottom: typeSelectedValue != null ? 0 : 11),
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

  void callDeleteEmployeeNetworkCheck() async {
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callDeleteEmployeeApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callDeleteEmployeeApi() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> body = {
      "employee_id": widget.id.toString().trim(),
    };

    debugPrint("DeleteEmployee input ===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.deleteEmployeeUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for DeleteEmployee ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          setState(() {
            isLoadingRequired = true;
          });
          showModal(tr("deleteSuccessful"), tr("deleted"), tr("check"));
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

  void loadEmployeeDetails() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callEmployeeDetailsApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callEmployeeDetailsApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {"employee_id": widget.id.toString().trim()};

    debugPrint("employee details input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.employeeDetailUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for employee details ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          EmployeeDetailModel employeeDetailModel =
              EmployeeDetailModel.fromJson(responseJson);

          Provider.of<EmployeeDetailProvider>(context, listen: false)
              .setItem(employeeDetailModel);
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

  void loadAccountStatusList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callAccountStatusListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callAccountStatusListApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};
    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.accountStatusListUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              accountStatusList = responseJson['data'];
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

  void loadAccountTypeList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callAccountTypeListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callAccountTypeListApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};
    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.accountTypeListUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              accountTypeList = responseJson['data'];
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

  void updateValidationCheck(String status, String type) {
    if (statusSelectedValue == null || statusSelectedValue == "") {
      statusSelectedValue = status;
    } else if (typeSelectedValue == null || typeSelectedValue == "") {
      typeSelectedValue = type;
    } else {
      callUpdateEmployeeNetworkCheck();
    }
  }

  void callUpdateEmployeeNetworkCheck() async {
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callUpdateEmployeeApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callUpdateEmployeeApi() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> body = {
      "employee_id": widget.id.toString().trim(),
      "status": statusSelectedValue.toString().trim(),
      "account_type": typeSelectedValue.toString().trim(),
    };

    debugPrint("Update Employee input ===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.updateEmployeeUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Update Employee ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          setState(() {
            isLoadingRequired = true;
          });
          showModal(responseJson['message'].toString(), "", tr("check"));
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
}
