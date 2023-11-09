import 'dart:convert';
import 'package:centropolis/widgets/common_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import '../../models/user_info_model.dart';
import '../../providers/user_info_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/firebase_analytics_events.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button_with_border.dart';
import '../../widgets/common_modal.dart';

class VisitReservationApplication extends StatefulWidget {
  const VisitReservationApplication({super.key});

  @override
  State<VisitReservationApplication> createState() =>
      _VisitReservationApplicationState();
}

class _VisitReservationApplicationState
    extends State<VisitReservationApplication> {
  TextEditingController consentController = TextEditingController();
  TextEditingController visitorNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController purposeVisitController = TextEditingController();
  late String language, apiKey, companyId;
  late FToast fToast;
  bool isLoading = true;
  bool isChecked = false;
  String? timeSelectedValue;
  String? purposeSelectedValue;

  DateTime kFirstDay = DateTime.now();
  DateTime kLastDay = DateTime.utc(2030, 3, 14);
  DateTime focusedDate = DateTime.now();
  CalendarFormat selectedCalendarFormat = CalendarFormat.month;
  DateTime? selectedDate;
  // String personalInformationContent = "";
  List<dynamic> floorList = [];
  List<dynamic> visitTimeList = [];
  List<dynamic> visitPurposeList = [];
  String? currentSelectedFloor;
  String visitedPersonName = "";
  String visitedPersonCompanyName = "";
  String visitedPersonBuilding = "";
  String visitedPersonBuildingKey = "";
  String visitedPersonId = "";
  String visitedPersonCompanyId = "";
  bool isLoadingRequired = false;
  bool tooltip = false;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    companyId = user.userData['company_id'].toString();
    internetCheckingForMethods();
  }

  void internetCheckingForMethods() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadPersonalDataApi();
      callLoadFloorListApi();
      callLoadVisitTimeListApi();
      callLoadVisitPurposeListApi();
    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: GestureDetector(
        onTap: () => hideKeyboard(),
        child: LoadingOverlay(
          opacity: 0.5,
          color: CustomColors.textColor4,
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
                  child: CommonAppBar(tr("visitReservationApplication"), false,
                      () {
                    //onBackButtonPress(context);
                    Navigator.pop(context, isLoadingRequired);
                  }, () {}),
                ),
              ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              color: CustomColors.whiteColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                                color: CustomColors.backgroundColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 9),
                                      child: Icon(
                                        Icons.circle,
                                        color: CustomColors.textColorBlack2,
                                        size: 5,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      child: Text(
                                        tr("visitReservationApplicationInfo1"),
                                        style: const TextStyle(
                                            height: 1.5,
                                            fontFamily: 'Regular',
                                            fontSize: 14,
                                            color:
                                                CustomColors.textColorBlack2),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 9),
                                      child: Icon(
                                        Icons.circle,
                                        color: CustomColors.textColorBlack2,
                                        size: 5,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      child: Text(
                                        tr("visitReservationApplicationInfo2"),
                                        style: const TextStyle(
                                            height: 1.5,
                                            fontFamily: 'Regular',
                                            fontSize: 14,
                                            color:
                                                CustomColors.textColorBlack2),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 9),
                                      child: Icon(
                                        Icons.circle,
                                        color: CustomColors.textColorBlack2,
                                        size: 5,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      child: Text(
                                        tr("visitReservationApplicationInfo3"),
                                        style: const TextStyle(
                                            height: 1.5,
                                            fontFamily: 'Regular',
                                            fontSize: 14,
                                            color:
                                                CustomColors.textColorBlack2),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 9),
                                      child: Icon(
                                        Icons.circle,
                                        color: CustomColors.textColorBlack2,
                                        size: 5,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      child: Text(
                                        tr("visitReservationApplicationInfo4"),
                                        style: const TextStyle(
                                            height: 1.5,
                                            fontFamily: 'Regular',
                                            fontSize: 14,
                                            color:
                                                CustomColors.textColorBlack2),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            tr("signUpConsent"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 16,
                                color: CustomColors.textColor8),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            tr("visitReservationApplicationWarning"),
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8, bottom: 16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: CustomColors.dividerGreyColor,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            height: 264,
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  // personalInformationContent,
                                  tr("signup_personal_info"),
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      height: 1.5,
                                      color: CustomColors.textColor3),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: language == 'ko'
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: language == 'ko' ? 0 : 2),
                                child: SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: Checkbox(
                                      checkColor: CustomColors.whiteColor,
                                      activeColor:
                                          CustomColors.buttonBackgroundColor,
                                      side: const BorderSide(
                                          color: CustomColors.greyColor,
                                          width: 1),
                                      value: isChecked,
                                      onChanged: (value) {
                                        setState(() {
                                          isChecked = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 9,
                              ),
                              Flexible(
                                child: Text(
                                  tr("visitReservationApplicationConsent"),
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColorBlack2),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                      color: CustomColors.backgroundColor,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: CustomColors.whiteColor,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr("personInChargeInformation"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 16,
                                color: CustomColors.textColor8),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            padding: const EdgeInsets.only(
                                top: 14, left: 16, right: 16, bottom: 16),
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                color: CustomColors.backgroundColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(tr("nameOfPersonInCharge"),
                                        style: const TextStyle(
                                            fontFamily: 'SemiBold',
                                            fontSize: 14,
                                            color: CustomColors.textColor8)),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6),
                                      child: Text(" *",
                                          style: TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 14,
                                              color:
                                                  CustomColors.headingColor)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  visitedPersonName,
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColorBlack2),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(tr("tenantCompany"),
                                        style: const TextStyle(
                                            fontFamily: 'SemiBold',
                                            fontSize: 14,
                                            color: CustomColors.textColor8)),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6),
                                      child: Text(" *",
                                          style: TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 14,
                                              color:
                                                  CustomColors.headingColor)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  visitedPersonCompanyName,
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColorBlack2),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(tr("visitBuilding"),
                                        style: const TextStyle(
                                            fontFamily: 'SemiBold',
                                            fontSize: 14,
                                            color: CustomColors.textColor8)),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 6),
                                      child: Text(" *",
                                          style: TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 14,
                                              color:
                                                  CustomColors.headingColor)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  visitedPersonBuilding,
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColorBlack2),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                      color: CustomColors.backgroundColor,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: CustomColors.whiteColor,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr("visitorInformation"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 16,
                                color: CustomColors.textColor8),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("visitorName"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            height: 46,
                            child: TextField(
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.allow(
                              //       RegExp("[a-zA-Z_\\s-]")),
                              // ],
                              controller: visitorNameController,
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
                                      color: CustomColors.dividerGreyColor,
                                      width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      color: CustomColors.dividerGreyColor,
                                      width: 1.0),
                                ),
                                hintText: tr('visitorNameHint'),
                                hintStyle: const TextStyle(
                                  height: 1.5,
                                  color: CustomColors.textColor3,
                                  fontSize: 14,
                                  fontFamily: 'Regular',
                                ),
                              ),
                              style: const TextStyle(
                                height: 1.5,
                                color: CustomColors.blackColor,
                                fontSize: 14,
                                fontFamily: 'Regular',
                              ),
                              onTap: () {
                                if (tooltip) {
                                  setState(() {
                                    tooltip = false;
                                  });
                                }
                              },
                              onTapOutside: (event) {
                                hideKeyboard();
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("companyName"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            height: 46,
                            child: TextField(
                              controller: companyNameController,
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
                                      color: CustomColors.dividerGreyColor,
                                      width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      color: CustomColors.dividerGreyColor,
                                      width: 1.0),
                                ),
                                hintText: tr('companyNameHint'),
                                hintStyle: const TextStyle(
                                  height: 1.5,
                                  color: CustomColors.textColor3,
                                  fontSize: 14,
                                  fontFamily: 'Regular',
                                ),
                              ),
                              style: const TextStyle(
                                height: 1.5,
                                color: CustomColors.blackColor,
                                fontSize: 14,
                                fontFamily: 'Regular',
                              ),
                              onTap: () {
                                if (tooltip) {
                                  setState(() {
                                    tooltip = false;
                                  });
                                }
                              },
                              onTapOutside: (event) {
                                hideKeyboard();
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("email"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            height: 46,
                            child: TextField(
                              controller: emailController,
                              cursorColor: CustomColors.textColorBlack2,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: CustomColors.whiteColor,
                                filled: true,
                                contentPadding: const EdgeInsets.all(16),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      color: CustomColors.dividerGreyColor,
                                      width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      color: CustomColors.dividerGreyColor,
                                      width: 1.0),
                                ),
                                hintText: tr('emailDemoHint'),
                                hintStyle: const TextStyle(
                                  height: 1.5,
                                  color: CustomColors.textColor3,
                                  fontSize: 14,
                                  fontFamily: 'Regular',
                                ),
                              ),
                              style: const TextStyle(
                                height: 1.5,
                                color: CustomColors.blackColor,
                                fontSize: 14,
                                fontFamily: 'Regular',
                              ),
                              onTap: () {
                                if (tooltip) {
                                  setState(() {
                                    tooltip = false;
                                  });
                                }
                              },
                              onTapOutside: (event) {
                                hideKeyboard();
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("contact"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            height: 46,
                            child: TextField(
                              controller: contactController,
                              cursorColor: CustomColors.textColorBlack2,
                              keyboardType: TextInputType.number,
                              maxLength: 11,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                fillColor: CustomColors.whiteColor,
                                filled: true,
                                contentPadding: const EdgeInsets.all(16),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      color: CustomColors.dividerGreyColor,
                                      width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      color: CustomColors.dividerGreyColor,
                                      width: 1.0),
                                ),
                                hintText: tr('contactHint'),
                                hintStyle: const TextStyle(
                                  height: 1.5,
                                  color: CustomColors.textColor3,
                                  fontSize: 14,
                                  fontFamily: 'Regular',
                                ),
                              ),
                              style: const TextStyle(
                                height: 1.5,
                                color: CustomColors.blackColor,
                                fontSize: 14,
                                fontFamily: 'Regular',
                              ),
                              onTap: () {
                                setState(() {
                                  tooltip = true;
                                });
                              },
                              onTapOutside: (event) {
                                hideKeyboard();
                                setState(() {
                                  tooltip = false;
                                });
                              },
                            ),
                          ),
                          if (tooltip)
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                tr("contactTooltip"),
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 12,
                                    color: CustomColors.blackColor),
                              ),
                            ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("dateOfVisit"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            height: 46,
                            child: TextField(
                              controller: dateController,
                              readOnly: true,
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
                                      color: CustomColors.dividerGreyColor,
                                      width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      color: CustomColors.dividerGreyColor,
                                      width: 1.0),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: SvgPicture.asset(
                                    "assets/images/ic_date.svg",
                                    width: 8,
                                    height: 4,
                                    color: CustomColors.textColorBlack2,
                                  ),
                                ),
                                hintText: "YYYY.MM.DD",
                                hintStyle: const TextStyle(
                                  height: 1.5,
                                  color: CustomColors.textColor3,
                                  fontSize: 14,
                                  fontFamily: 'Regular',
                                ),
                              ),
                              style: const TextStyle(
                                height: 1.5,
                                color: CustomColors.blackColor,
                                fontSize: 14,
                                fontFamily: 'Regular',
                              ),
                              onTap: () {
                                hideKeyboard();
                                openDatePickerWidget();
                              },
                              onTapOutside: (event) {
                                hideKeyboard();
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("visitTime"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          visitTimeDropdownWidget(),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("purposeOfVisit"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          purposeVisitDropdownWidget(),
                          Container(
                            margin: const EdgeInsets.only(top: 14, bottom: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(tr("visitingFloor"),
                                    style: const TextStyle(
                                        fontFamily: 'SemiBold',
                                        fontSize: 14,
                                        color: CustomColors.textColor8)),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 6),
                                  child: Text(" *",
                                      style: TextStyle(
                                          fontFamily: 'Regular',
                                          fontSize: 14,
                                          color: CustomColors.headingColor)),
                                ),
                              ],
                            ),
                          ),
                          visitFloorDropdownWidget(),
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                      color: CustomColors.backgroundColor,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      alignment: FractionalOffset.bottomCenter,
                      width: MediaQuery.of(context).size.width,
                      color: CustomColors.whiteColor,
                      padding: const EdgeInsets.only(
                          top: 16, left: 16, right: 16, bottom: 40),
                      child: CommonButton(
                        onCommonButtonTap: () {
                          visitReservationValidationCheck();
                        },
                        buttonColor: CustomColors.buttonBackgroundColor,
                        buttonName: tr("makeVisitorReservation"),
                        isIconVisible: false,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  visitTimeDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          tr('visitTimeHint'),
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: visitTimeList
            .map((item) => DropdownMenuItem<String>(
                  value: item.toString(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 9),
                        child: Text(
                          item.toString(),
                          style: const TextStyle(
                            color: CustomColors.blackColor,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      if (item != visitTimeList.last)
                        const Divider(
                          thickness: 1,
                          height: 1,
                          color: CustomColors.dividerGreyColor,
                        )
                    ],
                  ),
                ))
            .toList(),
        value: timeSelectedValue,
        onChanged: (value) {
          setState(() {
            timeSelectedValue = value.toString();
          });
        },
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          isOverButton: false,
          elevation: 0,
          padding: const EdgeInsets.only(top: 0, bottom: 0),
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              border: Border.all(
                color: CustomColors.dividerGreyColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
        ),
        iconStyleData: IconStyleData(
            icon: Padding(
          padding: EdgeInsets.only(bottom: timeSelectedValue != null ? 12 : 0),
          child: SvgPicture.asset(
            "assets/images/ic_drop_down_arrow.svg",
            width: 8,
            height: 8,
            color: CustomColors.textColorBlack2,
          ),
        )),
        buttonStyleData: ButtonStyleData(
            height: 46,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColors.dividerGreyColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            padding: EdgeInsets.only(
                top: 10,
                right: 12,
                left: timeSelectedValue != null ? 0 : 13,
                bottom: timeSelectedValue != null ? 0 : 11),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          overlayColor:
              MaterialStatePropertyAll(CustomColors.dropdownHoverColor),
          padding: EdgeInsets.only(top: 14),
          height: 46,
        ),
      ),
    );
  }

  purposeVisitDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          visitPurposeList.isNotEmpty
              ? visitPurposeList.first["text"]
              : tr("businessDiscussion"),
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: visitPurposeList
            .map((item) => DropdownMenuItem<String>(
                  value: item["value"],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 9),
                        child: Text(
                          item["text"],
                          style: const TextStyle(
                            color: CustomColors.blackColor,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      if (item != visitPurposeList.last)
                        const Divider(
                          thickness: 1,
                          height: 1,
                          color: CustomColors.dividerGreyColor,
                        )
                    ],
                  ),
                ))
            .toList(),
        value: purposeSelectedValue,
        onChanged: (value) {
          setState(() {
            purposeSelectedValue = value as String;
          });
        },
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          isOverButton: false,
          elevation: 0,
          padding: const EdgeInsets.only(top: 0, bottom: 0),
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              border: Border.all(
                color: CustomColors.dividerGreyColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
        ),
        iconStyleData: IconStyleData(
            icon: Padding(
          padding:
              EdgeInsets.only(bottom: purposeSelectedValue != null ? 12 : 0),
          child: SvgPicture.asset(
            "assets/images/ic_drop_down_arrow.svg",
            width: 8,
            height: 8,
            color: CustomColors.textColorBlack2,
          ),
        )),
        buttonStyleData: ButtonStyleData(
            height: 46,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColors.dividerGreyColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            padding: EdgeInsets.only(
                top: 10,
                right: 12,
                left: purposeSelectedValue != null ? 0 : 13,
                bottom: purposeSelectedValue != null ? 0 : 11),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          overlayColor:
              MaterialStatePropertyAll(CustomColors.dropdownHoverColor),
          padding: EdgeInsets.only(top: 14),
          height: 46,
        ),
      ),
    );
  }

  visitFloorDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          tr("floor"),
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: floorList
            .map((item) => DropdownMenuItem<String>(
                  value: item["floor"],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 9),
                        child: Text(
                          item["floor"].toString().toUpperCase(),
                          style: const TextStyle(
                            color: CustomColors.blackColor,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      if (item != floorList.last)
                        const Divider(
                          thickness: 1,
                          height: 1,
                          color: CustomColors.dividerGreyColor,
                        )
                    ],
                  ),
                ))
            .toList(),
        value: currentSelectedFloor,
        onChanged: (value) {
          setState(() {
            currentSelectedFloor = value as String;
          });
        },
        dropdownStyleData: DropdownStyleData(
          maxHeight: 130,
          isOverButton: false,
          elevation: 0,
          padding: const EdgeInsets.only(top: 0, bottom: 0),
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              border: Border.all(
                color: CustomColors.dividerGreyColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
        ),
        iconStyleData: IconStyleData(
            icon: Padding(
          padding:
              EdgeInsets.only(bottom: currentSelectedFloor != null ? 12 : 0),
          child: SvgPicture.asset(
            "assets/images/ic_drop_down_arrow.svg",
            width: 8,
            height: 8,
            color: CustomColors.textColorBlack2,
          ),
        )),
        buttonStyleData: ButtonStyleData(
            height: 46,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColors.dividerGreyColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            padding: EdgeInsets.only(
                top: 10,
                right: 12,
                left: currentSelectedFloor != null ? 0 : 13,
                bottom: currentSelectedFloor != null ? 0 : 11),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          overlayColor:
              MaterialStatePropertyAll(CustomColors.dropdownHoverColor),
          padding: EdgeInsets.only(top: 14),
          height: 46,
        ),
      ),
    );
  }

  openDatePickerWidget() {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TableCalendar(
                      availableGestures: AvailableGestures.horizontalSwipe,
                      locale: Localizations.localeOf(context).languageCode,
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month'
                      },
                      weekendDays: const [DateTime.sunday, DateTime.saturday],
                      daysOfWeekHeight: 50,
                      focusedDay: focusedDate,
                      calendarFormat: selectedCalendarFormat,
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        leftChevronPadding: EdgeInsets.zero,
                        rightChevronPadding: EdgeInsets.zero,
                        leftChevronIcon: SvgPicture.asset(
                          "assets/images/ic_back.svg",
                          width: 0,
                          height: 18,
                          color: kFirstDay.month == focusedDate.month
                              ? CustomColors.dividerGreyColor
                              : CustomColors.greyColor,
                        ),
                        rightChevronIcon: SvgPicture.asset(
                          "assets/images/ic_right_arrow.svg",
                          width: 0,
                          height: 18,
                          color: CustomColors.greyColor,
                        ),
                        titleTextStyle: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 16,
                            color: Colors.black),
                        titleTextFormatter: (date, locale) {
                          return "${DateFormat.y(locale).format(date)}.${DateFormat.M(locale).format(date).length == 1 ? "0" : ""}${DateFormat.M(locale).format(date)}";
                        },
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                          dowTextFormatter: (date, locale) =>
                              DateFormat.E(locale).format(date).toUpperCase(),
                          weekdayStyle: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Regular',
                            fontSize: 14,
                          ),
                          weekendStyle: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Regular',
                            fontSize: 14,
                          )),
                      calendarStyle: CalendarStyle(
                          rangeHighlightColor: CustomColors.backgroundColor2,
                          rangeStartDecoration: const BoxDecoration(
                              color: Color(0xffCC6047), shape: BoxShape.circle),
                          rangeEndDecoration: const BoxDecoration(
                              color: Color(0xffCC6047), shape: BoxShape.circle),
                          todayTextStyle: TextStyle(
                              color: focusedDate.compareTo(kFirstDay) != 0
                                  ? Colors.black
                                  : Colors.white),
                          weekendTextStyle:
                              const TextStyle(color: Color(0xffCC6047)),
                          disabledTextStyle:
                              const TextStyle(color: Colors.grey),
                          disabledDecoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          todayDecoration: BoxDecoration(
                              color: focusedDate.compareTo(kFirstDay) != 0
                                  ? Colors.white
                                  : const Color(0xffCC6047),
                              shape: BoxShape.circle),
                          selectedTextStyle:
                              const TextStyle(color: Colors.white),
                          selectedDecoration: const BoxDecoration(
                              color: Color(0xffCC6047), shape: BoxShape.circle),
                          defaultTextStyle: const TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                          )),
                      selectedDayPredicate: (day) {
                        if (isSameDay(day, focusedDate)) {
                          return true;
                        } else {
                          return false;
                        }
                      },
                      enabledDayPredicate: (day) {
                        if (day.weekday == DateTime.saturday ||
                            day.weekday == DateTime.sunday) {
                          return false;
                        } else if (day.day == kFirstDay.day &&
                            day.month == kFirstDay.month &&
                            day.year == kFirstDay.year) {
                          return true;
                        } else if (day.compareTo(kFirstDay) > 0) {
                          return true;
                        } else {
                          return false;
                        }
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          focusedDate = focusedDay;
                          selectedDate = selectedDay;
                        });
                      },
                      onFormatChanged: (format) {
                        if (selectedCalendarFormat != format) {
                          setState(() {
                            selectedCalendarFormat = format;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        setState(() {
                          focusedDate = focusedDay;
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: CommonButtonWithBorder(
                              buttonTextColor:
                                  CustomColors.buttonBackgroundColor,
                              buttonBorderColor:
                                  CustomColors.buttonBackgroundColor,
                              onCommonButtonTap: () {
                                Navigator.pop(context);
                              },
                              buttonColor: CustomColors.whiteColor,
                              buttonName: tr("cancel"),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            flex: 1,
                            child: CommonButton(
                              onCommonButtonTap: () {
                                selectedDate ??= focusedDate;
                                if (selectedDate != null) {
                                  dateController.text = DateFormat('yyyy.MM.dd')
                                      .format(selectedDate!);
                                }

                                Navigator.pop(context);
                              },
                              buttonColor: CustomColors.buttonBackgroundColor,
                              buttonName: tr("check"),
                              isIconVisible: false,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void visitReservationValidationCheck() {
    if (visitorNameController.text.trim().isEmpty) {
      showErrorModal(tr("visitorNameValidation"));
    } else if (companyNameController.text.trim().isEmpty) {
      showErrorModal(tr("companyNameValidation"));
    } else if (emailController.text.trim().isEmpty) {
      showErrorModal(tr("emailValidation"));
    } else if (!isValidEmail(emailController.text.trim())) {
      showErrorModal(tr("onlyValidEmailIsApplicable"));
    } else if (contactController.text.trim().isEmpty) {
      showErrorModal(tr("contactValidation"));
    } else if (!isValidPhoneNumber(contactController.text.trim()) ||
        !contactController.text.trim().startsWith("010")) {
      showErrorModal(tr("onlyValidContactInformationIsApplicable"));
    } else if (dateController.text.trim().isEmpty) {
      showErrorModal(tr("dateVisitValidation"));
    } else if (timeSelectedValue?.trim() == null ||
        timeSelectedValue?.trim() == "") {
      showErrorModal(tr("visitTimeValidation"));
    } else if (purposeSelectedValue?.trim() == null &&
        visitPurposeList.isEmpty) {
      showErrorModal(tr("purposeVisitValidation"));
    } else if (currentSelectedFloor?.trim() == null ||
        currentSelectedFloor?.trim() == "") {
      showErrorModal(tr("pleaseSelectFloor"));
    } else if (!isChecked) {
      showErrorModal(tr("pleaseConsentToCollect"));
    } else {
      networkCheckForVisitReservation();
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

  // void loadPersonalInformation() async {
  //   final InternetChecking internetChecking = InternetChecking();
  //   if (await internetChecking.isInternet()) {
  //     callLoadPersonalInformationApi();
  //   } else {
  //     showCustomToast(fToast, context, tr("noInternetConnection"), "");
  //   }
  // }
  //
  // void callLoadPersonalInformationApi() {
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   Map<String, String> body = {
  //     "cms_key": "signup_terms",
  //   };
  //
  //   debugPrint("get Personal Information input ===> $body");
  //
  //   Future<http.Response> response = WebService().callPostMethodWithRawData(
  //       ApiEndPoint.getPersonalInformationUrl, body, language.toString(), null);
  //   response.then((response) {
  //     var responseJson = json.decode(response.body);
  //
  //     debugPrint(
  //         "server response for get Personal Information ===> $responseJson");
  //
  //     if (responseJson != null) {
  //       if (response.statusCode == 200 && responseJson['success']) {
  //         if (language == "en") {
  //           if (responseJson['description_en'] != null) {
  //             setState(() {
  //               personalInformationContent =
  //                   responseJson['description_en'].toString();
  //             });
  //           }
  //         } else {
  //           if (responseJson['description_ko'] != null) {
  //             setState(() {
  //               personalInformationContent =
  //                   responseJson['description_ko'].toString();
  //             });
  //           }
  //         }
  //       } else {
  //         if (responseJson['message'] != null) {
  //           showCustomToast(
  //               fToast, context, responseJson['message'].toString(), "");
  //         }
  //       }
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   }).catchError((onError) {
  //     debugPrint("catchError ================> $onError");
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  // }

  void networkCheckForVisitReservation() async {
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadVisitReservationApplicationApi();
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callLoadVisitReservationApplicationApi() {
    debugPrint("visitedPersonBuildingKey :: $visitedPersonBuildingKey");
    setState(() {
      isLoading = true;
    });
    String visitDate =
        "${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}";
    Map<String, String> body = {
      "visited_person_company_id":
          visitedPersonCompanyId.toString().trim(), //required
      "visited_person_user_id": visitedPersonId.toString().trim(), //required
      "visited_person_name": visitedPersonName.toString().trim(), //required
      "building": visitedPersonBuildingKey.toString().trim(), //required
      "floor": currentSelectedFloor ?? "", //required
      "visitor_name": visitorNameController.text.trim(), //required
      "visitor_company_name": companyNameController.text.trim(), //required
      "visitor_email": emailController.text.trim(), //required
      "visitor_mobile": contactController.text.trim(), //required
      "visit_date": visitDate, //required
      "visit_time": timeSelectedValue ?? "", //required
      "visit_purpose": purposeSelectedValue != null &&
              purposeSelectedValue.toString().isNotEmpty
          ? purposeSelectedValue.toString().trim()
          : visitPurposeList.first["value"].toString().trim() //required
    };

    debugPrint("Visit Reservation Application input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.visitReservationApplicationUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for Visit Reservation Application ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          consentController.clear;
          companyNameController.clear;
          visitorNameController.clear;
          timeController.clear;
          dateController.clear;
          emailController.clear;
          contactController.clear;
          purposeVisitController.clear;
          setState(() {
            isLoadingRequired = true;
          });
          if (responseJson['message'] != null) {
            showSuccessModal(responseJson['message']);
          }

          setFirebaseEventForVisitReservation(
              eventName: "cp_make_visit_reservation",
              visitReservationId: responseJson['reservation_id'] ?? "");
        } else {
          if (responseJson['message'] != null) {
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  void showSuccessModal(String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: message,
            description: "",
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
              Navigator.pop(context, isLoadingRequired);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  // void loadFloorList() async {
  //   final InternetChecking internetChecking = InternetChecking();
  //   if (await internetChecking.isInternet()) {
  //     callLoadFloorListApi();
  //   } else {
  //     //showCustomToast(fToast, context, tr("noInternetConnection"), "");
  //      showErrorCommonModal(
  //         context: context,
  //         heading: tr("noInternet"),
  //         description: tr("connectionFailedDescription"),
  //         buttonName: tr("check"));
  //   }
  // }

  void callLoadFloorListApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {
      "company_id": companyId.toString().trim(),
    };

    debugPrint("Floor List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getFloorListUrl, body, language.toString(), null);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Floor List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              floorList = responseJson['data'];
            });
          }
        } else {
          if (responseJson['message'] != null) {
            debugPrint("Server error response ${responseJson['message']}");
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  // void loadPersonalData() async {
  //   final InternetChecking internetChecking = InternetChecking();
  //   if (await internetChecking.isInternet()) {
  //     callLoadPersonalDataApi();
  //   } else {
  //     showCustomToast(fToast, context, tr("noInternetConnection"), "");
  //   }
  // }

  void callLoadPersonalDataApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};

    debugPrint("Get personal Data input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getPersonalInfoUrl, body, language, apiKey.trim());
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Get personal Data ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          UserInfoModel userInfoModel = UserInfoModel.fromJson(responseJson);
          Provider.of<UserInfoProvider>(context, listen: false)
              .setItem(userInfoModel);

          setDataField(userInfoModel);
        } else {
          if (responseJson['message'] != null) {
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
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
      if(mounted){
        showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      setState(() {
        isLoading = false;
      });
      }
    });
  }

  void setDataField(UserInfoModel userInfoModel) {
    visitedPersonName = userInfoModel.name.toString();
    visitedPersonCompanyName = userInfoModel.companyName.toString();
    visitedPersonBuilding = userInfoModel.building.toString();
    visitedPersonBuildingKey = userInfoModel.buildingKey.toString();
    visitedPersonId = userInfoModel.userId.toString();
    visitedPersonCompanyId = userInfoModel.companyId.toString();
  }

  // void loadVisitTimeList() async {
  //   final InternetChecking internetChecking = InternetChecking();
  //   if (await internetChecking.isInternet()) {
  //     callLoadVisitTimeListApi();
  //   } else {
  //     showCustomToast(fToast, context, tr("noInternetConnection"), "");
  //   }
  // }

  void callLoadVisitTimeListApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {};

    debugPrint("VisitTime List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.visitTimeListUrl, body, language.toString(), null);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for VisitTime List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              visitTimeList = responseJson['data'];
            });
            debugPrint("visitPurposeList ===> $visitTimeList");
          }
        } else {
          if (responseJson['message'] != null) {
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  // void loadVisitPurposeList() async {
  //   final InternetChecking internetChecking = InternetChecking();
  //   if (await internetChecking.isInternet()) {
  //     callLoadVisitPurposeListApi();
  //   } else {
  //     showCustomToast(fToast, context, tr("noInternetConnection"), "");
  //   }
  // }

  void callLoadVisitPurposeListApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {};

    debugPrint("VisitPurpose List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.visitPurposeListUrl, body, language.toString(), null);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for VisitPurpose List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              visitPurposeList = responseJson['data'];
            });
          }
        } else {
          if (responseJson['message'] != null) {
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }
}
