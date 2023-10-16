import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../models/user_info_model.dart';
import '../../providers/conference_history_details_provider.dart';
import '../../providers/user_info_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/constants.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/firebase_analytics_events.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_modal.dart';

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
  // String name = "";
  // String id = "";
  // String tenantCompanyId = "";
  // String tenantCompany = "";
  // String gender = "";
  String genderValue = "";
  // String email = "";
  // String contactNumber = "";
  bool nameValidation = false;
  UserInfoModel? userInfoModel;
  String mobile = "";

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    loadPersonalInformation();
  }

  @override
  Widget build(BuildContext context) {
    userInfoModel = Provider.of<UserInfoProvider>(context).getUserInformation;

    return GestureDetector(
      onTap: () => hideKeyboard(),
      child: LoadingOverlay(
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
                          fontFamily: 'SemiBold',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Container(
                      height: 46,
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
                          userInfoModel?.name.toString() ?? tr("name"),
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
                        tr("idHeading"),
                        style: const TextStyle(
                          fontSize: 14,
                          color: CustomColors.textColor8,
                          fontFamily: 'SemiBold',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Container(
                      height: 46,
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
                          userInfoModel?.username.toString() ?? tr('id'),
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
                        tr("tenantCompanyLounge"),
                        style: const TextStyle(
                          fontSize: 14,
                          color: CustomColors.textColor8,
                          fontFamily: 'SemiBold',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Container(
                      height: 46,
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
                          userInfoModel?.companyName.toString() ??
                              tr('tenantCompany'),
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
                        tr("gender"),
                        style: const TextStyle(
                          fontSize: 14,
                          color: CustomColors.textColor8,
                          fontFamily: 'SemiBold',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Container(
                      height: 46,
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
                    margin: const EdgeInsets.only(top: 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tr("email"),
                        style: const TextStyle(
                          fontSize: 14,
                          color: CustomColors.textColor8,
                          fontFamily: 'SemiBold',
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
                      height: 46.0,
                      child: TextField(
                        cursorColor: CustomColors.blackColor,
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
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tr("contactNo"),
                        style: const TextStyle(
                          fontSize: 14,
                          color: CustomColors.textColor8,
                          fontFamily: 'SemiBold',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8.0, bottom: 40),
                    child: SizedBox(
                      height: 46.0,
                      child: TextField(
                        cursorColor: CustomColors.blackColor,
                        controller: contactNumberController,
                        keyboardType: TextInputType.phone,
                        maxLength: 13,
                        decoration: InputDecoration(
                          counterText: "",
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
                        onChanged: (value) {
                          if (value.length == 11) {
                            setState(() {
                              contactNumberController.text =
                                  formatNumberStringWithDash(value);
                            });
                          }
                          contactNumberController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: contactNumberController.text.length));
                        },
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          floatingActionButton: yourButtonWidget(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  yourButtonWidget() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        height: 46,
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
            buttonName: tr("savebutton"),
            isIconVisible: false),
      ),
    );
  }

  void onSaveButtonClick() {
    hideKeyboard();

    mobile = contactNumberController.text.trim().replaceAll("-", "");

    if (emailController.text.trim().isEmpty) {
      showErrorModal(tr("emailValidation"));
    } else if (!isValidEmail(emailController.text.trim())) {
      showErrorModal(tr("onlyValidEmailIsApplicable"));
    } else if (mobile.isEmpty) {
      showErrorModal(tr("contactValidation"));
    } else if (!isValidPhoneNumber(mobile.trim()) ||
        !mobile.trim().startsWith("010")) {
      showErrorModal(tr("onlyValidContactInformationIsApplicable"));
    } else {
      checkNetworkConnectionForEditPersonalInfo();
    }
  }

  void showErrorModal(String heading) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: heading,
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
  void showSuccesModal(String heading) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: heading,
            description: "",
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
              Navigator.pop(context);

            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  void checkNetworkConnectionForEditPersonalInfo() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callEditPersonalInfoApi();
    } else {
       //showCustomToast(fToast, context, tr("noInternetConnection"), "");
       showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callEditPersonalInfoApi() {
    setState(() {
      isLoading = true;
    });
    mobile = contactNumberController.text.trim().replaceAll("-", "");

    Map<String, String> body = {
      "email": emailController.text.trim(),
      "mobile": mobile.trim(),
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
           showSuccesModal(responseJson['message'].toString());
          }
          setFirebaseEvents(eventName: "cp_edit_personal_information");

        } else {
          if (responseJson['message'] != null) {
            debugPrint("Server error response ${responseJson['message']}");
              // showCustomToast(
              //     fToast, context, responseJson['message'].toString(), "");
              showErrorCommonModal(context: context,
                  heading :responseJson['message'].toString(),
                  description: "",
                  buttonName: tr("check"));
          }
        }
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(context: context,
          heading: tr("errorDescription"),
          description:"",
          buttonName : tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  void loadPersonalInformation() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadPersonalInformationApi();
    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
       showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callLoadPersonalInformationApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};

    debugPrint("Get personal info input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getPersonalInfoUrl, body, language, apiKey.trim());
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Get personal info ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          UserInfoModel userInfoModel = UserInfoModel.fromJson(responseJson);
          Provider.of<UserInfoProvider>(context, listen: false)
              .setItem(userInfoModel);

          setDataField(userInfoModel);
        } else {
          if (responseJson['message'] != null) {
             debugPrint("Server error response ${responseJson['message']}");
              // showCustomToast(
              //     fToast, context, responseJson['message'].toString(), "");
              showErrorCommonModal(context: context,
                  heading :responseJson['message'].toString(),
                  description: "",
                  buttonName: tr("check"));
          }
        }
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(context: context,
          heading: tr("errorDescription"),
          description:"",
          buttonName : tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  void setDataField(UserInfoModel userInfoModel) {
    if (userInfoModel.gender.toString() == "m") {
      genderValue = tr("male");
    } else if (userInfoModel.gender.toString() == "f") {
      genderValue = tr("female");
    }
    emailController =
        TextEditingController(text: userInfoModel.email.toString());
    contactNumberController = TextEditingController(
        text: formatNumberStringWithDash(userInfoModel.mobile.toString()));
  }

  
}
