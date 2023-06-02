import 'dart:convert';
import 'dart:math';

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
import '../../widgets/common_button.dart';
import '../../widgets/common_modal.dart';

class SleepingRoomReservation extends StatefulWidget {
  const SleepingRoomReservation({super.key});

  @override
  State<SleepingRoomReservation> createState() =>
      _SleepingRoomReservationState();
}

class _SleepingRoomReservationState extends State<SleepingRoomReservation> {
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  bool isLoading = false;
  DateTime kFirstDay = DateTime.now();
  DateTime kLastDay = DateTime.utc(2030, 3, 14);
  DateTime focusedDate = DateTime.now();
  CalendarFormat selectedCalendarFormat = CalendarFormat.month;
  DateTime? selectedDate;
  bool isChecked = false;
  bool selected = false;
  List<dynamic> listData = [];
  List<dynamic> femaleListData = [];
  int selectedIndex = 0;
  String type = "female";
  String? usageTimeSelectedValue;
  String? totalTimeSelectedValue;
  var dateFormat = DateFormat('yyyy-MM-dd');
  List<dynamic> usageTimeList = [];
  List<dynamic> totalUsageTimeList = [];
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
    name = user.userData['name'].toString();
    companyName = user.userData['company_name'].toString();
    loadTimeList();
    loadTotalUsageTimeList();
    setListData();
    setFemaleListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("sleepingRoomReservation"), false, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: LoadingOverlay(
        opacity: 0.5,
        color: CustomColors.textColor4,
        progressIndicator: const CircularProgressIndicator(
          color: CustomColors.blackColor,
        ),
        isLoading: isLoading,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: CustomColors.whiteColor,
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr("seatSelection"),
                    style: const TextStyle(
                      fontSize: 16,
                      color: CustomColors.textColor8,
                      fontFamily: 'SemiBold',
                    ),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.square,
                            size: 15,
                            color: CustomColors.textColor9,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            tr("select"),
                            style: const TextStyle(
                              fontSize: 12,
                              color: CustomColors.greyColor1,
                              fontFamily: 'Regular',
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.square_outlined,
                            size: 15,
                            color: CustomColors.textColor9,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            tr("selectable"),
                            style: const TextStyle(
                              fontSize: 12,
                              color: CustomColors.greyColor1,
                              fontFamily: 'Regular',
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.square,
                            size: 15,
                            color: CustomColors.borderColor,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            tr("closed"),
                            style: const TextStyle(
                              fontSize: 12,
                              color: CustomColors.greyColor1,
                              fontFamily: 'Regular',
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            seatSelectionWidget(),
            Container(
              width: MediaQuery.of(context).size.width,
              color: CustomColors.whiteColor,
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: CustomColors.backgroundColor,
              height: 10,
            ),
            Container(
              color: CustomColors.whiteColor,
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
              color: CustomColors.whiteColor,
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
              color: CustomColors.whiteColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        usageTimeDropdownWidget(),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          tr("totalUsageTime"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        totalUsageDropdownWidget(),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: CustomColors.backgroundColor,
                    margin: const EdgeInsets.only(top: 16),
                    height: 10,
                  ),
                  Container(
                    alignment: FractionalOffset.bottomCenter,
                    color: CustomColors.whiteColor,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    width: MediaQuery.of(context).size.width,
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
                                    activeColor:
                                        CustomColors.buttonBackgroundColor,
                                    side: const BorderSide(
                                        color: CustomColors.greyColor,
                                        width: 1),
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
                              const SizedBox(
                                width: 9,
                              ),
                              Expanded(
                                child: Text(
                                  tr("sleepingRoomReservationConsent"),
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
              ),
            ),
          ],
        )),
      ),
    );
  }

  void setListData() {
    List<String> names = [tr("selectable"), tr("closed")];

    listData.clear();
    for (int i = 1; i <= 15; i++) {
      final random = Random();
      String element = names[random.nextInt(names.length)];
      listData.add(element);
    }
  }

  void setFemaleListData() {
    List<String> names = [tr("selectable"), tr("closed")];

    femaleListData.clear();
    for (int i = 16; i <= 20; i++) {
      final random = Random();
      String element = names[random.nextInt(names.length)];
      femaleListData.add(element);
    }
  }

  usageTimeDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          usageTimeList.isNotEmpty ? usageTimeList.first : "11:00",
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: usageTimeList
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

  totalUsageDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          totalUsageTimeList.isNotEmpty
              ? totalUsageTimeList.first["text"]
              : "10 Minutes",
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: totalUsageTimeList
            .map((item) => DropdownMenuItem<String>(
                  value: item["value"].toString(),
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
                ))
            .toList(),
        value: totalTimeSelectedValue,
        onChanged: (value) {
          setState(() {
            totalTimeSelectedValue = value.toString();
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
              EdgeInsets.only(bottom: totalTimeSelectedValue != null ? 16 : 0),
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
                left: totalTimeSelectedValue != null ? 0 : 16,
                bottom: totalTimeSelectedValue != null ? 0 : 16),
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
      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
      weekendDays: const [DateTime.sunday],
      daysOfWeekHeight: 50,
      focusedDay: focusedDate,
      calendarFormat: selectedCalendarFormat,
      firstDay: kFirstDay,
      lastDay: kLastDay,
      headerStyle: HeaderStyle(
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

  seatSelectionWidget() {
    return Visibility(
      visible: type == "male",
      replacement: Container(
        height: 116,
        width: MediaQuery.of(context).size.width,
        color: CustomColors.backgroundColor,
        margin: const EdgeInsets.only(left: 16, right: 16),
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tr("sleepingRoom(Female)"),
                  style: const TextStyle(
                    fontSize: 14,
                    color: CustomColors.textColorBlack2,
                    fontFamily: 'SemiBold',
                  ),
                ),
                const Text(
                  "Total 5 seats",
                  style: TextStyle(
                    fontSize: 12,
                    color: CustomColors.greyColor1,
                    fontFamily: 'Regular',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1,
                  mainAxisExtent: 45,
                ),
                itemCount: femaleListData.length,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                      onTap: () {
                        if (femaleListData[index] == tr("selectable")) {
                          setState(() {
                            selected = true;
                            selectedIndex = index;
                          });
                        }
                      },
                      child: Container(
                        width: 50,
                        height: 34,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        margin: const EdgeInsets.only(right: 15, bottom: 12),
                        decoration: BoxDecoration(
                          color: femaleListData[index] == tr("closed")
                              ? CustomColors.borderColor
                              : selected && selectedIndex == index
                                  ? CustomColors.textColor9
                                  : CustomColors.whiteColor,
                          border: Border.all(
                              color: femaleListData[index] == tr("closed")
                                  ? CustomColors.borderColor
                                  : CustomColors.textColor9,
                              width: 1.0),
                        ),
                        child: Center(
                          child: Text(
                            (index + 16).toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: femaleListData[index] == tr("closed")
                                  ? CustomColors.textColor3
                                  : selected && selectedIndex == index
                                      ? CustomColors.whiteColor
                                      : CustomColors.textColor9,
                              fontFamily: 'Regular',
                            ),
                          ),
                        ),
                      ));
                }),
          ],
        ),
      ),
      child: Container(
        height: 210,
        width: MediaQuery.of(context).size.width,
        color: CustomColors.backgroundColor,
        margin: const EdgeInsets.only(left: 16, right: 16),
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tr("sleepingRoom(Male)"),
                  style: const TextStyle(
                    fontSize: 14,
                    color: CustomColors.textColorBlack2,
                    fontFamily: 'SemiBold',
                  ),
                ),
                const Text(
                  "Total 15 seats",
                  style: TextStyle(
                    fontSize: 12,
                    color: CustomColors.greyColor1,
                    fontFamily: 'Regular',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1,
                  mainAxisExtent: 45,
                ),
                itemCount: listData.length,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                      onTap: () {
                        if (listData[index] == tr("selectable")) {
                          setState(() {
                            selected = true;
                            selectedIndex = index;
                          });
                        }
                      },
                      child: Container(
                        width: 50,
                        height: 34,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        margin: const EdgeInsets.only(right: 15, bottom: 12),
                        decoration: BoxDecoration(
                          color: listData[index] == tr("closed")
                              ? CustomColors.borderColor
                              : selected && selectedIndex == index
                                  ? CustomColors.textColor9
                                  : CustomColors.whiteColor,
                          border: Border.all(
                              color: listData[index] == tr("closed")
                                  ? CustomColors.borderColor
                                  : CustomColors.textColor9,
                              width: 1.0),
                        ),
                        child: Center(
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: listData[index] == tr("closed")
                                  ? CustomColors.textColor3
                                  : selected && selectedIndex == index
                                      ? CustomColors.whiteColor
                                      : CustomColors.textColor9,
                              fontFamily: 'Regular',
                            ),
                          ),
                        ),
                      ));
                }),
          ],
        ),
      ),
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
        ApiEndPoint.getSleepingRoomTimeListUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['schedule'] != null) {
            setState(() {
              usageTimeList = responseJson['schedule'];
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

  void loadTotalUsageTimeList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadTotalUsageTimeListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callLoadTotalUsageTimeListApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};
    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getSleepingRoomTotalUsageTimeListUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              totalUsageTimeList = responseJson['data'];
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
    } else if (usageTimeSelectedValue == null && usageTimeList.isEmpty) {
      showErrorModal(tr("startTimeValidation"));
    } else if (totalTimeSelectedValue == null && totalUsageTimeList.isEmpty) {
      showErrorModal(tr("usageTimeValidation"));
    } else if (selectedIndex == 0) {
      showErrorModal(tr("seatValidation"));
    } else if (!isChecked) {
      showErrorModal(tr("tnc"));
    } else {
      //networkCheckForReservation();
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
    var reservationDate = dateFormat.format(focusedDate);

    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "email": email.trim(), //required
      "mobile": mobile.trim(), //required
      "reservation_date": reservationDate.toString().trim(), //required
      "start_time": usageTimeSelectedValue != null &&
              usageTimeSelectedValue.toString().isNotEmpty
          ? usageTimeSelectedValue.toString().trim()
          : usageTimeList.first, //required
      "usage_hours": totalTimeSelectedValue != null &&
              totalTimeSelectedValue.toString().isNotEmpty
          ? totalTimeSelectedValue.toString().trim()
          : totalUsageTimeList.first["value"], //required
      "seat": (selectedIndex + 1).toString().trim(), //required
    };

    debugPrint("sleeping room reservation input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.makeSleepingRoomReservation,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for sleeping room reservation ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          showReservationModal(responseJson['title'], responseJson['message']);
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

  void showReservationModal(title, content) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: title,
            description: content,
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
}
