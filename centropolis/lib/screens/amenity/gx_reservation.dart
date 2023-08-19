import 'dart:convert';
import 'dart:io';
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
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 10;
  int totalPages = 0;
  bool isFirstLoadRunning = true;
  List<GxFitnessReservationModel>? gxReservationListItem;
  //List<String> days = ["Mon", "Wed", "Fri,Sun"];

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
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
        color: CustomColors.backgroundColor,
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
              child: Text(
                tr("serviceRequiresForGx"),
                textAlign: TextAlign.end,
                style: const TextStyle(
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
                  Text(
                    tr("gXprogramInformation"),
                    style: const TextStyle(
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
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Icon(
                            Icons.circle,
                            size: 5,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            tr("gXprogramInformationDescription1"),
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColor5),
                          ),
                        )
                      ]),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Icon(
                            Icons.circle,
                            size: 5,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            tr("gXprogramInformationDescription2"),
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColor5),
                          ),
                        )
                      ]),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Icon(
                            Icons.circle,
                            size: 5,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            tr("gXprogramInformationDescription3"),
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColor5),
                          ),
                        )
                      ]),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Icon(
                            Icons.circle,
                            size: 5,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            tr("gXprogramInformationDescription4"),
                            style: const TextStyle(
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
            Expanded(
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: gxReservationListItem?.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        if (gxReservationListItem?[index].status ==
                            "receiving") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GXReservationDetail(
                                  gxReservationItem:
                                      gxReservationListItem![index]),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 16),
                        margin: EdgeInsets.only(
                            bottom: Platform.isAndroid ? 13 : 9),
                        decoration: BoxDecoration(
                            color: CustomColors.whiteColor,
                            border: Border.all(
                              color:
                                  // gxList[index]["status"] == "Active"
                                  gxReservationListItem?[index].status ==
                                          "receiving"
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
                                    gxReservationListItem?[index]
                                            .title
                                            .toString()
                                            .toUpperCase() ??
                                        "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'SemiBold',
                                        fontSize: 14,
                                        color:
                                            // gxList[index]["status"] == "Active"
                                            gxReservationListItem?[index]
                                                        .status ==
                                                    "receiving"
                                                ? CustomColors.textColor8
                                                : CustomColors
                                                    .dividerGreyColor),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Platform.isAndroid ? 5 : 2,
                                      horizontal: 12),
                                  margin: const EdgeInsets.only(left: 20),
                                  decoration: BoxDecoration(
                                      color: CustomColors.whiteColor,
                                      border: Border.all(
                                        color:
                                            // gxList[index]["status"] == "Active"
                                            gxReservationListItem?[index]
                                                        .status ==
                                                    "receiving"
                                                ? CustomColors.textColor9
                                                : CustomColors.dividerGreyColor,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Text(
                                    // gxList[index]["status"] == "Active"
                                    gxReservationListItem?[index].status ==
                                            "receiving"
                                        ? tr("apply")
                                        : tr("deadline"),
                                    style: TextStyle(
                                        fontFamily: 'SemiBold',
                                        fontSize: 12,
                                        color:
                                            // gxList[index]["status"] == "Active"
                                            gxReservationListItem?[index]
                                                        .status ==
                                                    "receiving"
                                                ? CustomColors.textColor9
                                                : CustomColors
                                                    .dividerGreyColor),
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
                                                    "receiving"
                                                ? CustomColors.textColor3
                                                : CustomColors
                                                    .dividerGreyColor),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 4, right: 4),
                                    child: const VerticalDivider(
                                      color: CustomColors.borderColor,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      gxReservationListItem?[index]
                                              .programDaysData
                                              .toString()
                                              .trim() ??
                                          "",
                                      style: TextStyle(
                                          fontFamily: 'Regular',
                                          fontSize: 12,
                                          color:
                                              // gxList[index]["status"] == "Active"
                                              gxReservationListItem?[index]
                                                          .status ==
                                                      "receiving"
                                                  ? CustomColors.textColor3
                                                  : CustomColors
                                                      .dividerGreyColor),
                                    ),
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
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isFirstLoadRunning = false;
      });
    });
  }

  void loadMore() {
    debugPrint("page ================> $page");
    debugPrint("totalPages ================> $totalPages");

    if (page < totalPages) {
      debugPrint("load more called");
      setState(() {
        page++;
      });
      loadGxFitnessReservationList();
    }
  }
}
