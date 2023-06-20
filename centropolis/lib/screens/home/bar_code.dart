import 'dart:async';
import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:barcode_widget/barcode_widget.dart';
import 'package:centropolis/widgets/common_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/app_bar_for_dialog.dart';

class BarCodeScreen extends StatefulWidget {
  const BarCodeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _BarCodeScreenState();
}

class _BarCodeScreenState extends State<BarCodeScreen> {
  late String language, apiKey, userType;
  late FToast fToast;
  bool isLoading = false;
  String qrCodeUrl = "";

  Timer? timer;
  static const minSeconds = 0;
  int seconds = 300;
  // int seconds = 20;
  String showTime = "5:00";
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    language = tr("lang");
    fToast = FToast();
    fToast.init(context);
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    userType = user.userData['user_type'].toString();
    loadQrCode();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      opacity: 1,
      color: CustomColors.whiteColor,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isLoading,
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              color: CustomColors.whiteColor,
              child: AppBarForDialog(tr("qrCheckIn"), () {
                onBackButtonPress(context);
              }),
            ),
          ),
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 90, bottom: 16),
                  child: Text(
                    tr('barCodeTitle'),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 16,
                        color: CustomColors.textColorBlack2),
                  ),
                ),
                Text(
                  tr('barCodeSubTitle'),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                      fontFamily: 'Regular',
                      fontSize: 14,
                      color: CustomColors.greyColor1),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: CustomColors.whiteColor,
                      borderRadius: BorderRadius.circular(4)),
                  margin: const EdgeInsets.only(top: 32, bottom: 122),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 66, vertical: 32),
                  // child: BarcodeWidget(
                  //   barcode: Barcode.qrCode(),
                  //   data: 'Centropolis App QR code generator',
                  //   height: 240,
                  //   width: 210,
                  // ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/ic_timer.png',
                            width: 15,
                            height: 15,
                            alignment: Alignment.center,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            tr('remaining_time'),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColor3),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            '$showTime ${tr('minutes')}',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: const TextStyle(
                                fontFamily: 'Medium',
                                fontSize: 14,
                                color: CustomColors.textColor9),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: qrCodeUrl != ""
                            ? Image.network(
                                '${ImageLinks.baseUrlForImage}$qrCodeUrl',
                                width: 200,
                                height: 200,
                              )
                            : null,
                      )
                    ],
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 40),
                    child: CommonButton(
                      isIconVisible: false,
                      onCommonButtonTap: () {
                        onBackButtonPress(context);
                      },
                      buttonColor: CustomColors.buttonBackgroundColor,
                      buttonName: tr("check"),
                    ))
              ],
            ),
          ),
        )),
      ),
    );
  }

  void loadQrCode() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadQrCodeApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callLoadQrCodeApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {};
    debugPrint("Get QR Code input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getQrCodeUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Get QR Code ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['qr_code_path'] != null) {
            setState(() {
              qrCodeUrl = responseJson['qr_code_path'].toString();
            });
            startTimer();
          }
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

  void startTimer() {
    if (seconds == minSeconds) {
      resetTimer();
    }

    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (seconds == 0) {
          stopTimer(true);
          setState(() {
            showTime = "";
          });
          loadQrCode();
        } else {
          setState(() {
            seconds--;
          });

          int min = seconds ~/ 60;
          int sec = seconds % 60;
          String parsedTime = "$min : ${getParsedTime(sec.toString())}";
          setState(() {
            showTime = parsedTime;
          });
        }
      },
    );
  }

  String getParsedTime(String time) {
    if (time.length <= 1) return "0$time";
    return time;
  }

  void stopTimer(bool reset) {
    if (reset) {
      resetTimer();
    }

    setState(() {
      timer?.cancel();
    });
  }

  void resetTimer() {
    setState(() {
      seconds = 300;
      // seconds = 20;
    });
  }
}
