import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/custom_colors.dart';
import '../../widgets/common_button.dart';

class PaidPTReservation extends StatefulWidget {
  const PaidPTReservation({super.key});

  @override
  State<PaidPTReservation> createState() => _PaidPTReservationState();
}

class _PaidPTReservationState extends State<PaidPTReservation> {
  DateTime kFirstDay = DateTime.now();
  DateTime kLastDay = DateTime.utc(2030, 3, 14);
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  bool _isChecked = false, timeTapped = false;
  TextEditingController timeController = TextEditingController();
  String time = "";

  List<dynamic> timeList = [
    "10:00 ~ 14:00",
    "12:00 ~ 13:00",
    "11:00 ~ 15:00",
    "13:00 ~ 16:00",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              TableCalendar(
                availableCalendarFormats: const {CalendarFormat.month: 'Month'},
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
                    weekendTextStyle: const TextStyle(color: Color(0xffCC6047)),
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
          color: CustomColors.whiteColor,
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
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
                height: 8,
              ),
              TextField(
                controller: timeController,
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
                    hintText: "00:00 ~ 00:00",
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
                    timeTapped = true;
                  });
                },
              ),
              Stack(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  if (timeTapped)
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
                                    setState(() {
                                      timeTapped = false;
                                      timeController.text = timeList[index];

                                      time = timeController.text.toString();
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      timeList[index],
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontFamily: 'Regular',
                                          fontSize: 14,
                                          color: CustomColors.textColorBlack2),
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
          color: CustomColors.whiteColor,
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
                        tr("gxReservationConsent"),
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
                  onCommonButtonTap: () {},
                  buttonColor: CustomColors.buttonBackgroundColor,
                  buttonName: tr("makeReservation"),
                  isIconVisible: false,
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
