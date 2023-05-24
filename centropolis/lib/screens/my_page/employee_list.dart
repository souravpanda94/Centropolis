import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/employee_list_model.dart';
import '../../providers/employee_list_provider.dart';
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

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    firstTimeLoadEmployeeList();
  }

  @override
  Widget build(BuildContext context) {
    employeeListItem =
        Provider.of<EmployeeListProvider>(context).getEmployeeModelList;

    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.whiteColor,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isFirstLoadRunning,
      child: employeeListItem == null || employeeListItem!.isEmpty
          ? Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              padding: const EdgeInsets.all(24),
              child: Text(
                tr("noDataFound"),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: 'Regular',
                    fontSize: 14,
                    color: CustomColors.textColor5),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 33),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            tr("total"),
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Text(
                              employeeListItem!.length.toString(),
                              style: const TextStyle(
                                  fontFamily: 'Regular',
                                  fontSize: 14,
                                  color: CustomColors.textColor9),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            tr("all"),
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColor5),
                          ),
                          const SizedBox(
                            width: 11,
                          ),
                          SvgPicture.asset(
                              "assets/images/ic_drop_down_arrow.svg",
                              color: CustomColors.textColor5)
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Expanded(
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
                              );
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
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        employeeListItem?[index].name ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: 'SemiBold',
                                            fontSize: 14,
                                            color: CustomColors.textColor8),
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
                                                      BorderRadius.circular(50),
                                                ),
                                                padding: const EdgeInsets.only(
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
                                                      employeeListItem![index]
                                                                  .accountType
                                                                  .toString() !=
                                                              "tenant_lounge_employee"
                                                          ? tr(
                                                              "executiveLounge")
                                                          : employeeListItem![
                                                                          index]
                                                                      .accountType
                                                                      .toString() !=
                                                                  "tenant_conference_employee"
                                                              ? tr(
                                                                  "conferenceRoom")
                                                              : employeeListItem![
                                                                          index]
                                                                      .displayAccountType ??
                                                                  "",
                                                      style: const TextStyle(
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
                                    height: 18,
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
                      );
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
    setState(() {
      isFirstLoadRunning = true;
    });
    loadEmployeeList();
  }

  void loadEmployeeList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callEmployeeListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callEmployeeListApi() {
    Map<String, String> body = {
      "page": page.toString(),
      "limit": limit.toString(),
      "status": widget.status.toString().trim() //optional
      // will be required when sorting dropdown
      // "account_type":
      //     "tenant_conference_employee/tenant_employee/tenant_lounge_employee", //optional
    };

    debugPrint("Employee List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.registeredEmployeeListUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
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
            Provider.of<EmployeeListProvider>(context, listen: false)
                .setItem(employeeList);
          } else {
            Provider.of<EmployeeListProvider>(context, listen: false)
                .addItem(employeeList);
          }
        } else {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
        setState(() {
          isFirstLoadRunning = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      if (mounted) {
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
}
