import 'dart:convert';

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

import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_modal.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';

class AirConditioningApplication extends StatefulWidget {
  const AirConditioningApplication({super.key});

  @override
  State<AirConditioningApplication> createState() =>
      _AirConditioningApplicationState();
}

enum Type { airConditioning, heating }

class _AirConditioningApplicationState
    extends State<AirConditioningApplication> {
  Type? type = Type.airConditioning;

  late String language, apiKey, email, mobile, companyId, companyName, name;
  late FToast fToast;
  bool isLoading = false;
  DateTime kFirstDay = DateTime.now();
  DateTime kLastDay = DateTime.utc(2030, 3, 14);
  DateTime focusedDate = DateTime.now();
  CalendarFormat selectedCalendarFormat = CalendarFormat.month;
  DateTime? selectedDate;
  bool isChecked = false;
  String typeValue = "cooling";
  String reservationDate = "";
  String? floorSelectedValue;
  String? startTimeSelectedValue;
  String? endTimeSelectedValue;
  bool isLoadingRequired = false;
  List<dynamic> floorList = [];
  List<dynamic> startTimeList = [];
  List<dynamic> usageTimeList = [];
  List<dynamic> selectedFloorList = [];

  TextEditingController otherRequestController = TextEditingController();
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
    email = user.userData['email_key'].toString();
    mobile = user.userData['mobile'].toString();
    companyId = user.userData['company_id'].toString();
    companyName = user.userData['company_name'].toString();
    name = user.userData['name'].toString();
    loadStartTimeList();
    loadUsageTimeList();
    loadFloorList();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
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
              child: CommonAppBar(tr("requestForHeatingAndCooling"), false, () {
                //onBackButtonPress(context);
                Navigator.pop(context, isLoadingRequired);
              }, () {}),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tr("nameLounge"),
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
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0, color: CustomColors.dividerGreyColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: _selectedFloors.isEmpty
                                  ? Container(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(tr('applicationFloorHint')))
                                  : Container(
                                      margin: const EdgeInsets.only(left: 15),
                                      child: Wrap(
                                        spacing: 6,
                                        runSpacing: -10,
                                        children: _selectedFloors
                                            .map((e) => Chip(
                                                  backgroundColor: CustomColors
                                                      .selectedColor,
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  label: Text(e,
                                                      style: const TextStyle(
                                                          fontFamily: 'Regular',
                                                          fontSize: 14,
                                                          color: CustomColors
                                                              .whiteColor)),
                                                ))
                                            .toList(),
                                      ),
                                    )),
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: EdgeInsets.only(
                                bottom: floorSelectedValue != null ? 16 : 0),
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
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("airConditioning/Heating"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 16,
                        color: CustomColors.textColor8),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Radio<Type>(
                                activeColor: CustomColors.buttonBackgroundColor,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: Type.airConditioning,
                                groupValue: type,
                                onChanged: (Type? value) {
                                  setState(() {
                                    type = value;
                                    if (type == Type.airConditioning) {
                                      typeValue = "cooling";
                                    } else {
                                      typeValue = "heating";
                                    }
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                tr("coolingValue"),
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    color: CustomColors.textColorBlack2,
                                    fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Radio<Type>(
                                activeColor: CustomColors.buttonBackgroundColor,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: Type.heating,
                                groupValue: type,
                                onChanged: (Type? value) {
                                  setState(() {
                                    type = value;
                                    if (type == Type.airConditioning) {
                                      typeValue = "cooling";
                                    } else {
                                      typeValue = "heating";
                                    }
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                tr("heating"),
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    color: CustomColors.textColorBlack2,
                                    fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
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
                  Text(
                    tr("dateOfApplicationLightOut"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 16,
                        color: CustomColors.textColor8),
                  ),
                  const SizedBox(
                    height: 8,
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
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
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
                    tr("uptime"),
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
                    tr("usageTimeCoolingHeating"),
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
                    child: SingleChildScrollView(
                      child: TextField(
                        controller: otherRequestController,
                        maxLength: 500,
                        cursorColor: CustomColors.textColorBlack2,
                        keyboardType: TextInputType.multiline,
                        maxLines: 14,
                        decoration: InputDecoration(
                          counterText: "",
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
                      ),
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
                  airConditioningApplicationValidationCheck();
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
    );
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
                        padding: const EdgeInsets.only(left: 16, bottom: 16),
                        child: Text(
                          item,
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
              EdgeInsets.only(bottom: startTimeSelectedValue != null ? 16 : 0),
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
                left: startTimeSelectedValue != null ? 0 : 16,
                bottom: startTimeSelectedValue != null ? 0 : 16),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.all(0),
          height: 53,
        ),
      ),
    );
  }

  endTimeDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          //tr('selectEndTime'),
          usageTimeList.isNotEmpty
              ? "${usageTimeList.first["text"]}  ${tr("krwDetail")}"
              : "1 ${tr("krwDetail")}",
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: usageTimeList
            .map((item) => DropdownMenuItem<String>(
                  value: item["value"].toString(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 16),
                        child: Text(
                          "${item["text"]} ${tr("krwDetail")}",
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
              EdgeInsets.only(bottom: endTimeSelectedValue != null ? 16 : 0),
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
                left: endTimeSelectedValue != null ? 0 : 16,
                bottom: endTimeSelectedValue != null ? 0 : 16),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.all(0),
          height: 53,
        ),
      ),
    );
  }

  tableCalendarWidget() {
    return TableCalendar(
      locale: Localizations.localeOf(context).languageCode,
      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
      weekendDays: const [],
      daysOfWeekHeight: 50,
      focusedDay: focusedDate,
      calendarFormat: selectedCalendarFormat,
      firstDay: kFirstDay,
      lastDay: kLastDay,
      headerStyle: HeaderStyle(
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
        setState(() {
          focusedDate = focusedDay;
        });
      },
    );
  }

  void airConditioningApplicationValidationCheck() {
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

    if (_selectedFloors.isEmpty) {
      showErrorModal(tr("pleaseSelectFloor"));
    } else if (reservationDate == "") {
      showErrorModal(tr("applicationDateValidation"));
    } else if (startTimeSelectedValue == null) {
      showErrorModal(tr("selectStartTime"));
    } else if (endTimeSelectedValue == null && usageTimeList.isEmpty) {
      showErrorModal(tr("lightsOutEndTimeValidation"));
    } else if (otherRequestController.text.trim().isEmpty) {
      showErrorModal(tr("conferenceDescriptionValidation"));
    } else if (typeValue.trim().isEmpty) {
      showErrorModal(tr("complaintTypeValidation"));
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
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
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

  void loadStartTimeList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadStartTimeListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
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

  void loadUsageTimeList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadUsageTimeListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
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

  void networkCheckForReservation() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callCoolingHeatingApplyApplyApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callCoolingHeatingApplyApplyApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> body = {
      "email": email.trim(), //required
      "contact": mobile.trim(), //required
      "application_start_date": reservationDate.toString().trim(), //required
      "floors": _selectedFloors, //required
      "start_time": startTimeSelectedValue.toString().trim(), //required
      "usage_hour": endTimeSelectedValue != null &&
              endTimeSelectedValue.toString().isNotEmpty
          ? endTimeSelectedValue.toString().trim()
          : usageTimeList.first["value"].toString().trim(), //required
      "description": otherRequestController.text.toString().trim(), //required
      "type": typeValue.toString().trim(), //required
    };

    debugPrint("CoolingHeating input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.coolingHeatingSaveUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for CoolingHeating  ===> $responseJson");

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
              showCustomToast(
                  fToast, context, responseJson['message'].toString(), "");
            }
          }
          otherRequestController.clear();
        } else {
          if (responseJson['message'] != null &&
              responseJson['title'] != null) {
            showReservationModal(
                responseJson['title'], responseJson['message']);
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
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isLoading = false;
      });
    });
  }
}
