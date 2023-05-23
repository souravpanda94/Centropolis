import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/inconvenience_list_model.dart';
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
  int totalPages = 0;
  int totalRecords = 0;
  bool isFirstLoadRunning = true;
  List<IncovenienceListModel>? incovenienceListItem;

  List<dynamic> itemList = [
    {
      "title": "Centropolis",
      "status": "Received",
      "date": "2023.00.00",
      "module": "11F",
      "type": "heating"
    },
    {
      "title": "Centropolis",
      "status": "Received",
      "date": "2023.00.00",
      "module": "11F",
      "type": "heating"
    },
    {
      "title": "Centropolis",
      "status": "Received",
      "date": "2023.00.00",
      "module": "11F",
      "type": "Air conditioning"
    },
  ];

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: VocCommonHome(
        image: 'assets/images/ic_slider_6.png',
        title: tr("requestForLightsOut"),
        subTitle: tr("requestForLightsOut"),
        emptyTxt: tr("lightOutEmptyText"),
        itemsList: itemList,
        onDrawerClick: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LightsOutList()),
          );
        },
        category: '',
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
        child: CommonButton(
          buttonName: tr("requestForLightsOut"),
          buttonColor: CustomColors.buttonBackgroundColor,
          isIconVisible: true,
          onCommonButtonTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LightOutRequest()),
            );
          },
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

      // if (responseJson != null) {
      //   if (response.statusCode == 200 && responseJson['success']) {
      //     totalPages = responseJson['total_pages'];
      //     totalRecords = responseJson['total_records'];
      //     List<IncovenienceListModel> incovenienceList =
      //         List<IncovenienceListModel>.from(responseJson['inquiry_data']
      //             .map((x) => IncovenienceListModel.fromJson(x)));
      //     if (page == 1) {
      //       Provider.of<InconvenienceListProvider>(context, listen: false)
      //           .setItem(incovenienceList);
      //     } else {
      //       Provider.of<InconvenienceListProvider>(context, listen: false)
      //           .addItem(incovenienceList);
      //     }
      //   } else {
      //     if (responseJson['message'] != null) {
      //       showCustomToast(
      //           fToast, context, responseJson['message'].toString(), "");
      //     }
      //   }
      //   setState(() {
      //     isFirstLoadRunning = false;
      //   });
      // }
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
