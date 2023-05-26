import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/light_out_list_model.dart';
import '../../providers/lightout_list_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/view_more.dart';
import 'light_out_details.dart';

class LightsOutList extends StatefulWidget {
  const LightsOutList({super.key});

  @override
  State<LightsOutList> createState() => _LightsOutListState();
}

class _LightsOutListState extends State<LightsOutList> {
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 10;
  int totalPages = 0;
  int totalRecords = 0;
  bool isFirstLoadRunning = true;
  List<LightOutListModel>? lightoutListItem;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    firstTimeLoadLightsOutList();
  }

  @override
  Widget build(BuildContext context) {
    lightoutListItem =
        Provider.of<LightoutListProvider>(context).getLightoutModelList;

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
              child: CommonAppBar(tr("requestForLightsOut"), false, () {
                onBackButtonPress(context);
              }, () {}),
            ),
          ),
        ),
        body: lightoutListItem == null || lightoutListItem!.isEmpty
            ? Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                padding: const EdgeInsets.all(24),
                child: Text(
                  tr("lightOutEmptyText"),
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
                          itemCount: lightoutListItem?.length,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LightsOutDetails(
                                        type: lightoutListItem?[index]
                                                .status
                                                .toString() ??
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            lightoutListItem?[index]
                                                    .description ??
                                                "",
                                            //"Centropolis",
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontFamily: 'SemiBold',
                                                fontSize: 14,
                                                color: CustomColors.textColor8),
                                          ),
                                        ),
                                        if (lightoutListItem != null &&
                                            lightoutListItem![index]
                                                .status
                                                .toString()
                                                .isNotEmpty)
                                          Container(
                                            decoration: BoxDecoration(
                                              color: lightoutListItem?[index]
                                                              .status
                                                              .toString() ==
                                                          "Received" ||
                                                      lightoutListItem?[index]
                                                              .status
                                                              .toString() ==
                                                          "Rejected"
                                                  ? CustomColors
                                                      .backgroundColor3
                                                  : lightoutListItem?[index]
                                                              .status
                                                              .toString() ==
                                                          "Approved"
                                                      ? CustomColors
                                                          .backgroundColor
                                                      : lightoutListItem?[index]
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
                                              lightoutListItem?[index].status ??
                                                  "",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: "SemiBold",
                                                color: lightoutListItem?[index]
                                                                .status
                                                                .toString() ==
                                                            "Received" ||
                                                        lightoutListItem?[index]
                                                                .status
                                                                .toString() ==
                                                            "Rejected"
                                                    ? CustomColors.textColor9
                                                    : lightoutListItem?[index]
                                                                .status
                                                                .toString() ==
                                                            "Answered"
                                                        ? CustomColors
                                                            .textColorBlack2
                                                        : lightoutListItem?[
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
                                            lightoutListItem?[index]
                                                    .requestedFloors ??
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
                                            "${lightoutListItem?[index].registeredDate ?? ""} ${lightoutListItem?[index].startTime ?? ""}",
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

  void firstTimeLoadLightsOutList() {
    setState(() {
      isFirstLoadRunning = true;
    });
    loadLightsOutList();
  }

  void loadLightsOutList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLightsOutListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callLightsOutListApi() {
    Map<String, String> body = {
      "page": page.toString(),
      "limit": limit.toString()
    };

    debugPrint("LightsOut List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getLightsOutListUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for LightsOut List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          totalPages = responseJson['total_pages'];
          totalRecords = responseJson['total_records'];
          List<LightOutListModel> lightoutList = List<LightOutListModel>.from(
              responseJson['inquiry_data']
                  .map((x) => LightOutListModel.fromJson(x)));
          if (page == 1) {
            Provider.of<LightoutListProvider>(context, listen: false)
                .setItem(lightoutList);
          } else {
            Provider.of<LightoutListProvider>(context, listen: false)
                .addItem(lightoutList);
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
      loadLightsOutList();
    }
  }
}
