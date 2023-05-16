import 'dart:convert';
import 'package:centropolis/widgets/common_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_modal.dart';

class LoungeReservation extends StatefulWidget {
  const LoungeReservation({super.key});

  @override
  State<LoungeReservation> createState() => _LoungeReservationState();
}

class _LoungeReservationState extends State<LoungeReservation> {
  late String language, apiKey;
  late FToast fToast;
  bool isLoading = false;
  DateTime kFirstDay = DateTime.now();
  DateTime kLastDay = DateTime.utc(2030, 3, 14);
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  bool _isChecked = false;
  String? usageTimeSelectedValue;
  String? startTimeSelectedValue;
  String? endTimeSelectedValue;
  List<dynamic> usageTimeList = [];
  List<dynamic> timeList = [];

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    loadUsageTimeList();
    loadTimeList();
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
              child: CommonAppBar(tr("loungeReservation"), false, () {
                onBackButtonPress(context);
              }, () {}),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("reservationInformation"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 16,
                        color: CustomColors.textColor8),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr("nameLounge"),
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
                      ),
                      const Text(
                        "Hong Gil Dong",
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      thickness: 1,
                      height: 1,
                      color: CustomColors.backgroundColor2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr("tenantCompanyLounge"),
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
                      ),
                      const Text(
                        "CBRE",
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
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
                    tr("selectReservationDate"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 16,
                        color: CustomColors.textColor8),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TableCalendar(
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month'
                    },
                    weekendDays: const [DateTime.sunday],
                    daysOfWeekHeight: 50,
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: const TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 16,
                          color: Colors.black),
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
                            color: _focusedDay.compareTo(kFirstDay) != 0
                                ? Colors.black
                                : Colors.white),
                        weekendTextStyle:
                            const TextStyle(color: Color(0xffCC6047)),
                        disabledTextStyle: const TextStyle(color: Colors.grey),
                        disabledDecoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        todayDecoration: BoxDecoration(
                            color: _focusedDay.compareTo(kFirstDay) != 0
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
                      if (isSameDay(day, _focusedDay)) {
                        return true;
                      } else {
                        return false;
                      }
                    },
                    enabledDayPredicate: (day) {
                      if (day.weekday == DateTime.saturday) {
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
                        _focusedDay = focusedDay;
                        _selectedDay = selectedDay;
                      });
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      setState(() {
                        _focusedDay = focusedDay;
                      });
                    },
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
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("timeSelection"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 16,
                        color: CustomColors.textColor8),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    tr("usageTime"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 14,
                        color: CustomColors.textColor8),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  usageTimeWidget(),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    tr("startTime"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 14,
                        color: CustomColors.textColor8),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  startTimeDropDownWidget(),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    tr("endTime"),
                    style: const TextStyle(
                        fontFamily: 'SemiBold',
                        fontSize: 14,
                        color: CustomColors.textColor8),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  endTimeDropDownWidget(),
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
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SizedBox(
                            height: 15,
                            width: 15,
                            child: Checkbox(
                              checkColor: CustomColors.whiteColor,
                              activeColor: CustomColors.buttonBackgroundColor,
                              side: const BorderSide(
                                  color: CustomColors.greyColor, width: 1),
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                  if (_isChecked) {
                                  } else {}
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                        Expanded(
                          child: Text(
                            tr("loungeReservationConsent"),
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 32),
                    child: CommonButton(
                      onCommonButtonTap: () {
                        showReservationModal();
                      },
                      buttonColor: CustomColors.buttonBackgroundColor,
                      buttonName: tr("makeReservation"),
                      isIconVisible: false,
                    ),
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  void showReservationModal() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: tr("loungeReservationComplete"),
            description:
                "The lounge reservation is complete. \nPlease visit the lounge on the 3rd floor and fill out the payment and rental agreement.",
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

  Widget usageTimeWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          tr('selectUsageTime'),
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: usageTimeList
            .map(
              (item) => DropdownMenuItem<String>(
                value: item["value"],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 16),
                      child: Text(
                        item["text"],
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
                onTap: () {
                  if (item["value"] == "manual") {
                    startTimeSelectedValue = null;
                    endTimeSelectedValue = null;
                  } else {
                    setState(() {
                      startTimeSelectedValue = item["start_time"];
                      endTimeSelectedValue = item["end_time"];
                    });
                  }
                },
              ),
            )
            .toList(),
        value: usageTimeSelectedValue,
        onChanged: (value) {
          setState(() {
            usageTimeSelectedValue = value as String;
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
              EdgeInsets.only(bottom: usageTimeSelectedValue != null ? 16 : 0),
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
                left: usageTimeSelectedValue != null ? 0 : 16,
                bottom: usageTimeSelectedValue != null ? 0 : 16),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.all(0),
          height: 53,
        ),
      ),
    );
  }

  Widget startTimeDropDownWidget() {
    if (usageTimeSelectedValue == "manual") {
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
          items: timeList
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
            padding: EdgeInsets.only(
                bottom: startTimeSelectedValue != null ? 16 : 0),
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
    } else {
      return Container(
        height: 53,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
            border: Border.all(
              color: CustomColors.dividerGreyColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              startTimeSelectedValue ?? tr('selectStartTime'),
              style: const TextStyle(
                color: CustomColors.blackColor,
                fontSize: 14,
                fontFamily: 'Regular',
              ),
            ),
            SvgPicture.asset(
              "assets/images/ic_drop_down_arrow.svg",
              width: 8,
              height: 8,
              color: CustomColors.textColorBlack2,
            ),
          ],
        ),
      );
    }
  }

  Widget endTimeDropDownWidget() {
    if (usageTimeSelectedValue == "manual") {
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
          items: timeList
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
          value: endTimeSelectedValue,
          onChanged: (value) {
            setState(() {
              endTimeSelectedValue = value as String;
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
    } else {
      return Container(
        height: 53,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
            border: Border.all(
              color: CustomColors.dividerGreyColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              endTimeSelectedValue ?? tr('selectEndTime'),
              style: const TextStyle(
                color: CustomColors.blackColor,
                fontSize: 14,
                fontFamily: 'Regular',
              ),
            ),
            SvgPicture.asset(
              "assets/images/ic_drop_down_arrow.svg",
              width: 8,
              height: 8,
              color: CustomColors.textColorBlack2,
            ),
          ],
        ),
      );
    }
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

    debugPrint("Usage Time List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getUsageTimeListUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Usage Time List ===> $responseJson");

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

  void loadTimeList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadTimeListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callLoadTimeListApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};

    debugPrint("Time List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getTimeListUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Time List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              timeList = responseJson['data'];
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
}
