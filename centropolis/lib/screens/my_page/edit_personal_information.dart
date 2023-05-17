import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/constants.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';

class EditPersonalInformationScreen extends StatefulWidget {
  const EditPersonalInformationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditPersonalInformationScreenState();
  }
}

class _EditPersonalInformationScreenState
    extends State<EditPersonalInformationScreen> {
  late String apiKey, language;
  late FToast fToast;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  String name = "";
  String id = "";
  String tenantCompanyId = "";
  String tenantCompany = "";
  String gender = "";
  String genderValue = "";
  String email = "";
  String contactNumber = "";
  bool nameValidation = false;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    setDataIntoFields();
  }

  void setDataIntoFields() {
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    name = user.userData['name'].toString();
    id = user.userData['user_id'].toString();
    tenantCompanyId = user.userData['company_id'].toString();
    tenantCompany = user.userData['company_name'].toString();
    gender = user.userData['gender'].toString();
    email = user.userData['email_key'].toString();
    contactNumber = user.userData['mobile'].toString();
    emailController = TextEditingController(text: email);
    contactNumberController = TextEditingController(text: contactNumber);
    if(gender == "m"){
      genderValue = tr("male");
    }else if(gender == "f"){
      genderValue = tr("female");
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
              child: CommonAppBar(tr("editPersonalInformation"), false, () {
                onBackButtonPress(context);
              }, () {}),
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(bottom: 45.0),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
              ),
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tr("name"),
                      style: const TextStyle(
                        fontSize: 14,
                        color: CustomColors.textColor8,
                        fontFamily: 'Medium',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                    height: 47,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                        color: CustomColors.backgroundColor,
                        border: Border.all(
                          color: CustomColors.dividerGreyColor,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    child: Center(
                        child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name ?? tr("name"),
                        style: const TextStyle(
                          color: CustomColors.blackColor,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                    ))),
                Container(
                  margin: const EdgeInsets.only(top: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tr("id"),
                      style: const TextStyle(
                        fontSize: 14,
                        color: CustomColors.textColor8,
                        fontFamily: 'Medium',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                    height: 47,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                        color: CustomColors.backgroundColor,
                        border: Border.all(
                          color: CustomColors.dividerGreyColor,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    child: Center(
                        child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        id ?? tr('id'),
                        style: const TextStyle(
                          color: CustomColors.blackColor,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                    ))),
                Container(
                  margin:
                      const EdgeInsets.only(top: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tr("tenantCompany"),
                      style: const TextStyle(
                        fontSize: 14,
                        color: CustomColors.textColor8,
                        fontFamily: 'Medium',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                    height: 47,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                        color: CustomColors.backgroundColor,
                        border: Border.all(
                          color: CustomColors.dividerGreyColor,
                        ),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(4))),
                    child: Center(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                             tenantCompany ?? tr('tenantCompany'),
                            style: const TextStyle(
                              color: CustomColors.blackColor,
                              fontSize: 14,
                              fontFamily: 'Regular',
                            ),
                          ),
                        ))),
                Container(
                  margin:
                      const EdgeInsets.only(top: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tr("gender"),
                      style: const TextStyle(
                        fontSize: 14,
                        color: CustomColors.textColor8,
                        fontFamily: 'Medium',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                    height: 47,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                        color: CustomColors.backgroundColor,
                        border: Border.all(
                          color: CustomColors.dividerGreyColor,
                        ),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(4))),
                    child: Center(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            genderValue ?? tr('gender'),
                            style: const TextStyle(
                              color: CustomColors.blackColor,
                              fontSize: 14,
                              fontFamily: 'Regular',
                            ),
                          ),
                        ))),
                Container(
                  margin:
                      const EdgeInsets.only(top: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tr("email"),
                      style: const TextStyle(
                        fontSize: 14,
                        color: CustomColors.textColor8,
                        fontFamily: 'Medium',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: SizedBox(
                    height: 47.0,
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        fillColor: CustomColors.whiteColor,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 15.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(
                              color: nameValidation
                                  ? CustomColors.textColor6
                                  : CustomColors.dividerGreyColor,
                              width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(
                              color: nameValidation
                                  ? CustomColors.textColor6
                                  : CustomColors.dividerGreyColor,
                              width: 1.0),
                        ),
                        hintText: "test1@centropolis.com",
                        hintStyle: const TextStyle(
                          color: CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.textColor8,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                      onChanged: (text) => {
                        setState(() {
                          email = text;
                        }),
                      },
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(top: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tr("contactNo"),
                      style: const TextStyle(
                        fontSize: 14,
                        color: CustomColors.textColor8,
                        fontFamily: 'Medium',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: SizedBox(
                    height: 47.0,
                    child: TextField(
                      controller: contactNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        fillColor: CustomColors.whiteColor,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 15.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(
                              color: nameValidation
                                  ? CustomColors.textColor6
                                  : CustomColors.dividerGreyColor,
                              width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(
                              color: nameValidation
                                  ? CustomColors.textColor6
                                  : CustomColors.dividerGreyColor,
                              width: 1.0),
                        ),
                        hintText: "010-0000-0000",
                        hintStyle: const TextStyle(
                          color: CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.textColor8,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                      onChanged: (text) => {
                        setState(() {
                          contactNumber = text;
                        }),
                      },
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
        floatingActionButton: yourButtonWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  yourButtonWidget() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        height: 52,
        width: double.infinity,
        margin: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
        ),
        child: CommonButton(
            onCommonButtonTap: () {
              onSaveButtonClick();
            },
            buttonColor: CustomColors.buttonBackgroundColor,
            buttonName: tr("save"),
            isIconVisible: false),
      ),
    );
  }

  void onSaveButtonClick() {
    hideKeyboard();
    if (!isValidEmail(email)) {
      showCustomToast(fToast, context, "Please enter valid email", "");
    } else if (!isValidPhoneNumber(contactNumber)) {
      showCustomToast(fToast, context, "Please enter valid contact number", "");
    } else {
      checkNetworkConnectionForEditPersonalInfo();
    }
  }

  void checkNetworkConnectionForEditPersonalInfo() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callEditPersonalInfoApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callEditPersonalInfoApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "email": email.trim(),
      "mobile": contactNumber.trim(),
    };

    debugPrint("Edit personal info input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.updatePersonalInfoUrl, body, language, apiKey.trim());
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Edit personal info ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
          Navigator.pop(context);
        } else {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isLoading = false;
      });
    });
  }

}
