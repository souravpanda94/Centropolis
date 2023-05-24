import 'dart:convert';

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
import 'inconvenience_details.dart';

class InconvenienceList extends StatefulWidget {
  const InconvenienceList({super.key});

  @override
  State<InconvenienceList> createState() => _InconvenienceListState();
}

class _InconvenienceListState extends State<InconvenienceList> {
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 10;
  int totalPages = 0;
  int totalRecords = 0;
  bool isFirstLoadRunning = true;
  List<IncovenienceListModel>? incovenienceListItem;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    firstTimeLoadInconvenienceList();
  }

  @override
  Widget build(BuildContext context) {
    incovenienceListItem = Provider.of<InconvenienceListProvider>(context)
        .getInconvenienceModelList;

    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.whiteColor,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isFirstLoadRunning,
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              color: CustomColors.whiteColor,
              child: CommonAppBar(tr("complaintsReceived"), false, () {
                onBackButtonPress(context);
              }, () {}),
            ),
          ),
        ),
        body: incovenienceListItem == null || incovenienceListItem!.isEmpty
            ? Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                padding: const EdgeInsets.all(24),
                child: Text(
                  tr("inconvenienceEmptyText"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: 'Regular',
                      fontSize: 14,
                      color: CustomColors.textColor5),
                ),
              )
            : Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 33),
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
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              child: Text(
                                "38",
                                style: TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    color: CustomColors.textColor9),
                              ),
                            ),
                            Text(
                              tr("items"),
                              style: const TextStyle(
                                  fontFamily: 'Regular',
                                  fontSize: 14,
                                  color: CustomColors.textColorBlack2),
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
                          itemCount: incovenienceListItem?.length,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InconvenienceDetails(
                                        inquiryId: incovenienceListItem![index]
                                            .inquiryId
                                            .toString()),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            incovenienceListItem![index]
                                                    .title ??
                                                "",
                                            style: const TextStyle(
                                                fontFamily: 'SemiBold',
                                                fontSize: 14,
                                                color: CustomColors.textColor8),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        if (incovenienceListItem![index]
                                            .status
                                            .toString()
                                            .isNotEmpty)
                                          Container(
                                            decoration: BoxDecoration(
                                              color: incovenienceListItem![
                                                                  index]
                                                              .status
                                                              .toString() ==
                                                          "Received" ||
                                                      incovenienceListItem![
                                                                  index]
                                                              .status
                                                              .toString() ==
                                                          "Not Answered"
                                                  ? CustomColors
                                                      .backgroundColor3
                                                  : incovenienceListItem![index]
                                                                  .status
                                                                  .toString() ==
                                                              "Answered" ||
                                                          incovenienceListItem![
                                                                      index]
                                                                  .status
                                                                  .toString() ==
                                                              "Completed"
                                                      ? CustomColors
                                                          .backgroundColor
                                                      : incovenienceListItem![
                                                                      index]
                                                                  .status
                                                                  .toString() ==
                                                              "In Progress"
                                                          ? CustomColors
                                                              .greyColor2
                                                          : CustomColors
                                                              .textColorBlack2,
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
                                                          .status
                                                          .toString() ==
                                                      "Not Answered"
                                                  ? "Received"
                                                  : incovenienceListItem![index]
                                                          .status ??
                                                      "",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: "SemiBold",
                                                color: incovenienceListItem![
                                                                    index]
                                                                .status
                                                                .toString() ==
                                                            "Received" ||
                                                        incovenienceListItem![
                                                                    index]
                                                                .status
                                                                .toString() ==
                                                            "Not Answered"
                                                    ? CustomColors.textColor9
                                                    : incovenienceListItem![
                                                                        index]
                                                                    .status
                                                                    .toString() ==
                                                                "Answered" ||
                                                            incovenienceListItem![
                                                                        index]
                                                                    .status
                                                                    .toString() ==
                                                                "Completed"
                                                        ? CustomColors
                                                            .textColorBlack2
                                                        : incovenienceListItem![
                                                                        index]
                                                                    .status
                                                                    .toString() ==
                                                                "In Progress"
                                                            ? CustomColors
                                                                .brownColor
                                                            : CustomColors
                                                                .textColorBlack2,
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
                                            incovenienceListItem![index].type ??
                                                "",
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
                                          const VerticalDivider(
                                            thickness: 1,
                                            color: CustomColors.borderColor,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            incovenienceListItem![index]
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
                      )
                  ],
                ),
              ),
      ),
    );
  }

  void firstTimeLoadInconvenienceList() {
    setState(() {
      isFirstLoadRunning = true;
    });
    loadInconvenienceList();
  }

  void loadInconvenienceList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callInconvenienceListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callInconvenienceListApi() {
    Map<String, String> body = {
      "page": page.toString(),
      "limit": limit.toString()
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
      loadInconvenienceList();
    }
  }
}
