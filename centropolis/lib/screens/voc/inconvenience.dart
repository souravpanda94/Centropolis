import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
import '../../widgets/voc_common_home.dart';
import 'air_conditioning_application.dart';
import 'air_conditioning_list.dart';
import 'air_inc_light_list.dart';
import 'complaints_received.dart';
import 'inconvenience_list.dart';

class InconvenienceScreen extends StatefulWidget {
  const InconvenienceScreen({super.key});

  @override
  State<InconvenienceScreen> createState() => _InconvenienceScreenState();
}

class _InconvenienceScreenState extends State<InconvenienceScreen> {
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 3;
  int totalPages = 3;
  int totalRecords = 3;
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
          backgroundColor: Colors.white,
          body: VocCommonHome(
            image: 'assets/images/inconvenience_dummy_image.png',
            title: tr("customerComplaints"),
            subTitle: tr("customerComplaints"),
            emptyTxt: tr("inconvenienceEmptyText"),
            airConditioningList: const [],
            inconvenienceList: incovenienceListItem,
            lightoutList: const [],
            onDrawerClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const InconvenienceList()),
              );
            },
            category: 'inconvenience',
          ),
          bottomSheet: Container(
            margin:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
            child: CommonButton(
              buttonName: tr("complaintsReceived"),
              buttonColor: CustomColors.buttonBackgroundColor,
              isIconVisible: true,
              onCommonButtonTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const ComplaintsReceived()),
                // );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ComplaintsReceived(
                            parentInquirId: "",
                          )),
                ).then((value) {
                  if (value) {
                    loadInconvenienceList();
                  }
                });
              },
            ),
          )),
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

          Provider.of<InconvenienceListProvider>(context, listen: false)
              .setItem(incovenienceList);
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
}
