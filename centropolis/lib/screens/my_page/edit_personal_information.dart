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
  late String apiKey, userId, language;
  late FToast fToast;
  bool isLoading = false;
  String name = "";
  String id = "";
  String tenantCompany = "";
  String gender = "";
  String email = "";
  String contactNumber = "";
  bool nameValidation = false;

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
              child: Column(children: [
            Container(
              margin: const EdgeInsets.only(
                top: 20.0,
                left: 15.0,
                right: 15.0,
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
              margin: const EdgeInsets.only(
                top: 8.0,
                left: 15.0,
                right: 15.0,
              ),
              child: SizedBox(
                height: 47.0,
                child: TextField(
                  keyboardType: TextInputType.name,
                  obscureText: true,
                  maxLength: 16,
                  decoration: InputDecoration(
                    counterText: '',
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
                    hintText: "name",
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
                      name = text;
                    }),
                  },
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
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
              margin: const EdgeInsets.only(
                top: 8.0,
                left: 15.0,
                right: 15.0,
              ),
              child: SizedBox(
                height: 47.0,
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
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
                    hintText: "test1",
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
                      id = text;
                    }),
                  },
                ),
              ),
            ),


                Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
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
                  margin: const EdgeInsets.only(
                    top: 8.0,
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: SizedBox(
                    height: 47.0,
                    child: TextField(
                      keyboardType: TextInputType.visiblePassword,
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
                        hintText: "CBRE",
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
                          tenantCompany = text;
                        }),
                      },
                    ),
                  ),
                ),


                Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
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
                  margin: const EdgeInsets.only(
                    top: 8.0,
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: SizedBox(
                    height: 47.0,
                    child: TextField(
                      keyboardType: TextInputType.visiblePassword,
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
                        hintText: "Male",
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
                          gender = text;
                        }),
                      },
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
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
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: SizedBox(
                    height: 47.0,
                    child: TextField(
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
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
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
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: SizedBox(
                    height: 47.0,
                    child: TextField(
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





          ])),
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
            onCommonButtonTap: () {},
            buttonColor: CustomColors.buttonBackgroundColor,
            buttonName: tr("save"),
            isIconVisible: false),),
    );
  }

}
