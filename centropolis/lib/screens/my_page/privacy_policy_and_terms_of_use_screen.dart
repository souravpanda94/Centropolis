import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';

class PrivacyPolicyAndTermsOfUseScreen extends StatefulWidget {
  final String pageTitle;
  const PrivacyPolicyAndTermsOfUseScreen(this.pageTitle, {super.key});

  @override
  State<PrivacyPolicyAndTermsOfUseScreen> createState() =>
      _PrivacyPolicyAndTermsOfUseScreenState();
}

class _PrivacyPolicyAndTermsOfUseScreenState extends State<PrivacyPolicyAndTermsOfUseScreen> {
  late String apiKey, userId, language;
  late FToast fToast;
  bool isLoading = false;
  String dataContent = "";

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();

    if(widget.pageTitle == tr("privacyPolicy")){
      loadDataContent("privacy_policy");
    }
    else if(widget.pageTitle == tr("termsOfUse")){
      loadDataContent("term_of_use");
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        opacity: 0.5,
        color: CustomColors.textColor3,
        progressIndicator: const CircularProgressIndicator(
          color: CustomColors.blackColor,
        ),
        isLoading: isLoading,
        child: Scaffold(
            backgroundColor: CustomColors.whiteColor,
            appBar: PreferredSize(
              preferredSize: AppBar().preferredSize,
              child: SafeArea(
                child: Container(
                  color: CustomColors.whiteColor,
                  child: CommonAppBar(widget.pageTitle, false, () {
                    onBackButtonPress(context);
                  }, () {}),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 20),
                child: Text(
                  dataContent,
                  style: const TextStyle(
                    fontSize: 14,
                    color: CustomColors.greyColor1,
                    fontFamily: 'Regular',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            )));
  }

  void loadDataContent(String type) async{
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadDataContentApi(type);
    } else {
    showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }



  void callLoadDataContentApi(String type) {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      // "cms_key":"privacy_policy/terms_of_user/signup_terms",
      "cms_key": type,
    };

    debugPrint("$type input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.privacyPolicyAndTermsOfUseUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for $type ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {

          if(language == "en"){
            if( responseJson['description_en'] != null) {
              setState(() {
                dataContent = responseJson['description_en'].toString();
              });
            }
          }else{
            if( responseJson['description_ko'] != null) {
              setState(() {
                dataContent = responseJson['description_ko'].toString();
              });
            }
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


}
