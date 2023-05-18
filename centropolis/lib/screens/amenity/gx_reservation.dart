import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
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
  List<dynamic> gxList = [
    {
      "title": "YOGA CLASS",
      "datetime": "2023-00-00 ~ 2023-00-00",
      "days": "Mon, Wed, Fri",
      "status": "Active"
    },
    {
      "title": "JUST 10 MINUTES JUST 10 MINUTES JUST 10 MINUTES",
      "datetime": "2023-00-00 ~ 2023-00-00",
      "days": "Tue",
      "status": "Active"
    },
    {
      "title": "CORE TRAINING & STRETCHING",
      "datetime": "2023-00-00 ~ 2023-00-00",
      "days": "Thu",
      "status": "Active"
    },
    {
      "title": "JUST 10 MINUTES",
      "datetime": "2023-00-00 ~ 2023-00-00",
      "days": "Tue",
      "status": "Active"
    },
    {
      "title": "YOGA CLASS",
      "datetime": "2023-00-00 ~ 2023-00-00",
      "days": "Mon, Wed, Fri",
      "status": "Closed"
    },
    {
      "title": "JUST 10 MINUTES JUST 10 MINUTES JUST 10 MINUTES",
      "datetime": "2023-00-00 ~ 2023-00-00",
      "days": "Mon, Wed, Fri",
      "status": "Closed"
    },
    {
      "title": "CORE TRAINING & STRETCHING",
      "datetime": "2023-00-00 ~ 2023-00-00",
      "days": "Mon, Wed, Fri",
      "status": "Closed"
    },
    {
      "title": "JUST 10 MINUTES",
      "datetime": "2023-00-00 ~ 2023-00-00",
      "days": "Tue",
      "status": "Closed"
    },
  ];
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    loadGxFitnessReservationList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: gxList.length,
                itemBuilder: ((context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 16),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                        color: CustomColors.whiteColor,
                        border: Border.all(
                          color: gxList[index]["status"] == "Active"
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
                                gxList[index]["title"],
                                style: TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: gxList[index]["status"] == "Active"
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
                                      color: gxList[index]["status"] == "Active"
                                          ? CustomColors.textColor9
                                          : CustomColors.dividerGreyColor,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50))),
                                child: Text(
                                  gxList[index]["status"] == "Active"
                                      ? tr("apply")
                                      : gxList[index]["status"],
                                  style: TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 12,
                                      color: gxList[index]["status"] == "Active"
                                          ? CustomColors.textColor9
                                          : CustomColors.dividerGreyColor),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Text(
                                gxList[index]["datetime"],
                                style: TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 12,
                                    color: gxList[index]["status"] == "Active"
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
                                gxList[index]["days"],
                                style: TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 12,
                                    color: gxList[index]["status"] == "Active"
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
          ),
          const ViewMoreWidget()
        ],
      ),
    );
  }

  void loadGxFitnessReservationList() async{
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callGxFitnessReservationListApi();
    } else {
    showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callGxFitnessReservationListApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};

    debugPrint("Gx Fitness Reservation List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getGxFitnessReservationUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Gx Fitness Reservation List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {






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
