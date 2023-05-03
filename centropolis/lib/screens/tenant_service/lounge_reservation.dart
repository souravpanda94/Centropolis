import 'package:centropolis/widgets/common_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_modal.dart';

class LoungeReservation extends StatefulWidget {
  const LoungeReservation({super.key});

  @override
  State<LoungeReservation> createState() => _LoungeReservationState();
}

class _LoungeReservationState extends State<LoungeReservation> {
  DateTime kFirstDay = DateTime.now();
  DateTime kLastDay = DateTime.utc(2030, 3, 14);
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  bool _isChecked = false, usageTimeTapped = false;
  List<dynamic> usageTimeList = [
    {"usageTime": tr("usageTimeDay"), "startTime": "9:00", "endTime": "18:00"},
    {
      "usageTime": tr("usageTimeMorning"),
      "startTime": "9:00",
      "endTime": "13:00"
    },
    {
      "usageTime": tr("usageTimeAfternoon"),
      "startTime": "14:00",
      "endTime": "18:00"
    },
    {"usageTime": tr("randomChoice"), "startTime": "", "endTime": ""},
  ];
  TextEditingController usageTimeController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.all(16),
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
                TextField(
                  controller: usageTimeController,
                  cursorColor: CustomColors.textColorBlack2,
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  showCursor: false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: CustomColors.whiteColor,
                      filled: true,
                      contentPadding: const EdgeInsets.all(16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                            color: CustomColors.dividerGreyColor, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                            color: CustomColors.dividerGreyColor, width: 1.0),
                      ),
                      hintText: tr('selectUsageTime'),
                      hintStyle: const TextStyle(
                        color: CustomColors.textColorBlack2,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SvgPicture.asset(
                          "assets/images/ic_drop_down_arrow.svg",
                          width: 8,
                          height: 4,
                          color: CustomColors.textColorBlack2,
                        ),
                      )),
                  style: const TextStyle(
                    color: CustomColors.blackColor,
                    fontSize: 14,
                    fontFamily: 'Regular',
                  ),
                  onTap: () {
                    setState(() {
                      usageTimeTapped = true;
                    });
                  },
                ),
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        TextField(
                          controller: startTimeController,
                          cursorColor: CustomColors.textColorBlack2,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          showCursor: false,
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
                              hintText: tr('selectStartTime'),
                              hintStyle: const TextStyle(
                                color: CustomColors.textColorBlack2,
                                fontSize: 14,
                                fontFamily: 'Regular',
                              ),
                              suffixIcon: startTimeController.text.isEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: SvgPicture.asset(
                                        "assets/images/ic_drop_down_arrow.svg",
                                        width: 8,
                                        height: 4,
                                        color: CustomColors.textColorBlack2,
                                      ),
                                    )
                                  : null),
                          style: const TextStyle(
                            color: CustomColors.blackColor,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                          onTap: () {},
                        ),
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
                        TextField(
                          controller: endTimeController,
                          cursorColor: CustomColors.textColorBlack2,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          showCursor: false,
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
                              hintText: tr('selectEndTime'),
                              hintStyle: const TextStyle(
                                color: CustomColors.textColorBlack2,
                                fontSize: 14,
                                fontFamily: 'Regular',
                              ),
                              suffixIcon: endTimeController.text.isEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: SvgPicture.asset(
                                        "assets/images/ic_drop_down_arrow.svg",
                                        width: 8,
                                        height: 4,
                                        color: CustomColors.textColorBlack2,
                                      ),
                                    )
                                  : null),
                          style: const TextStyle(
                            color: CustomColors.blackColor,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                    if (usageTimeTapped)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: CustomColors.whiteColor,
                          border: Border.all(
                            color: CustomColors.dividerGreyColor,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(4, (index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      usageTimeController.text =
                                          usageTimeList[index]["usageTime"];
                                      startTimeController.text =
                                          usageTimeList[index]["startTime"];
                                      endTimeController.text =
                                          usageTimeList[index]["endTime"];
                                      setState(() {
                                        usageTimeTapped = false;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        usageTimeList[index]["usageTime"],
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontFamily: 'Regular',
                                            fontSize: 14,
                                            color:
                                                CustomColors.textColorBlack2),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    height: 1,
                                    color: CustomColors.dividerGreyColor,
                                  )
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                  ],
                )
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
}
