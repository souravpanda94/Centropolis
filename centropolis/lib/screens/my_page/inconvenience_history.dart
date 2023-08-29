import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/inconvenience_list_model.dart';
import '../../providers/incovenience_list_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/view_more.dart';
import '../voc/complaints_received.dart';
import 'inconvenience_history_details.dart';

class InconvenienceHistory extends StatefulWidget {
  const InconvenienceHistory({super.key});

  @override
  State<InconvenienceHistory> createState() => _InconvenienceHistoryState();
}

class _InconvenienceHistoryState extends State<InconvenienceHistory> {
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 10;
  int totalPages = 0;
  int totalRecords = 0;
  bool isFirstLoadRunning = true;
  List<IncovenienceListModel>? incovenienceListItem;
  String? currentSelectedSortingFilter;
  List<dynamic>? statusList = [];

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    internetCheckingForMethods();
  }


  void internetCheckingForMethods() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callStatusListApi();
      firstTimeLoadInconvenienceList();

    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }


  @override
  Widget build(BuildContext context) {
    incovenienceListItem = Provider.of<InconvenienceListProvider>(context)
        .getInconvenienceModelList;

    return LoadingOverlay(
      color: CustomColors.whiteColor,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isFirstLoadRunning,
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
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
                          fontFamily: 'Medium',
                          fontSize: 14,
                          color: CustomColors.textColorBlack2),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        totalRecords.toString(),
                        style: const TextStyle(
                            fontFamily: 'Medium',
                            fontSize: 14,
                            color: CustomColors.textColor9),
                      ),
                    ),
                    Text(
                      tr("items"),
                      style: const TextStyle(
                          fontFamily: 'Medium',
                          fontSize: 14,
                          color: CustomColors.textColorBlack2),
                    ),
                  ],
                ),
                sortingDropdownWidget(),
              ],
            ),
            incovenienceListItem == null || incovenienceListItem!.isEmpty
                ? Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        tr("noReservationHistory"),
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
                        itemCount: incovenienceListItem?.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      InconvenienceHistoryDetails(
                                          inquiryId:
                                              incovenienceListItem![index]
                                                  .inquiryId
                                                  .toString()),
                                ),
                              ).then((value) {
                                if (value) {
                                  firstTimeLoadInconvenienceList();
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
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          incovenienceListItem![index].title ??
                                              "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'SemiBold',
                                              fontSize: 14,
                                              color: CustomColors.textColor8),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      if (incovenienceListItem != null &&
                                          incovenienceListItem![index]
                                              .status
                                              .toString()
                                              .isNotEmpty)
                                        Container(
                                          decoration: BoxDecoration(
                                            color: setStatusBackgroundColor(
                                                incovenienceListItem?[index]
                                                    .status
                                                    .toString()
                                                    .toLowerCase()),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          padding: const EdgeInsets.only(
                                              top: 5.0,
                                              bottom: 5.0,
                                              left: 10.0,
                                              right: 10.0),
                                          child: Text(
                                            incovenienceListItem![index]
                                                    .displayStatus ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "SemiBold",
                                              color: setStatusTextColor(
                                                  incovenienceListItem?[index]
                                                      .status
                                                      .toString()
                                                      .toLowerCase()),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Text(
                                          incovenienceListItem?[index].type ??
                                              "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 12,
                                              color: CustomColors.textColor3),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 2),
                                          child: VerticalDivider(
                                            thickness: 1,
                                            color: CustomColors.borderColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          incovenienceListItem?[index]
                                                  .registeredDate ??
                                              "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 12,
                                              color: CustomColors.textColor3),
                                        ),
                                      ],
                                    ),
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
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(bottom: 40),
              child: CommonButton(
                onCommonButtonTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ComplaintsReceived(parentInquirId: ""),
                    ),
                  ).then((value) {
                    if (value) {
                      firstTimeLoadInconvenienceList();
                    }
                  });
                },
                buttonColor: CustomColors.buttonBackgroundColor,
                buttonName: tr("newInquiry"),
                isIconVisible: false,
              ),
            )
          ],
        ),
      ),
    );
  }

  void firstTimeLoadInconvenienceList() {
    setState(() {
      isFirstLoadRunning = true;
      page = 1;
    });
    Provider.of<InconvenienceListProvider>(context, listen: false)
        .setEmptyList();
    loadInconvenienceList();
  }

  void loadInconvenienceList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callInconvenienceListApi();
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callInconvenienceListApi() {
    setState(() {
      isFirstLoadRunning = true;
    });
    Map<String, String> body = {
      "page": page.toString(),
      "limit": limit.toString(),
      "status": currentSelectedSortingFilter != null &&
              currentSelectedSortingFilter!.isNotEmpty
          ? currentSelectedSortingFilter.toString().trim()
          : "",
    };

    debugPrint("Inconvenience List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getInconvenienceListUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Inconvenience List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          totalPages = responseJson['total_pages'];
          totalRecords = responseJson['total_records'];
          List<IncovenienceListModel> incovenienceList =
              List<IncovenienceListModel>.from(responseJson['inquiry_data']
                  .map((x) => IncovenienceListModel.fromJson(x)));
          if (page == 1) {
            Provider.of<InconvenienceListProvider>(context, listen: false)
                .setItem(incovenienceList);
          } else {
            Provider.of<InconvenienceListProvider>(context, listen: false)
                .addItem(incovenienceList);
          }
        } else {
          if (responseJson['message'] != null) {
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(context: context,
                heading: responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          }
        }
        }}).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(context: context,
          heading: tr("errorDescription"),
          description:"",
          buttonName : tr("check"));
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
      loadInconvenienceList();
    }
  }

  sortingDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        alignment: AlignmentDirectional.centerEnd,
        hint: Text(
          statusList != null && statusList!.isNotEmpty
              ? statusList?.first["text"]
              : tr('all'),
          style: const TextStyle(
            color: CustomColors.textColor5,
            fontSize: 14,
            fontFamily: 'Medium',
          ),
        ),
        items: statusList
            ?.map(
              (item) => DropdownMenuItem<String>(
                value: item["value"],
                child: Text(
                  item["text"],
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

          firstTimeLoadInconvenienceList();
        },
        dropdownStyleData: DropdownStyleData(
          //maxHeight: 200,
          width: 160,
          isOverButton: false,
          elevation: 0,
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              border: Border.all(color: CustomColors.borderColor, width: 1)),
        ),
        buttonStyleData: const ButtonStyleData(height: 35),
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
        menuItemStyleData: const MenuItemStyleData(
          overlayColor:
              MaterialStatePropertyAll(CustomColors.dropdownHoverColor),
          padding: EdgeInsets.only(left: 16, top: 12, bottom: 12),
        ),
      ),
    );
  }


  // void loadStatusList() async {
  //   final InternetChecking internetChecking = InternetChecking();
  //   if (await internetChecking.isInternet()) {
  //     callStatusListApi();
  //   } else {
  //     // showCustomToast(fToast, context, tr("noInternetConnection"), "");
  //     showErrorCommonModal(
  //         context: context,
  //         heading: tr("noInternet"),
  //         description: tr("connectionFailedDescription"),
  //         buttonName: tr("check"));
  //   }
  // }

  void callStatusListApi() {
    setState(() {
      isFirstLoadRunning = true;
    });
    Map<String, String> body = {};
    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.inconvenienceStatusUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              statusList = responseJson['data'];
              Map<dynamic, dynamic> allMap = {"text": tr("all"), "value": ""};
              statusList?.insert(0, allMap);
            });
          }
        } else {
          if (responseJson['message'] != null) {
            // showCustomToast(fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(context: context,
                heading :responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          }
        }
        setState(() {
          isFirstLoadRunning = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(context: context,
          heading: tr("errorDescription"),
          description:"",
          buttonName : tr("check"));
      setState(() {
        isFirstLoadRunning = false;
      });
    });
  }

  Color setStatusBackgroundColor(String? status) {
    return CustomColors.backgroundColor;
  }

  Color setStatusTextColor(String? status) {
    if (status.toString().toLowerCase() == "completed") {
      return CustomColors.textColor3;
    } else {
      return CustomColors.textColorBlack2;
    }
  }
}
