import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
import '../../widgets/common_button.dart';
import '../../widgets/voc_common_home.dart';
import 'air_conditioning_application.dart';
import 'air_conditioning_list.dart';

class AirConditioningScreen extends StatefulWidget {
  const AirConditioningScreen({super.key});

  @override
  State<AirConditioningScreen> createState() => _AirConditioningScreenState();
}

class _AirConditioningScreenState extends State<AirConditioningScreen> {
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 3;
  int totalPages = 0;
  int totalRecords = 0;
  bool isFirstLoadRunning = true;
  List<LightOutListModel>? airConditioningListItem;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    firstTimeLoadAirConditioningList();
  }

  @override
  Widget build(BuildContext context) {
    airConditioningListItem =
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
          image: 'assets/images/air_conditioning.png',
          title: tr("requestForHeatingAndCooling"),
          subTitle: tr("requestForHeatingAndCooling"),
          emptyTxt: tr("airConditioningEmptyText"),
          itemsList: airConditioningListItem,
          onDrawerClick: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AirConditioningList()),
            );
          },
          category: 'airConditioning',
        ),
        bottomSheet: Container(
          margin:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
          child: CommonButton(
            buttonName: tr("AirConditioning"),
            buttonColor: CustomColors.buttonBackgroundColor,
            isIconVisible: true,
            onCommonButtonTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AirConditioningApplication()),
              );
            },
          ),
        ),
      ),
    );
  }

  void firstTimeLoadAirConditioningList() {
    setState(() {
      isFirstLoadRunning = true;
    });
    loadAirConditioningList();
  }

  void loadAirConditioningList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callAirConditioningListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callAirConditioningListApi() {
    Map<String, String> body = {
      "page": page.toString(),
      "limit": limit.toString()
    };

    debugPrint("AirConditioning List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getAirConditioningListUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for AirConditioning List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          totalPages = responseJson['total_pages'];
          totalRecords = responseJson['total_records'];
          List<LightOutListModel> airConditioningList =
              List<LightOutListModel>.from(responseJson['inquiry_data']
                  .map((x) => LightOutListModel.fromJson(x)));
          Provider.of<LightoutListProvider>(context, listen: false)
              .setItem(airConditioningList);
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
