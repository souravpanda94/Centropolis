import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:http/http.dart' as http;
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_modal.dart';



class FindPassword extends StatefulWidget {
  const FindPassword({super.key});

  @override
  State<FindPassword> createState() => _FindPasswordState();
}

class _FindPasswordState extends State<FindPassword> {
  TextEditingController emailIDController = TextEditingController();
  TextEditingController idController = TextEditingController();
  bool isLoading = false;
  late String language;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.greyColor1,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isLoading,
      child: Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: tr("IDHeading"),
                  style: const TextStyle(
                      fontFamily: 'Bold',
                      fontSize: 14,
                      color: CustomColors.textColor8),
                  children: const [
                    TextSpan(
                        text: ' *',
                        style: TextStyle(
                            color: CustomColors.headingColor, fontSize: 12))
                  ]),
              maxLines: 1,
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: idController,
              maxLength: 16,
              cursorColor: CustomColors.textColorBlack2,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
                fillColor: CustomColors.whiteColor,
                filled: true,
                contentPadding: const EdgeInsets.all(16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                      color: CustomColors.dividerGreyColor, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                      color: CustomColors.dividerGreyColor, width: 1.0),
                ),
                hintText: tr('IDHint'),
                hintStyle: const TextStyle(
                  color: CustomColors.textColor3,
                  fontSize: 14,
                  fontFamily: 'Regular',
                ),
              ),
              style: const TextStyle(
                color: CustomColors.blackColor,
                fontSize: 14,
                fontFamily: 'Regular',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            RichText(
              text: TextSpan(
                  text: tr("email"),
                  style: const TextStyle(
                      fontFamily: 'Bold',
                      fontSize: 14,
                      color: CustomColors.textColor8),
                  children: const [
                    TextSpan(
                        text: ' *',
                        style: TextStyle(
                            color: CustomColors.headingColor, fontSize: 12))
                  ]),
              maxLines: 1,
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: emailIDController,
              cursorColor: CustomColors.textColorBlack2,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: CustomColors.whiteColor,
                filled: true,
                contentPadding: const EdgeInsets.all(16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                      color: CustomColors.dividerGreyColor, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                      color: CustomColors.dividerGreyColor, width: 1.0),
                ),
                hintText: tr('emailHint'),
                hintStyle: const TextStyle(
                  color: CustomColors.textColor3,
                  fontSize: 14,
                  fontFamily: 'Regular',
                ),
              ),
              style: const TextStyle(
                color: CustomColors.blackColor,
                fontSize: 14,
                fontFamily: 'Regular',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32, bottom: 16),
              child: CommonButton(
                  onCommonButtonTap: () {
                    findPasswordValidation();
                  },
                  buttonColor: CustomColors.buttonBackgroundColor,
                  buttonName: tr("findPassword"),
                  isIconVisible: false),
            ),
          ],
        ),
      ),
    ),);
  }

  void showUserIdErrorModal() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: tr("onlyValidIdIsAllowed"),
            description: "",
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  void showEmailErrorModal() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: tr("onlyValidEmailIsApplicable"),
            description: "",
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  void findPasswordValidation() {
    // if( idController.text.trim() == ""){
    if(!isValidUserId(idController.text.trim())){
      showUserIdErrorModal();
    }
    else if (!isValidEmail(emailIDController.text.trim())) {
      showEmailErrorModal();
    }
    else {
      callFindPasswordNetworkCheck();
    }
  }

  void callFindPasswordNetworkCheck() async {
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callFindIdApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callFindIdApi() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "username": idController.text.trim(),
      "email": emailIDController.text.trim(),
    };
    debugPrint("find password input ===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.findPasswordUrl, body, language.trim(), null);
    response.then((response) {
      var responseJson = json.decode(response.body);
      debugPrint("server response for find password ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          late String title, message;

          if (responseJson['title'] != null) {
            title = responseJson['title'].toString();
          }
          if (responseJson['message'] != null) {
            message = responseJson['message'].toString();
          }
          showSentUserPasswordModal(title, message);
        } else {
          if (responseJson['message'] != null) {
            debugPrint("Server error response ${responseJson['message']}");
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void showSentUserPasswordModal(String title, String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: title,
            description: message,
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              clearDataField();
              Navigator.pop(context);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  void clearDataField() {
    idController.clear();
    emailIDController.clear();
  }



}
