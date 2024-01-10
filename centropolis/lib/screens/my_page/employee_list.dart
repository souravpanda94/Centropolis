import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/employee_list_model.dart';
import '../../providers/employee_list_approve_provider.dart';
import '../../providers/employee_list_before_approve_provider.dart';
import '../../providers/employee_list_suspended_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_button.dart';
import '../../widgets/view_more.dart';
import 'add_member.dart';
import 'registered_employee_detail.dart';

class EmployeeList extends StatefulWidget {
  final String status;
  const EmployeeList({super.key, required this.status});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 10;
  int totalPages = 0;
  int totalRecords = 0;
  bool isFirstLoadRunning = true;
  List<EmployeeListModel>? employeeListItem;
  String? currentSelectedSortingFilter;
  List<dynamic> accountTypeList = [];

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    loadAccountTypeList();
    firstTimeLoadEmployeeList();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.status == "active") {
      employeeListItem = Provider.of<EmployeeListApproveProvider>(context)
          .getEmployeeModelList;
    } else if (widget.status == "inactive") {
      employeeListItem = Provider.of<EmployeeListBeforeApproveProvider>(context)
          .getEmployeeModelList;
    } else if (widget.status == "suspended") {
      employeeListItem = Provider.of<EmployeeListSuspendedProvider>(context)
          .getEmployeeModelList;
    } else {
      employeeListItem = Provider.of<EmployeeListApproveProvider>(context)
          .getEmployeeModelList;
    }

    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.whiteColor,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isFirstLoadRunning,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Text(
                        tr("total"),
                        style: const TextStyle(
                            fontFamily: 'Medium',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          totalRecords.toString(),
                          style: const TextStyle(
                              fontFamily: 'Medium',
                              fontSize: 14,
                              color: CustomColors.textColor9),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          tr("people"),
                          style: const TextStyle(
                              fontFamily: 'Medium',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                      ),
                    ],
                  ),
                ),

                sortingDropdownWidget(),
              ],
            ),
            employeeListItem == null || employeeListItem!.isEmpty
                ? Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        tr("noDataFound"),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                            color: CustomColors.textColor5),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: employeeListItem?.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RegisteredEmployeeDetails(
                                          id: employeeListItem?[index].userId ??
                                              ""),
                                ),
                              ).then((value) {
                                if (value) {
                                  loadEmployeeList();
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: CustomColors.whiteColor,
                                  border: Border.all(
                                    color: CustomColors.borderColor,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4))),
                              padding: const EdgeInsets.all(16),
                              margin: EdgeInsets.only(
                                  bottom: employeeListItem?[index] !=
                                          employeeListItem?.last
                                      ? 16
                                      : 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Text(
                                          employeeListItem?[index].name ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'SemiBold',
                                              fontSize: 14,
                                              color: CustomColors.textColor8),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      if (employeeListItem != null &&
                                          employeeListItem![index]
                                              .accountType
                                              .toString()
                                              .isNotEmpty)
                                        employeeListItem![index]
                                                    .accountType
                                                    .toString() !=
                                                "tenant_employee"
                                            ? Container(
                                              decoration: BoxDecoration(
                                                color: CustomColors
                                                    .backgroundColor2,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50),
                                              ),
                                              padding:
                                                  const EdgeInsets.only(
                                                      top: 5.0,
                                                      bottom: 5.0,
                                                      left: 12.0,
                                                      right: 12.0),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/ic_logo.svg',
                                                    semanticsLabel: 'Back',
                                                    width: 15,
                                                    height: 15,
                                                    alignment:
                                                        Alignment.center,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    employeeListItem?[
                                                                index]
                                                            .displayAccountType
                                                            .toString()
                                                            .capitalizeByWord() ??
                                                        "",
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style:
                                                        const TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "Bold",
                                                      color: CustomColors
                                                          .textColor8,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                            : Container(),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${tr("registrationDate")}: ",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: 'Regular',
                                            fontSize: 12,
                                            color: CustomColors.textColor3),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        employeeListItem?[index]
                                                .registrationDate ??
                                            "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: 'Regular',
                                            fontSize: 12,
                                            color: CustomColors.textColor3),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
                  ),
            if (page < totalPages)
              ViewMoreWidget(
                onViewMoreTap: () {
                  loadMore();
                },
              ),
            CommonButton(
              onCommonButtonTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddMember(),
                  ),
                ).then((value) {
                  if (value) {
                    loadEmployeeList();
                  }
                });
              },
              buttonColor: CustomColors.buttonBackgroundColor,
              buttonName: tr("addMember"),
              isIconVisible: false,
            )
          ],
        ),
      ),
    );
  }

  void firstTimeLoadEmployeeList() {
    if (mounted) {
      setState(() {
        isFirstLoadRunning = true;
        page = 1;
      });
      if (widget.status == "active") {
        Provider.of<EmployeeListApproveProvider>(context, listen: false)
            .setEmptyList();
      } else if (widget.status == "inactive") {
        Provider.of<EmployeeListBeforeApproveProvider>(context, listen: false)
            .setEmptyList();
      } else if (widget.status == "suspended") {
        Provider.of<EmployeeListSuspendedProvider>(context, listen: false)
            .setEmptyList();
      } else {
        Provider.of<EmployeeListApproveProvider>(context, listen: false)
            .setEmptyList();
      }

      loadEmployeeList();
    }
  }

  void loadEmployeeList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callEmployeeListApi();
    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callEmployeeListApi() {
    if (mounted) {
      setState(() {
        isFirstLoadRunning = true;
      });
    }
    Map<String, String> body;
    if (currentSelectedSortingFilter != null) {
      body = {
        "page": page.toString(),
        "limit": limit.toString(),
        "status": widget.status.toString().trim(), //optional
        "account_type":
            currentSelectedSortingFilter.toString().trim(), //optional
      };
    } else {
      body = {
        "page": page.toString(),
        "limit": limit.toString(),
        "status": widget.status.toString().trim(), //optional
      };
    }

    debugPrint("Employee List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.registeredEmployeeListUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      if (mounted) {
        var responseJson = json.decode(response.body);

        debugPrint("server response for Employee List ===> $responseJson");

        if (responseJson != null) {
          if (response.statusCode == 200 && responseJson['success']) {
            totalPages = responseJson['total_pages'];
            totalRecords = responseJson['total_records'];
            List<EmployeeListModel> employeeList = List<EmployeeListModel>.from(
                responseJson['user_data']
                    .map((x) => EmployeeListModel.fromJson(x)));
            if (page == 1) {
              if (widget.status == "active") {
                Provider.of<EmployeeListApproveProvider>(context, listen: false)
                    .setItem(employeeList);
              } else if (widget.status == "inactive") {
                Provider.of<EmployeeListBeforeApproveProvider>(context,
                        listen: false)
                    .setItem(employeeList);
              } else if (widget.status == "suspended") {
                Provider.of<EmployeeListSuspendedProvider>(context,
                        listen: false)
                    .setItem(employeeList);
              } else {
                Provider.of<EmployeeListApproveProvider>(context, listen: false)
                    .setItem(employeeList);
              }
            } else {
              if (widget.status == "active") {
                Provider.of<EmployeeListApproveProvider>(context, listen: false)
                    .addItem(employeeList);
              } else if (widget.status == "inactive") {
                Provider.of<EmployeeListBeforeApproveProvider>(context,
                        listen: false)
                    .addItem(employeeList);
              } else if (widget.status == "suspended") {
                Provider.of<EmployeeListSuspendedProvider>(context,
                        listen: false)
                    .addItem(employeeList);
              } else {
                Provider.of<EmployeeListApproveProvider>(context, listen: false)
                    .addItem(employeeList);
              }
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
            isFirstLoadRunning = false;
          });
        }
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");

      if (mounted) {
        showErrorCommonModal(
            context: context,
            heading: tr("errorDescription"),
            description: "",
            buttonName: tr("check"));
        setState(() {
          isFirstLoadRunning = false;
        });
      }
    });
  }

  void loadMore() {
    if (page < totalPages) {
      setState(() {
        page++;
      });
      loadEmployeeList();
    }
  }

  sortingDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        alignment: AlignmentDirectional.centerEnd,
        style: const TextStyle(
          color: CustomColors.textColorBlack2,
          fontSize: 14,
          fontFamily: 'Medium',
        ),
        hint: Text(
          accountTypeList.isNotEmpty
              ? accountTypeList.first["text"].toString().capitalizeByWord()
              : tr('all'),
          style: const TextStyle(
            color: CustomColors.textColor5,
            fontSize: 14,
            fontFamily: 'Medium',
          ),
        ),
        items: accountTypeList
            .map(
              (item) => DropdownMenuItem<String>(
                value: item["value"],
                child: Text(
                  item["text"].toString().capitalizeByWord(),
                  style: const TextStyle(
                    color: CustomColors.textColor5,
                    fontSize: 12,
                    fontFamily: 'Medium',
                  ),
                ),
              ),
            )
            .toList(),
        value: currentSelectedSortingFilter,
        onChanged: (value) {
          setState(() {
            currentSelectedSortingFilter = value as String;
          });
          firstTimeLoadEmployeeList();
        },
        dropdownStyleData: DropdownStyleData(
          offset: const Offset(100, 0),
          width: 196,
          //maxHeight: 200,
          isOverButton: false,
          elevation: 0,
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              border: Border.all(color: CustomColors.borderColor, width: 1)),
        ),
        iconStyleData: IconStyleData(
            icon: Padding(
          padding: EdgeInsets.only(
              bottom: currentSelectedSortingFilter != null ? 6 : 0,
              top: currentSelectedSortingFilter != null ? 6 : 0,
              left: 8),
          child: SvgPicture.asset(
            "assets/images/ic_drop_down_arrow.svg",
            width: 6,
            height: 6,
            color: CustomColors.textColorBlack2,
          ),
        )),
        buttonStyleData: const ButtonStyleData(height: 35),
        menuItemStyleData: const MenuItemStyleData(
          overlayColor:
              MaterialStatePropertyAll(CustomColors.dropdownHoverColor),
          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
        ),
      ),
    );
  }

  void loadAccountTypeList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callAccountTypeListApi();
    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callAccountTypeListApi() {
    if (mounted) {
      setState(() {
        isFirstLoadRunning = true;
      });
    }
    Map<String, String> body = {};
    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.accountTypeListUrl, body, language.toString(), apiKey);
    response.then((response) {
      if (mounted) {
        var responseJson = json.decode(response.body);

        if (responseJson != null) {
          if (response.statusCode == 200 && responseJson['success']) {
            if (responseJson['data'] != null) {
              setState(() {
                accountTypeList = responseJson['data'];
                Map<dynamic, dynamic> allMap = {"text": tr("all"), "value": ""};
                accountTypeList.insert(0, allMap);
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
            isFirstLoadRunning = false;
          });
        }
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      if (mounted) {
        showErrorCommonModal(
            context: context,
            heading: tr("errorDescription"),
            description: "",
            buttonName: tr("check"));
        setState(() {
          isFirstLoadRunning = false;
        });
      }
    });
  }
}
