import 'dart:convert';
import 'dart:math';
import 'package:centropolis/screens/amenity/view_seat_selection.dart';
import 'package:centropolis/screens/amenity/view_seat_selection_modal.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import '../../models/view_seat_selection_model.dart';
import '../../providers/user_provider.dart';
import '../../providers/view_seat_selection_provider.dart';
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
  String? selectedSeatsValue;
  var dateFormat = DateFormat('yyyy-MM-dd');
  List<dynamic> usageTimeList = [];
  List<dynamic> totalUsageTimeList = [];
  List<dynamic> selectedSeatList = [];
  String reservationDate = "";
  List<ViewSeatSelectionModel>? viewSeatSelectionListItem;
  List<ViewSeatSelectionModel> viewSeatSelectionListWithTimeSlot = [];
  List<ViewSeatSelectionModel> viewSeatSelectionListWithSeats = [];
  List<dynamic> timeSlotList = [];
  String? totalUsageTimeSelectedText;

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
    debugPrint("Api key ===> $apiKey");
    loadTimeList();
    loadTotalUsageTimeList();
    loadViewSeatSelectionList();

    // setListData();
    // setFemaleListData();
  }

  @override
  Widget build(BuildContext context) {
    viewSeatSelectionListItem = Provider.of<ViewSeatSelectionProvider>(context)
        .getViewSeatSelectionList;

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
            // Container(
            //   color: CustomColors.whiteColor,
            //   padding: const EdgeInsets.only(
            //       left: 16, right: 16, top: 16, bottom: 8),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         tr("seatSelection"),
            //         style: const TextStyle(
            //           fontSize: 16,
            //           color: CustomColors.textColor8,
            //           fontFamily: 'SemiBold',
            //         ),
            //       ),
            //       Row(
            //         children: [
            //           Row(
            //             children: [
            //               const Icon(
            //                 Icons.square,
            //                 size: 15,
            //                 color: CustomColors.textColor9,
            //               ),
            //               const SizedBox(
            //                 width: 4,
            //               ),
            //               Text(
            //                 tr("select"),
            //                 style: const TextStyle(
            //                   fontSize: 12,
            //                   color: CustomColors.greyColor1,
            //                   fontFamily: 'Regular',
            //                 ),
            //               )
            //             ],
            //           ),
            //           const SizedBox(
            //             width: 8,
            //           ),
            //           Row(
            //             children: [
            //               const Icon(
            //                 Icons.square_outlined,
            //                 size: 15,
            //                 color: CustomColors.textColor9,
            //               ),
            //               const SizedBox(
            //                 width: 4,
            //               ),
            //               Text(
            //                 tr("selectable"),
            //                 style: const TextStyle(
            //                   fontSize: 12,
            //                   color: CustomColors.greyColor1,
            //                   fontFamily: 'Regular',
            //                 ),
            //               )
            //             ],
            //           ),
            //           const SizedBox(
            //             width: 8,
            //           ),
            //           Row(
            //             children: [
            //               const Icon(
            //                 Icons.square,
            //                 size: 15,
            //                 color: CustomColors.borderColor,
            //               ),
            //               const SizedBox(
            //                 width: 4,
            //               ),
            //               Text(
            //                 tr("closed"),
            //                 style: const TextStyle(
            //                   fontSize: 12,
            //                   color: CustomColors.greyColor1,
            //                   fontFamily: 'Regular',
            //                 ),
            //               )
            //             ],
            //           )
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            // seatSelectionWidget(),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   color: CustomColors.whiteColor,
            //   height: 10,
            // ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   color: CustomColors.backgroundColor,
            //   height: 10,
            // ),
            //

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr("timeSelection"),
                              style: const TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 16,
                                  color: CustomColors.textColor8),
                            ),
                            InkWell(
                              onTap: () {
                                goToViewSeatSelectionScreen();
                              },
                              child: Text(
                                tr("viewSeatSelection"),
                                style: const TextStyle(
                                    fontFamily: 'Medium',
                                    fontSize: 14,
                                    color: CustomColors.textColor9),
                              ),
                            )
                          ],
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
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("seatSelection"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 16,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          tr("selectSeats"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        selectSeatsDropdownWidget(),
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
                            mainAxisAlignment: MainAxisAlignment.start,
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
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
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

  Widget usageTimeDropdownWidget() {
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
          loadSelectedSeatList();
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

  Widget totalUsageDropdownWidget() {
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
                  onTap: () {
                    setState(() {
                      totalUsageTimeSelectedText = item["text"].toString();
                    });
                  },
                ))
            .toList(),
        value: totalTimeSelectedValue,
        onChanged: (value) {
          setState(() {
            totalTimeSelectedValue = value.toString();
          });
          loadSelectedSeatList();
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

  Widget selectSeatsDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          // usageTimeList.isNotEmpty ? usageTimeList.first : tr("pleaseSelectSeat"),
          tr("pleaseSelectSeat"),
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: selectedSeatList
            .map((item) => DropdownMenuItem<String>(
                  value: item['seat'].toString(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 16),
                        child: Text(
                          item['seat'].toString(),
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
        value: selectedSeatsValue,
        onChanged: (value) {
          setState(() {
            selectedSeatsValue = value as String;
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
          padding: EdgeInsets.only(bottom: selectedSeatsValue != null ? 16 : 0),
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
                left: selectedSeatsValue != null ? 0 : 16,
                bottom: selectedSeatsValue != null ? 0 : 16),
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
        loadViewSeatSelectionList();
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
            loadSelectedSeatList();

            for (int i = 0; i < usageTimeList.length; i++) {
              if (usageTimeList.length - 1 != i) {
                timeSlotList.add('${usageTimeList[i]}-${usageTimeList[i + 1]}');
              }
              // else{
              //   timeSlotList.add(usageTimeList[i]);
              // }
            }
          }
          debugPrint("Time list length ====> ${usageTimeList.length}");
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
            loadSelectedSeatList();
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

  void loadSelectedSeatList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadSelectedSeatListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callLoadSelectedSeatListApi() {
    // setState(() {
    //   isLoading = true;
    // });
    String date = getSelectedDate();
    Map<String, String> body = {
      "date": date,
      "start_time": usageTimeSelectedValue != null &&
              usageTimeSelectedValue.toString().isNotEmpty
          ? usageTimeSelectedValue.toString().trim()
          : usageTimeList.isNotEmpty
              ? usageTimeList.first.toString()
              : "",
      "usage_time": totalTimeSelectedValue != null &&
              totalTimeSelectedValue.toString().isNotEmpty
          ? totalTimeSelectedValue.toString().trim()
          : totalUsageTimeList.isNotEmpty
              ? totalUsageTimeList.first["value"].toString()
              : "",
    };

    debugPrint("Selected Seat list input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getSelectedSeatListUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);
      debugPrint("server response for Selected Seat list ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['seats_data'] != null) {
            setState(() {
              selectedSeatList = responseJson['seats_data'];
            });
          }
        } else {
          if (responseJson['message'] != null) {
            // showCustomToast(fToast, context, responseJson['message'].toString(), "");
            if (kDebugMode) {
              print("Error =====> ${responseJson['message']}");
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

  void loadViewSeatSelectionList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callViewSeatSelectionListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callViewSeatSelectionListApi() {
    setState(() {
      isLoading = true;
    });
    String date = getSelectedDate();
    Map<String, String> body = {"date": date};

    debugPrint("View Seat Selection input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getViewSeatSelectionListUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for View Seat Selection ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          List<ViewSeatSelectionModel> reservationListList =
              List<ViewSeatSelectionModel>.from(responseJson['seats_data']
                  .map((x) => ViewSeatSelectionModel.fromJson(x)));
          Provider.of<ViewSeatSelectionProvider>(context, listen: false)
              .setItem(reservationListList);
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

  String getSelectedDate() {
    String date = "";
    if (focusedDate.month < 10 && focusedDate.day < 10) {
      date = '${focusedDate.year}-0${focusedDate.month}-0${focusedDate.day}';
    } else if (focusedDate.month < 10) {
      date = '${focusedDate.year}-0${focusedDate.month}-${focusedDate.day}';
    } else if (focusedDate.day < 10) {
      date = '${focusedDate.year}-${focusedDate.month}-0${focusedDate.day}';
    } else {
      date = '${focusedDate.year}-${focusedDate.month}-${focusedDate.day}';
    }
    return date;
  }

  void goToViewSeatSelectionScreen() {
    viewSeatSelectionListWithTimeSlot.clear();
    viewSeatSelectionListWithSeats.clear();

    if (usageTimeSelectedValue == null) {
      if (usageTimeList.isNotEmpty) {
        setState(() {
          usageTimeSelectedValue = usageTimeList.first.toString();
        });
      }
    }
    if (selectedSeatsValue == null) {
      if (selectedSeatList.isNotEmpty) {
        setState(() {
          selectedSeatsValue = selectedSeatList.first['seat'].toString();
        });
      }
    }
    if (totalUsageTimeSelectedText == null) {
      if (totalUsageTimeList.isNotEmpty) {
        setState(() {
          totalUsageTimeSelectedText =
              totalUsageTimeList.first['text'].toString();
        });
      }
    }

    for (int i = 0; i < timeSlotList.length; i++) {
      ViewSeatSelectionModel model = ViewSeatSelectionModel(
          seat: 0,
          available: true,
          slot: "",
          slotRange: timeSlotList[i].toString());
      viewSeatSelectionListWithTimeSlot.add(model);
    }

    for (int i = 0; i < viewSeatSelectionListItem!.length; i++) {
      int? seatValue = viewSeatSelectionListItem?[i].seat;
      bool? available = viewSeatSelectionListItem?[i].available;
      String? slot = viewSeatSelectionListItem?[i].slot;
      String? slotRange = viewSeatSelectionListItem?[i].slotRange;

      ViewSeatSelectionModel model = ViewSeatSelectionModel(
          seat: seatValue,
          available: available,
          slot: slot,
          slotRange: slotRange);
      viewSeatSelectionListWithTimeSlot.add(model);
    }

    for (int i = 0; i < viewSeatSelectionListWithTimeSlot.length; i++) {
      // debugPrint("i ===> $i");
      // debugPrint("viewSeatSelectionListItem length ===> ${viewSeatSelectionListWithTimeSlot.length}");

      if (i < viewSeatSelectionListWithTimeSlot.length - 1) {
        if (viewSeatSelectionListWithTimeSlot[i].seat !=
            viewSeatSelectionListWithTimeSlot[i + 1].seat) {
          int? seatValue = viewSeatSelectionListWithTimeSlot[i].seat;
          ViewSeatSelectionModel model = ViewSeatSelectionModel(
              seat: seatValue, available: true, slot: "", slotRange: "");
          viewSeatSelectionListWithSeats.insert(i, model);
        } else {
          int? seatValue = viewSeatSelectionListWithTimeSlot[i].seat;
          bool? available = viewSeatSelectionListWithTimeSlot[i].available;
          String? slot = viewSeatSelectionListWithTimeSlot[i].slot;
          String? slotRange = viewSeatSelectionListWithTimeSlot[i].slotRange;

          ViewSeatSelectionModel model = ViewSeatSelectionModel(
              seat: seatValue,
              available: available,
              slot: slot,
              slotRange: slotRange);
          viewSeatSelectionListWithSeats.insert(i, model);
        }
      } else {
        int? seatValue = viewSeatSelectionListWithTimeSlot[i].seat;
        ViewSeatSelectionModel model = ViewSeatSelectionModel(
            seat: seatValue, available: true, slot: "", slotRange: "");
        viewSeatSelectionListWithSeats.add(model);
      }
    }

    showGeneralDialog(
        context: context,
        barrierColor: Colors.black12.withOpacity(0.6),
        barrierDismissible: false,
        barrierLabel: 'Dialog',
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) {
          return ViewSeatSelectionModalScreen(
              viewSeatSelectionListWithSeats,
              timeSlotList,
              selectedSeatList,
              usageTimeSelectedValue,
              selectedSeatsValue,
              totalUsageTimeSelectedText,
              usageTimeList.cast<String>());
        });
  }
}
