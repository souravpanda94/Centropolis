import 'dart:convert';
import 'dart:io';

import 'package:centropolis/utils/firebase_analytics_events.dart';
import 'package:centropolis/widgets/common_button.dart';
import 'package:centropolis/widgets/multi_select_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../models/user_info_model.dart';
import '../../providers/user_info_provider.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_modal.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../widgets/common_modal.dart';

class LightOutRequest extends StatefulWidget {
  const LightOutRequest({super.key});

  @override
  State<LightOutRequest> createState() => _LightOutRequestState();
}

class _LightOutRequestState extends State<LightOutRequest> {
  late String language, apiKey, companyId;
  String companyName = "";
  String name = "";
  String email = "";
  String mobile = "";
  late FToast fToast;
  bool isLoading = false;
  DateTime kFirstDay = DateTime.now();
  DateTime kLastDay = DateTime.utc(2030, 3, 14);
  DateTime focusedDate = DateTime.now();
  CalendarFormat selectedCalendarFormat = CalendarFormat.month;
  DateTime? selectedDate;
  bool isChecked = false;
  TextEditingController otherRequestController = TextEditingController();
  String reservationDate = "";
  String? floorSelectedValue;
  String? startTimeSelectedValue;
  String? endTimeSelectedValue;
  List<dynamic> floorList = [];
  List<dynamic> startTimeList = [];
  List<dynamic> usageTimeList = [];
  List<dynamic> selectedFloorList = [];
  bool isLoadingRequired = false;
  List<String> floorNamesList = [];
  List<String> _selectedFloors = [];

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    // email = user.userData['email_key'].toString();
    // mobile = user.userData['mobile'].toString();
    companyId = user.userData['company_id'].toString();
    //companyName = user.userData['company_name'].toString();
    //name = user.userData['name'].toString();
    loadPersonalInformation();
    loadStartTimeList();
    //loadUsageTimeList();
    loadFloorList();
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
                  child: CommonAppBar(tr("lightOutSubtitle"), false, () {
                    //onBackButtonPress(context);
                    Navigator.pop(context, isLoadingRequired);
                  }, () {}),
                ),
              ),
            ),
            body: SingleChildScrollView(
                primary: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
    
                    Container(
                    width: MediaQuery.of(context).size.width,
                    color: CustomColors.backgroundColor,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 200,
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            infoTextWidget(tr("vocInfoText1")),
                            infoTextWidget(tr("vocInfoText2")),
                            infoTextWidget(tr("vocInfoText3")),
                            infoTextWidget(tr("vocInfoText4")),
                            infoTextWidget(tr("vocInfoText5")),
                            
                                   
                          ],
                        ),
                      ),
                    ),
    
                    
                  ),
                    Container(
                      color: CustomColors.whiteColor,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tr("tenantCompanyInformation"),
                              style: const TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 16,
                                  color: CustomColors.textColor8)),
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            padding: const EdgeInsets.all(16),
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                color: CustomColors.backgroundColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tr("CoolingHeatingName"),
                                    style: const TextStyle(
                                        fontFamily: 'SemiBold',
                                        fontSize: 14,
                                        color: CustomColors.textColor8)),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  name,
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColorBlack2),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(tr("lightOutDetailCompany"),
                                    style: const TextStyle(
                                        fontFamily: 'SemiBold',
                                        fontSize: 14,
                                        color: CustomColors.textColor8)),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  companyName,
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColorBlack2),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(tr("email"),
                                    style: const TextStyle(
                                        fontFamily: 'SemiBold',
                                        fontSize: 14,
                                        color: CustomColors.textColor8)),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  email,
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColorBlack2),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(tr("contactNo"),
                                    style: const TextStyle(
                                        fontFamily: 'SemiBold',
                                        fontSize: 14,
                                        color: CustomColors.textColor8)),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  formatNumberStringWithDash(mobile),
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColorBlack2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: CustomColors.backgroundColor,
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr("applicationFloorLightOut"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 16,
                                color: CustomColors.textColor8),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          InkWell(
                            onTap: () {
                              _showMultiSelect();
                            },
                            child: Container(
                              height: 46,
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.0,
                                    color: CustomColors.dividerGreyColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: _selectedFloors.isEmpty
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Text(
                                                  tr('applicationFloorHint')))
                                          : Container(
                                              margin:
                                                  const EdgeInsets.only(left: 15),
                                              child: Wrap(
                                                runSpacing: 1.5,
                                                direction: Axis.vertical,
                                                children: _selectedFloors
                                                    .map((e) => Chip(
                                                          visualDensity:
                                                              VisualDensity
                                                                  .standard,
                                                          backgroundColor:
                                                              CustomColors
                                                                  .selectedColor,
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 5),
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              5))),
                                                          label: SizedBox(
                                                            width: 20,
                                                            child: Text(
                                                                e
                                                                    .toString()
                                                                    .toUpperCase(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'SemiBold',
                                                                    fontSize: 12,
                                                                    color: CustomColors
                                                                        .whiteColor)),
                                                          ),
                                                        ))
                                                    .toList(),
                                              ),
                                            )),
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.only(
                                        bottom:
                                            floorSelectedValue != null ? 16 : 0),
                                    child: SvgPicture.asset(
                                      "assets/images/ic_drop_down_arrow.svg",
                                      width: 8,
                                      height: 8,
                                      color: CustomColors.textColorBlack2,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          //floorDropdownWidget(),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: CustomColors.backgroundColor,
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr("dateOfApplicationLightOut"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 16,
                                color: CustomColors.textColor8),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          tableCalendarWidget(),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: CustomColors.backgroundColor,
                      height: 10,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr("timeOfApplication"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 16,
                                color: CustomColors.textColor8),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            tr("lightsOutStartTime"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          startTimeDropdownWidget(),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            tr("lightsOutEndTime"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          endTimeDropdownWidget(),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: CustomColors.backgroundColor,
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tr("otherRequests"),
                              style: const TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 16,
                                  color: CustomColors.textColor8)),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.only(top: 2, bottom: 2),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: CustomColors.dividerGreyColor,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            height: 288,
                            child: TextField(
                              controller: otherRequestController,
                              cursorColor: CustomColors.textColorBlack2,
                              keyboardType: TextInputType.multiline,
                              maxLines: 14,
                              decoration: InputDecoration(
                                hintMaxLines: 500,
                                border: InputBorder.none,
                                fillColor: CustomColors.whiteColor,
                                filled: true,
                                contentPadding: const EdgeInsets.all(16),
                                hintText: tr('otherRequestHint'),
                                hintStyle: const TextStyle(
                                  color: CustomColors.textColor3,
                                  fontSize: 14,
                                  fontFamily: 'Regular',
                                ),
                              ),
                              style: const TextStyle(
                                color: CustomColors.textColorBlack2,
                                fontSize: 14,
                                fontFamily: 'Regular',
                              ),
                              onTapOutside: (event) {
                                FocusScope.of(context).unfocus();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: CustomColors.backgroundColor,
                      height: 10,
                    ),
                    Container(
                      alignment: FractionalOffset.bottomCenter,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 40),
                      child: CommonButton(
                        onCommonButtonTap: () {
                          requestLightOutValidationCheck();
                          //showReservationModal();
                        },
                        buttonColor: CustomColors.buttonBackgroundColor,
                        buttonName: tr("apply"),
                        isIconVisible: false,
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }


   infoTextWidget(String text){
    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Icon(
                            Icons.circle,
                            size: 5,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            text,
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                height: 1.5,
                                color: CustomColors.textColor5),
                          ),
                        )
                      ]);
  }
  void showReservationModal(String heading, String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: heading,
            description: message,
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

  void _showMultiSelect() async {
    // final List<String> items = [
    //   'Flutter',
    //   'Node.js',
    //   'React Native',
    //   'Java',
    //   'Docker',
    //   'MySQL',
    // ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(
          items: floorNamesList,
          alreadySelectedItems: _selectedFloors,
        );
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedFloors = results;
      });
    }
  }

  floorDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          floorList.isNotEmpty ? floorList.first["floor"] : tr('floorHint'),
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
                        padding: const EdgeInsets.only(left: 16, bottom: 16),
                        child: Text(
                          item["floor"],
                          style: const TextStyle(
                            color: CustomColors.blackColor,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ))
            .toList(),
        value: floorSelectedValue,
        onChanged: (value) {
          setState(() {
            floorSelectedValue = value as String;
            if (!selectedFloorList.contains(floorSelectedValue)) {
              selectedFloorList.add(floorSelectedValue);
            }
          });
        },
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          isOverButton: false,
          elevation: 0,
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              border: Border.all(
                color: CustomColors.dividerGreyColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
        ),
        iconStyleData: IconStyleData(
            icon: Padding(
          padding: EdgeInsets.only(bottom: floorSelectedValue != null ? 16 : 0),
          child: SvgPicture.asset(
            "assets/images/ic_drop_down_arrow.svg",
            width: 8,
            height: 8,
            color: CustomColors.textColorBlack2,
          ),
        )),
        buttonStyleData: ButtonStyleData(
            height: 53,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColors.dividerGreyColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            padding: EdgeInsets.only(
                top: 16,
                right: 16,
                left: floorSelectedValue != null ? 0 : 16,
                bottom: floorSelectedValue != null ? 0 : 16),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.all(0),
          height: 53,
        ),
      ),
    );
  }

  startTimeDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          tr('selectStartTime'),
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: startTimeList
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 9),
                        child: Text(
                          item,
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
                      if (item != startTimeList.last)
                        const Divider(
                          thickness: 1,
                          height: 1,
                          color: CustomColors.dividerGreyColor,
                        )
                    ],
                  ),
                ))
            .toList(),
        value: startTimeSelectedValue,
        onChanged: (value) {
          setState(() {
            startTimeSelectedValue = value as String;
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
              EdgeInsets.only(bottom: startTimeSelectedValue != null ? 12 : 0),
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
                left: startTimeSelectedValue != null ? 0 : 13,
                bottom: startTimeSelectedValue != null ? 0 : 11),
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

  endTimeDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          tr('selectEndTime'),
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: startTimeList
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 9),
                        child: Text(
                          item,
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
                      if (item != startTimeList.last)
                        const Divider(
                          thickness: 1,
                          height: 1,
                          color: CustomColors.dividerGreyColor,
                        )
                    ],
                  ),
                ))
            .toList(),
        value: endTimeSelectedValue,
        onChanged: (value) {
          setState(() {
            endTimeSelectedValue = value.toString();
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
              EdgeInsets.only(bottom: endTimeSelectedValue != null ? 12 : 0),
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
                left: endTimeSelectedValue != null ? 0 : 13,
                bottom: endTimeSelectedValue != null ? 0 : 11),
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

  tableCalendarWidget() {
    return TableCalendar(
      availableGestures: AvailableGestures.horizontalSwipe,
      locale: Localizations.localeOf(context).languageCode,
      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
      weekendDays: const [],
      daysOfWeekHeight: 50,
      focusedDay: focusedDate,
      calendarFormat: selectedCalendarFormat,
      firstDay: kFirstDay,
      lastDay: kLastDay,
      headerStyle: HeaderStyle(
        headerPadding: const EdgeInsets.symmetric(horizontal: 0.0),
        formatButtonPadding: const EdgeInsets.symmetric(horizontal: 0.0),
        leftChevronPadding:
            EdgeInsets.symmetric(horizontal: Platform.isAndroid ? 10.0 : 0.0),
        leftChevronMargin: const EdgeInsets.symmetric(horizontal: 0.0),
        rightChevronPadding:
            EdgeInsets.symmetric(horizontal: Platform.isAndroid ? 10.0 : 0.0),
        rightChevronMargin: const EdgeInsets.symmetric(horizontal: 0.0),
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
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: const TextStyle(
            fontFamily: 'SemiBold', fontSize: 16, color: Colors.black),
        titleTextFormatter: (date, locale) =>
            DateFormat.yMMMM(locale).format(date),
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
          todayTextStyle: TextStyle(
              color: focusedDate.compareTo(kFirstDay) != 0
                  ? Colors.black
                  : Colors.white),
          weekendTextStyle: const TextStyle(color: Color(0xffCC6047)),
          disabledTextStyle: const TextStyle(color: Colors.grey),
          disabledDecoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          todayDecoration: BoxDecoration(
              color: focusedDate.compareTo(kFirstDay) != 0
                  ? Colors.white
                  : const Color(0xffCC6047),
              shape: BoxShape.circle),
          selectedTextStyle: const TextStyle(color: Colors.white),
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
        // if (day.weekday == DateTime.saturday) {
        //   return false;
        // } else
        if (day.day == kFirstDay.day &&
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
        debugPrint(focusedDay.month.toString());
        setState(() {
          focusedDate = focusedDay;
        });
      },
    );
  }

  void requestLightOutValidationCheck() {
    String selectedDate = "";
    String day = focusedDate.day.toString();
    String month = focusedDate.month.toString();
    String year = focusedDate.year.toString();

    if (int.parse(day) < 10 && int.parse(month) < 10) {
      selectedDate = '$year-0$month-0$day';
    } else if (int.parse(day) < 10) {
      selectedDate = '$year-$month-0$day';
    } else if (int.parse(month) < 10) {
      selectedDate = '$year-0$month-$day';
    } else {
      selectedDate = '$year-$month-$day';
    }
    setState(() {
      reservationDate = selectedDate;
    });

    // if (selectedFloorList.isEmpty) {
    //   selectedFloorList.add(floorList.first["floor"].toString());
    // }

    // if (_selectedFloors.isEmpty || floorList.isEmpty) {
    if (_selectedFloors.isEmpty) {
      showErrorModal(tr("pleaseSelectFloor"));
    } else if (reservationDate == "") {
      showErrorModal(tr("applicationDateValidation"));
    } else if (startTimeSelectedValue == null) {
      showErrorModal(tr("selectStartTime"));
    } else if (endTimeSelectedValue == null) {
      showErrorModal(tr("endTimeValidation"));
    } else if ((startTimeSelectedValue!.compareTo(endTimeSelectedValue!)) >=
        0) {
      showErrorModal(tr("endTimeMustBeGreaterThanStartTime"));
    } else if (otherRequestController.text.trim().isEmpty) {
      showErrorModal(tr("complaintDescriptionValidation"));
    } else {
      networkCheckForReservation();
    }
  }

  void showErrorModal(String message) {
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
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  void loadFloorList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadFloorListApi();
    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
       showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

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
            var floorNames;
            setState(() {
              floorList = responseJson['data'];
              for (var element in floorList) {
                floorNames = element['floor'];
                floorNamesList.add(floorNames.toString());
              }
              debugPrint(
                  "server response for Floor List ===> ${floorNamesList.toString()}");
            });
          }
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
        setState(() {
          isLoading = false;
        });
      }
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

  void loadStartTimeList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadStartTimeListApi();
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callLoadStartTimeListApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {};

    debugPrint("StartTime List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.requestLightOutStartTimeListUrl,
        body,
        language.toString(),
        null);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for StartTime List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              startTimeList = responseJson['data'];
            });
          }
        } else {
          if (responseJson['message'] != null) {
            // showCustomToast(fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(context: context,
                heading :responseJson['message'].toString(),
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
      showErrorCommonModal(context: context,
          heading: tr("errorDescription"),
          description:"",
          buttonName : tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  void loadUsageTimeList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadUsageTimeListApi();
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callLoadUsageTimeListApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {};

    debugPrint("UsageTime List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.requestLightOutUsageTimeListUrl,
        body,
        language.toString(),
        null);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for UsageTime List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              usageTimeList = responseJson['data'];
            });
          }
        } else {
          if (responseJson['message'] != null) {
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(context: context,
                heading :responseJson['message'].toString(),
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
      showErrorCommonModal(context: context,
          heading: tr("errorDescription"),
          description:"",
          buttonName : tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  void networkCheckForReservation() async {
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLightOutApplyApi();
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callLightOutApplyApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> body = {
      "email": email.trim(), //required
      "contact": mobile.trim(), //required
      "application_date": reservationDate.toString().trim(), //required
      "floors": _selectedFloors, //required
      "start_time": startTimeSelectedValue.toString().trim(), //required
      "end_time": endTimeSelectedValue.toString().trim(), //required
      "description": otherRequestController.text.toString().trim(), //required
    };

    debugPrint("LightOutApply input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.requestLightOutApplyUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for LightOutApply  ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          setState(() {
            isLoadingRequired = true;
          });
          if (responseJson['title'] != null) {
            showReservationModal(
                responseJson['title'], responseJson['message']);
          } else {
            if (responseJson['message'] != null) {
              // showCustomToast(
              //     fToast, context, responseJson['message'].toString(), "");
              showErrorCommonModal(context: context,
                  heading :responseJson['message'].toString(),
                  description: "",
                  buttonName: tr("check"));
            }
          }

          otherRequestController.clear();
          setFirebaseEventForLightOutExtension(lightOutId: "");
        } else {
          if (responseJson['message'] != null &&
              responseJson['title'] != null) {
            showReservationModal(
                responseJson['title'], responseJson['message']);
          } else {
            if (responseJson['message'] != null) {
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
      }
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
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
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

          setState(() {
            companyName = userInfoModel.companyName.toString();
            name = userInfoModel.name.toString();
            email = userInfoModel.email.toString();
            mobile = userInfoModel.mobile.toString();
            companyId = userInfoModel.companyId.toString();
          });
        } else {
          if (responseJson['message'] != null) {
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
}
