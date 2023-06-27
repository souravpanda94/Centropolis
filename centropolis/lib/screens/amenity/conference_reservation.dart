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

import '../../models/user_info_model.dart';
import '../../providers/user_info_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_modal.dart';

class ConferenceReservation extends StatefulWidget {
  const ConferenceReservation({super.key});

  @override
  State<ConferenceReservation> createState() => _ConferenceReservationState();
}

class _ConferenceReservationState extends State<ConferenceReservation> {
  late String language, apiKey, email, mobile;
  String companyName = "";
  String name = "";
  late FToast fToast;
  bool isLoading = false;
  DateTime kFirstDay = DateTime.now();
  DateTime kLastDay = DateTime.utc(2030, 3, 14);
  DateTime focusedDate = DateTime.now();
  CalendarFormat selectedCalendarFormat = CalendarFormat.month;
  DateTime? selectedDate;
  bool isChecked = false;
  TextEditingController rentalInfoController = TextEditingController();
  String? startTimeSelectedValue;
  String? endTimeSelectedValue;
  List<dynamic> timeList = [];
  var dateFormat = DateFormat('yyyy-MM-dd');
  String reservationDate = "";

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
    //name = user.userData['name'].toString();
    //companyName = user.userData['company_name'].toString();
    loadPersonalInformation();
    loadTimeList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                child: CommonAppBar(tr("conferenceRoomReservation"), false, () {
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
                        Text(
                          name,
                          style: const TextStyle(
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
                        Text(
                          companyName,
                          style: const TextStyle(
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
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 16),
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
                    RichText(
                      text: TextSpan(
                          text: tr("startTime"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                          children: const [
                            TextSpan(
                                text: ' *',
                                style: TextStyle(
                                    color: CustomColors.headingColor,
                                    fontSize: 12))
                          ]),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    startTimeDropdownWidget(),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                          text: tr("endTime"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                          children: const [
                            TextSpan(
                                text: ' *',
                                style: TextStyle(
                                    color: CustomColors.headingColor,
                                    fontSize: 12))
                          ]),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    endTimeDropdownWidget(),
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
                    Text(tr("enterRentalInformation"),
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 16,
                            color: CustomColors.textColor8)),
                    Container(
                      padding: const EdgeInsets.only(top: 2, bottom: 2),
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: CustomColors.dividerGreyColor,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      height: 288,
                      child: TextField(
                        controller: rentalInfoController,
                        cursorColor: CustomColors.textColorBlack2,
                        keyboardType: TextInputType.multiline,
                        maxLines: 14,
                        maxLength: 500,
                        decoration: InputDecoration(
                          counterText: "",
                          hintMaxLines: 5,
                          border: InputBorder.none,
                          fillColor: CustomColors.whiteColor,
                          filled: true,
                          contentPadding: const EdgeInsets.all(16),
                          hintText: tr('rentalInformationHint'),
                          hintStyle: const TextStyle(
                            color: CustomColors.textColorBlack2,
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
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
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
                                      color: CustomColors.greyColor, width: 1),
                                  value: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                      if (isChecked) {
                                      } else {}
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              tr("conferenceReservationConsent"),
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
                          reservationValidationCheck();
                          //showReservationModal();
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
              Navigator.pop(context);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
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
  }

  tableCalendarWidget() {
    return TableCalendar(
      locale: Localizations.localeOf(context).languageCode,
      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
      weekendDays: const [DateTime.sunday, DateTime.saturday],
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
    );
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
    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getConferenceTimeListUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['schedule'] != null) {
            setState(() {
              timeList = responseJson['schedule'];
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

  void reservationValidationCheck() {
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

    if (reservationDate == "") {
      showErrorModal(tr("applicationDateValidation"));
    } else if (startTimeSelectedValue == null || startTimeSelectedValue == "") {
      showErrorModal(tr("startTimeValidation"));
    } else if (endTimeSelectedValue == null || startTimeSelectedValue == "") {
      showErrorModal(tr("endTimeValidation"));
    } else if ((startTimeSelectedValue!.compareTo(endTimeSelectedValue!)) >=
        0) {
      showErrorModal(tr("endTimeMustBeGreaterThanStartTime"));
    } else if (rentalInfoController.text.isEmpty) {
      showErrorModal(tr("conferenceDescriptionValidation"));
    } else if (!isChecked) {
      showErrorModal(tr("tnc"));
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

  void networkCheckForReservation() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callReservationApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callReservationApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "email": email.trim(), //required
      "mobile": mobile.trim(), //required
      "reservation_date": reservationDate.toString().trim(), //required
      "start_time": startTimeSelectedValue.toString().trim(), //required
      "end_time": endTimeSelectedValue.toString().trim(), //required
      "description": rentalInfoController.text.toString().trim(), //required
    };

    debugPrint("conferencce reservation input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.makeConferenceReservation,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for conferencce reservation ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          showReservationModal(responseJson['title'].toString(),
              responseJson['message'].toString());
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

  void loadPersonalInformation() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadPersonalInformationApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
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
          });
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
