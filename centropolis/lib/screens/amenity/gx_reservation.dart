import 'dart:convert';
import 'package:centropolis/widgets/app_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../models/gx_fitness_reservation_model.dart';
import '../../providers/gx_fitness_reservation_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/view_more.dart';
import 'gx_reservation_detail.dart';

class GXReservation extends StatefulWidget {
  const GXReservation({super.key});

  @override
  State<GXReservation> createState() => _GXReservationState();
}

class _GXReservationState extends State<GXReservation> {
  // List<dynamic> gxList = [
  //   {
  //     "title": "YOGA CLASS",
  //     "datetime": "2023-00-00 ~ 2023-00-00",
  //     "days": "Mon, Wed, Fri",
  //     "status": "Active"
  //   },
  //   {
  //     "title": "JUST 10 MINUTES JUST 10 MINUTES JUST 10 MINUTES",
  //     "datetime": "2023-00-00 ~ 2023-00-00",
  //     "days": "Tue",
  //     "status": "Active"
  //   },
  //   {
  //     "title": "CORE TRAINING & STRETCHING",
  //     "datetime": "2023-00-00 ~ 2023-00-00",
  //     "days": "Thu",
  //     "status": "Active"
  //   },
  //   {
  //     "title": "JUST 10 MINUTES",
  //     "datetime": "2023-00-00 ~ 2023-00-00",
  //     "days": "Tue",
  //     "status": "Active"
  //   },
  //   {
  //     "title": "YOGA CLASS",
  //     "datetime": "2023-00-00 ~ 2023-00-00",
  //     "days": "Mon, Wed, Fri",
  //     "status": "Closed"
  //   },
  //   {
  //     "title": "JUST 10 MINUTES JUST 10 MINUTES JUST 10 MINUTES",
  //     "datetime": "2023-00-00 ~ 2023-00-00",
  //     "days": "Mon, Wed, Fri",
  //     "status": "Closed"
  //   },
  //   {
  //     "title": "CORE TRAINING & STRETCHING",
  //     "datetime": "2023-00-00 ~ 2023-00-00",
  //     "days": "Mon, Wed, Fri",
  //     "status": "Closed"
  //   },
  //   {
  //     "title": "JUST 10 MINUTES",
  //     "datetime": "2023-00-00 ~ 2023-00-00",
  //     "days": "Tue",
  //     "status": "Closed"
  //   },
  // ];
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 10;
  int totalPages = 0;
  bool isFirstLoadRunning = true;
  bool isLoadMoreRunning = false;
  ScrollController? scrollController;
  List<GxFitnessReservationModel>? gxReservationListItem;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    scrollController = ScrollController()..addListener(loadMore);
    firstTimeLoadGxFitnessReservationList();
  }

  @override
  Widget build(BuildContext context) {
    gxReservationListItem = Provider.of<GxFitnessReservationProvider>(context)
        .getGxFitnessReservationList;

    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.textColor4,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isFirstLoadRunning,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr("programsAvailableForReservation"),
              style: const TextStyle(
                  fontFamily: 'SemiBold',
                  fontSize: 16,
                  color: CustomColors.textColorBlack2),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24, bottom: 8),
              width: MediaQuery.of(context).size.width,
              child: const Text(
                "Service inquiries: 02-6370-5151, 5154",
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontFamily: 'Regular',
                    fontSize: 12,
                    color: CustomColors.textColor3),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.whiteColor,
                  borderRadius: BorderRadius.circular(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "GX & EVENT Program Information",
                    style: TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 16,
                        color: CustomColors.textColorBlack2),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Icon(
                            Icons.circle,
                            size: 5,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "Mon, Wed, Fri – Yoga (120,000 won per month, excluding VAT)",
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColor5),
                          ),
                        )
                      ]),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Icon(
                            Icons.circle,
                            size: 5,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "Tue, Thu – Free GX Program",
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColor5),
                          ),
                        )
                      ]),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Column(children: [
              ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  // itemCount: gxList.length,
                  itemCount: gxReservationListItem?.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 16),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          color: CustomColors.whiteColor,
                          border: Border.all(
                            color:
                                // gxList[index]["status"] == "Active"
                                gxReservationListItem?[index].status == "Active"
                                    ? CustomColors.borderColor
                                    : CustomColors.backgroundColor2,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4))),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  // gxList[index]["title"],
                                  gxReservationListItem?[index].title ?? "",
                                  style: TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color:
                                          // gxList[index]["status"] == "Active"
                                          gxReservationListItem?[index]
                                                      .status ==
                                                  "Active"
                                              ? CustomColors.textColor8
                                              : CustomColors.dividerGreyColor),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const GXReservationDetail(),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 12),
                                  decoration: BoxDecoration(
                                      color: CustomColors.whiteColor,
                                      border: Border.all(
                                        color:
                                            // gxList[index]["status"] == "Active"
                                            gxReservationListItem?[index]
                                                        .status ==
                                                    "Active"
                                                ? CustomColors.textColor9
                                                : CustomColors.dividerGreyColor,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Text(
                                    // gxList[index]["status"] == "Active"
                                    gxReservationListItem?[index].status ==
                                            "Active"
                                        ? tr("apply")
                                        : gxReservationListItem?[index]
                                                .status
                                                .toString() ??
                                            "",
                                    style: TextStyle(
                                        fontFamily: 'SemiBold',
                                        fontSize: 12,
                                        color:
                                            // gxList[index]["status"] == "Active"
                                            gxReservationListItem?[index]
                                                        .status ==
                                                    "Active"
                                                ? CustomColors.textColor9
                                                : CustomColors
                                                    .dividerGreyColor),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Text(
                                  // gxList[index]["datetime"],
                                  "${gxReservationListItem?[index].applicationStartDate} ~ ${gxReservationListItem?[index].applicationEndDate}",
                                  style: TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 12,
                                      color:
                                          // gxList[index]["status"] == "Active"
                                          gxReservationListItem?[index]
                                                      .status ==
                                                  "Active"
                                              ? CustomColors.textColor3
                                              : CustomColors.dividerGreyColor),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: const VerticalDivider(
                                    color: CustomColors.borderColor,
                                  ),
                                ),
                                Text(
                                  // gxList[index]["days"],
                                  "Mon,Wed,Fri",
                                  style: TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 12,
                                      color:
                                          // gxList[index]["status"] == "Active"
                                          gxReservationListItem?[index]
                                                      .status ==
                                                  "Active"
                                              ? CustomColors.textColor3
                                              : CustomColors.dividerGreyColor),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  })),

              // if (isLoadMoreRunning) const ViewMoreWidget()
              if (isLoadMoreRunning) const AppLoading()
            ]),
          ],
        ),
      ),
    );
  }

  void firstTimeLoadGxFitnessReservationList() {
    setState(() {
      isFirstLoadRunning = true;
    });
    loadGxFitnessReservationList();
  }

  void loadGxFitnessReservationList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callGxFitnessReservationListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callGxFitnessReservationListApi() {
    setState(() {
      isFirstLoadRunning = true;
    });
    Map<String, String> body = {
      "page": page.toString(), //required
      "limit": limit.toString()
    };

    debugPrint("Gx Fitness Reservation List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getGxFitnessReservationUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for Gx Fitness Reservation List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          // List<GxFitnessReservationModel> reservationListList = List<GxFitnessReservationModel>.from(responseJson['reservegx_data'].map((x) => GxFitnessReservationModel.fromJson(x)));
          // Provider.of<GxFitnessReservationProvider>(context, listen: false).setItem(reservationListList);

          totalPages = responseJson['total_pages'];
          List<GxFitnessReservationModel> reservationListList =
              List<GxFitnessReservationModel>.from(
                  responseJson['reservegx_data']
                      .map((x) => GxFitnessReservationModel.fromJson(x)));
          if (page == 1) {
            Provider.of<GxFitnessReservationProvider>(context, listen: false)
                .setItem(reservationListList);
          } else {
            Provider.of<GxFitnessReservationProvider>(context, listen: false)
                .addItem(reservationListList);
          }
        } else {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
        setState(() {
          isFirstLoadRunning = false;
          isLoadMoreRunning = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isFirstLoadRunning = false;
        isLoadMoreRunning = false;
      });
    });
  }

  void loadMore() {
    if (scrollController?.position.maxScrollExtent ==
            scrollController?.offset &&
        (scrollController?.position.extentAfter)! < 500) {
      if (page < totalPages) {
        debugPrint("load more called");

        setState(() {
          isLoadMoreRunning = true;
          page++;
        });
        loadGxFitnessReservationList();
      }
    }
  }
}
