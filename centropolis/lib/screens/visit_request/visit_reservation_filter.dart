import 'package:centropolis/widgets/common_button_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';

class VisitReservationFilter extends StatefulWidget {
  const VisitReservationFilter({super.key});

  @override
  State<VisitReservationFilter> createState() => _VisitReservationFilterState();
}

class _VisitReservationFilterState extends State<VisitReservationFilter> {
  bool statusTapped = false;
  int showIndex = 0;

  List<String> dateFilterList = [
    tr("todayFilter"),
    tr("week"),
    tr("month"),
    tr("directInput")
  ];
  TextEditingController statusController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime kFirstDay = DateTime.now();
  DateTime kLastDay = DateTime.utc(2030, 3, 14);
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay,
      _startDate = DateTime.now(),
      _endDate = DateTime.now().add(const Duration(days: 3));

  @override
  void initState() {
    super.initState();
    showIndex == 0
        ? dateController.text = DateFormat('yyyy.MM.dd').format(DateTime.now())
        : null;
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
            child: CommonAppBar(tr("filter"), false, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        color: CustomColors.whiteColor,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RichText(
            text: TextSpan(
                text: tr("reservationStatus"),
                style: const TextStyle(
                    fontFamily: 'SemiBold',
                    fontSize: 14,
                    color: CustomColors.textColor8),
                children: const [
                  TextSpan(
                      text: ' *',
                      style: TextStyle(
                          color: CustomColors.headingColor, fontSize: 12))
                ]),
            maxLines: 1,
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: statusController,
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
                hintText: "In progress",
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
                statusTapped = true;
              });
            },
          ),
          const SizedBox(
            height: 16,
          ),
          RichText(
            text: TextSpan(
                text: tr("periodOfUse"),
                style: const TextStyle(
                    fontFamily: 'SemiBold',
                    fontSize: 14,
                    color: CustomColors.textColor8),
                children: const [
                  TextSpan(
                      text: ' *',
                      style: TextStyle(
                          color: CustomColors.headingColor, fontSize: 12))
                ]),
            maxLines: 1,
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              color: CustomColors.backgroundColor,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: dateFilterList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      showIndex = index;
                      _selectedDay = null;
                      _focusedDay = DateTime.now();

                      showIndex == 0
                          ? dateController.text =
                              "${DateFormat('yyyy.MM.dd').format(DateTime.now())} - ${DateFormat('yyyy.MM.dd').format(DateTime.now())}"
                          : showIndex == 1
                              ? dateController.text =
                                  "${DateFormat('yyyy.MM.dd').format(DateTime.now())} - ${DateFormat('yyyy.MM.dd').format(DateTime.now().add(const Duration(days: 7)))}"
                              : dateController.clear();
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: showIndex == index
                            ? CustomColors.whiteColor
                            : CustomColors.backgroundColor,
                        border: showIndex == index
                            ? Border.all(
                                color: CustomColors.textColorBlack2,
                              )
                            : null,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50))),
                    child: Text(
                      dateFilterList[index],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: showIndex == index
                              ? CustomColors.textColorBlack2
                              : CustomColors.textColor3),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: dateController,
            cursorColor: CustomColors.textColorBlack2,
            keyboardType: TextInputType.datetime,
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
                hintText: "YYYY.MM.DD - YYYY.MM.DD",
                hintStyle: const TextStyle(
                  color: CustomColors.textColorBlack2,
                  fontSize: 14,
                  fontFamily: 'Regular',
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SvgPicture.asset(
                    "assets/images/ic_date.svg",
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
              if (showIndex != 0 && showIndex != 1) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (BuildContext context,
                          void Function(void Function()) setState) {
                        return Dialog(
                          insetPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TableCalendar(
                                  rangeSelectionMode: showIndex == 3
                                      ? RangeSelectionMode.enforced
                                      : RangeSelectionMode.toggledOff,
                                  rangeStartDay:
                                      showIndex == 3 ? _startDate : null,
                                  rangeEndDay: showIndex == 3 ? _endDate : null,
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
                                    titleTextFormatter: (date, locale) {
                                      return "${DateFormat.y(locale).format(date)}.${DateFormat.M(locale).format(date).length == 1 ? "0" : ""}${DateFormat.M(locale).format(date)}";
                                    },
                                  ),
                                  daysOfWeekStyle: DaysOfWeekStyle(
                                      dowTextFormatter: (date, locale) =>
                                          DateFormat.E(locale)
                                              .format(date)
                                              .toUpperCase(),
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
                                      rangeHighlightColor:
                                          CustomColors.backgroundColor2,
                                      rangeStartDecoration: const BoxDecoration(
                                          color: Color(0xffCC6047),
                                          shape: BoxShape.circle),
                                      rangeEndDecoration: const BoxDecoration(
                                          color: Color(0xffCC6047),
                                          shape: BoxShape.circle),
                                      todayTextStyle: TextStyle(
                                          color: _focusedDay
                                                      .compareTo(kFirstDay) !=
                                                  0
                                              ? Colors.black
                                              : Colors.white),
                                      weekendTextStyle: const TextStyle(
                                          color: Color(0xffCC6047)),
                                      disabledTextStyle:
                                          const TextStyle(color: Colors.grey),
                                      disabledDecoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      todayDecoration: BoxDecoration(
                                          color: _focusedDay
                                                      .compareTo(kFirstDay) !=
                                                  0
                                              ? Colors.white
                                              : const Color(0xffCC6047),
                                          shape: BoxShape.circle),
                                      selectedTextStyle:
                                          const TextStyle(color: Colors.white),
                                      selectedDecoration: const BoxDecoration(
                                          color: Color(0xffCC6047),
                                          shape: BoxShape.circle),
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
                                  onRangeSelected: (start, end, focusedDay) {
                                    setState(() {
                                      _focusedDay = focusedDay;
                                      _startDate = start;
                                      _endDate = end;
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
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 16, right: 16, top: 16, bottom: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: CommonButtonWithBorder(
                                          buttonTextColor: CustomColors
                                              .buttonBackgroundColor,
                                          buttonBorderColor: CustomColors
                                              .buttonBackgroundColor,
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
                                            if (showIndex == 2 &&
                                                _selectedDay != null) {
                                              dateController.text =
                                                  "${DateFormat('yyyy.MM.dd').format(_selectedDay!)} - ${DateFormat('yyyy.MM.dd').format(_selectedDay!.add(const Duration(days: 30)))}";
                                            } else if (showIndex == 3 &&
                                                _startDate != null &&
                                                _endDate != null) {
                                              dateController.text =
                                                  "${DateFormat('yyyy.MM.dd').format(_startDate!)} - ${DateFormat('yyyy.MM.dd').format(_endDate!)}";
                                            }

                                            Navigator.pop(context);
                                          },
                                          buttonColor: CustomColors
                                              .buttonBackgroundColor,
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
            },
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                color: CustomColors.whiteColor,
                padding: const EdgeInsets.only(top: 16, bottom: 24),
                child: CommonButton(
                  onCommonButtonTap: () {},
                  buttonColor: CustomColors.buttonBackgroundColor,
                  buttonName: tr("check"),
                  isIconVisible: false,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
