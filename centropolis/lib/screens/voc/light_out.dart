import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/inconvenience_list_model.dart';
import '../../models/light_out_list_model.dart';
import '../../providers/lightout_list_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_button.dart';
import '../../widgets/voc_common_home.dart';
import 'light_out_list.dart';
import 'light_out_request.dart';

class LightOutScreen extends StatefulWidget {
  const LightOutScreen({super.key});

  @override
  State<LightOutScreen> createState() => _LightOutScreenState();
}

class _LightOutScreenState extends State<LightOutScreen> {
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 3;
  int totalPages = 1;
  int totalRecords = 3;
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
        backgroundColor: Colors.white,
        body: VocCommonHome(
          image: 'assets/images/ic_slider_6.png',
          title: tr("requestForLightsOut"),
          subTitle: tr("requestForLightsOut"),
          emptyTxt: tr("lightOutEmptyText"),
          airConditioningList: const [],
          inconvenienceList: const [],
          lightoutList: lightoutListItem,
          onDrawerClick: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LightsOutList()),
            ).then((value) {
              if (value) {
                firstTimeLoadLightsOutList();
              }
            });
          },
          category: 'lightout',
        ),
        bottomSheet: Container(
          margin:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
          child: CommonButton(
            buttonName: tr("requestForLightsOut"),
            buttonColor: CustomColors.buttonBackgroundColor,
            isIconVisible: true,
            onCommonButtonTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LightOutRequest()),
              ).then((value) {
                if (value) {
                  loadLightsOutList();
                }
              });
            },
          ),
        ),
      ),
    );
  }

  void firstTimeLoadLightsOutList() {
    setState(() {
      isFirstLoadRunning = true;
      page = 1;
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

          Provider.of<LightoutListProvider>(context, listen: false)
              .setItem(lightoutList);
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
