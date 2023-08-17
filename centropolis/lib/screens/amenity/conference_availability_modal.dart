import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/date_utils.dart';

import 'package:table_calendar/table_calendar.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';

class ConferenceAvailabilityModal extends StatefulWidget {
  final Map<dynamic, dynamic> scheduleList;
  const ConferenceAvailabilityModal({super.key, required this.scheduleList});

  @override
  State<ConferenceAvailabilityModal> createState() =>
      _ConferenceAvailabilityModalState();
}

class _ConferenceAvailabilityModalState
    extends State<ConferenceAvailabilityModal> {
  late String language;
  DateTime kFirstDay = DateTime(DateTime.now().year, DateTime.now().month,
      Utils.firstDayOfMonth(DateTime.now()).day);
  DateTime kLastDay = DateTime(DateTime.now().year, DateTime.now().month,
      Utils.lastDayOfMonth(DateTime.now()).day);
  DateTime focusedDate = DateTime.now();
  CalendarFormat selectedCalendarFormat = CalendarFormat.month;

  @override
  void initState() {
    language = tr("lang");
    debugPrint("scheduleList ::::   ${widget.scheduleList}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      insetPadding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 30,
        bottom: 30.0,
      ),

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 16),
        child: TableCalendar(
          shouldFillViewport: true,
          availableGestures: AvailableGestures.horizontalSwipe,
          locale: Localizations.localeOf(context).languageCode,
          rangeSelectionMode: RangeSelectionMode.toggledOff,
          availableCalendarFormats: const {CalendarFormat.month: 'Month'},
          weekendDays: const [DateTime.saturday, DateTime.sunday],
          daysOfWeekHeight: 40,
          focusedDay: focusedDate,
          calendarFormat: selectedCalendarFormat,
          firstDay: kFirstDay,
          lastDay: kLastDay,
          headerStyle: HeaderStyle(
              headerPadding: EdgeInsets.only(
                  left: 0,
                  right: 0,
                  bottom: 8,
                  top: Platform.isAndroid ? 16 : 8),
              formatButtonVisible: false,
              titleCentered: false,
              titleTextStyle: const TextStyle(
                  fontFamily: 'SemiBold', fontSize: 16, color: Colors.black),
              titleTextFormatter: (date, locale) {
                return "${DateFormat.MMMM(locale).format(date)} ${DateFormat.y(locale).format(date)}";
              },
              leftChevronVisible: false,
              rightChevronVisible: false),
          daysOfWeekStyle: DaysOfWeekStyle(
              dowTextFormatter: (date, locale) =>
                  DateFormat.E(locale).format(date),
              weekdayStyle: const TextStyle(
                color: CustomColors.blackColor,
                fontFamily: 'Regular',
                fontSize: 14,
              ),
              weekendStyle: const TextStyle(
                color: CustomColors.blackColor,
                fontFamily: 'Regular',
                fontSize: 14,
              ),
              decoration: const BoxDecoration(
                  color: CustomColors.greyColor2,
                  border: Border(
                    bottom:
                        BorderSide(width: 1, color: CustomColors.borderColor),
                  ))),
          calendarStyle: const CalendarStyle(
              todayTextStyle: TextStyle(color: Colors.black),
              weekendTextStyle: TextStyle(color: Color(0xffCC6047)),
              disabledTextStyle: TextStyle(color: Colors.grey),
              disabledDecoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              todayDecoration: BoxDecoration(
                  color: CustomColors.backgroundColor3, shape: BoxShape.circle),
              selectedTextStyle: TextStyle(color: Colors.white),
              selectedDecoration: BoxDecoration(
                  color: Color(0xffCC6047), shape: BoxShape.circle),
              defaultTextStyle: TextStyle(
                fontFamily: 'Regular',
                fontSize: 14,
              )),
          selectedDayPredicate: (day) {
            // if (isSameDay(day, focusedDate)) {
            //   return true;
            // } else {
            //   return false;
            // }
            return false;
          },
          enabledDayPredicate: (day) {
            // if (day.weekday == DateTime.saturday ||
            //     day.weekday == DateTime.sunday) {
            //   return false;
            // } else if (day.day == kFirstDay.day &&
            //     day.month == kFirstDay.month &&
            //     day.year == kFirstDay.year) {
            //   return true;
            // } else if (day.compareTo(kFirstDay) > 0) {
            //   return true;
            // } else {
            //   return false;
            // }
            return true;
          },
          onFormatChanged: (format) {
            if (selectedCalendarFormat != format) {
              setState(() {
                selectedCalendarFormat = format;
              });
            }
          },
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, focusedDay) {
              var stringDate =
                  "${day.year}-${day.month.toString().length == 1 ? "0" : ""}${day.month}-${day.day.toString().length == 1 ? "0" : ""}${day.day}";
              List<dynamic> eventList = widget.scheduleList[stringDate] ?? [];
              return Container(
                  width: 150,
                  height: 140,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: day.day.compareTo(DateTime.now().day) == 0
                        ? CustomColors.backgroundColor3
                        : CustomColors.whiteColor,
                    border: Border.all(
                      width: 0.5,
                      color: CustomColors.borderColor,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                            getOrdinalDay(int.parse(DateFormat.d().format(day)),
                                language),
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              color: CustomColors.textColorBlack2,
                              fontFamily: 'Regular',
                              fontSize: 12,
                            )),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      if (eventList.isNotEmpty)
                        Expanded(
                          child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                      "${DateFormat('hh:mm a').format(DateTime.parse("$stringDate ${eventList[index]["start_time"]}"))}  ${eventList[index]["conference_hall"]}",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        color: CustomColors.textColorBlack2,
                                        fontFamily: 'Regular',
                                        fontSize: 12,
                                      )),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 8,
                                );
                              },
                              itemCount: eventList.length),
                        )
                    ],
                  ));
            },
            disabledBuilder: (context, day, focusedDay) {
              return Container(
                width: 150,
                height: 140,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: CustomColors.whiteColor,
                  border: Border.all(
                    width: 0.5,
                    color: CustomColors.borderColor,
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                      getOrdinalDay(
                          int.parse(DateFormat.d().format(day)), language),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: CustomColors.textColorBlack2,
                        fontFamily: 'Regular',
                        fontSize: 12,
                      )),
                ),
              );
            },
          ),
        ),
      ),
      // content: MonthView(
      //   showBorder: true,
      //   headerBuilder: (date) {
      //     return Padding(
      //       padding: const EdgeInsets.only(bottom: 8),
      //       child: Text(DateFormat.yMMMM().format(DateTime.now())),
      //     );
      //   },
      //   headerStyle: const HeaderStyle(
      //       leftIconVisible: false,
      //       rightIconVisible: false,
      //       leftIconPadding: EdgeInsets.all(0),
      //       rightIconPadding: EdgeInsets.all(0),
      //       titleAlign: TextAlign.start,
      //       headerPadding: EdgeInsets.only(bottom: 8),
      //       headerTextStyle: TextStyle(
      //           fontFamily: 'SemiBold',
      //           fontSize: 16,
      //           color: CustomColors.textColor8),
      //       decoration: BoxDecoration(color: Colors.red)),
      //   weekDayBuilder: (day) {
      //     return Container(
      //         padding: const EdgeInsets.all(8),
      //         color: CustomColors.greyColor2,
      //         child: Text(day == 0 ? "Mon" : "Tue"));
      //   },
      // ),
    );
  }
}
