import 'package:centropolis/screens/visit_request/view_visit_reservation_new.dart';
import 'package:centropolis/widgets/common_button_with_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';

class VisitReservationFilter extends StatefulWidget {
  final List<dynamic> filteredStatusList;
  const VisitReservationFilter({super.key, required this.filteredStatusList});

  @override
  State<VisitReservationFilter> createState() => _VisitReservationFilterState();
}

class _VisitReservationFilterState extends State<VisitReservationFilter> {
  int showIndex = 0;

  List<String> dateFilterList = [
    tr("todayFilter"),
    tr("week"),
    tr("month"),
    tr("directInput")
  ];
  TextEditingController dateController = TextEditingController();
  String? statusSelectedValue;

  DateTime kFirstDay = DateTime.now();
  DateTime kLastDay = DateTime.utc(2030, 3, 14);
  DateTime focusedDate = DateTime.now();
  CalendarFormat selectedCalendarFormat = CalendarFormat.month;
  DateTime? selectedDate;
  DateTime? selectedStartDate = DateTime.now();
  DateTime? selectedEndDate = DateTime.now().add(const Duration(days: 3));

  @override
  void initState() {
    super.initState();
    if (showIndex == 0) {
      selectedStartDate = DateTime.now();
      selectedEndDate = DateTime.now();
      dateController.text =
          "${DateFormat('yyyy.MM.dd').format(DateTime.now())} - ${DateFormat('yyyy.MM.dd').format(DateTime.now())}";
    }
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
          reservationStatusDropdownWidget(),
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
            width: MediaQuery.of(context).size.width,
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
                      selectedDate = null;
                      focusedDate = DateTime.now();
                      showIndex == 0
                          ? dateController.text =
                              "${DateFormat('yyyy.MM.dd').format(DateTime.now())} - ${DateFormat('yyyy.MM.dd').format(DateTime.now())}"
                          : showIndex == 1
                              ? dateController.text =
                                  "${DateFormat('yyyy.MM.dd').format(DateTime.now())} - ${DateFormat('yyyy.MM.dd').format(DateTime.now().add(const Duration(days: 7)))}"
                              : showIndex == 2
                                  ? dateController.text =
                                      "${DateFormat('yyyy.MM.dd').format(DateTime.now())} - ${DateFormat('yyyy.MM.dd').format(DateTime.now().add(const Duration(days: 30)))}"
                                  : dateController.clear();
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
              if (showIndex == 3) {
                openDateRangePickerWidget();
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
                  onCommonButtonTap: () {
                    goToPreviousPage();
                  },
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

  reservationStatusDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          widget.filteredStatusList.isNotEmpty
              ? widget.filteredStatusList.first["text"]
              : tr('all'),
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: widget.filteredStatusList
            .map((item) => DropdownMenuItem<String>(
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
                ))
            .toList(),
        value: statusSelectedValue,
        onChanged: (value) {
          setState(() {
            statusSelectedValue = value as String;
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
              EdgeInsets.only(bottom: statusSelectedValue != null ? 16 : 0),
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
                left: statusSelectedValue != null ? 0 : 16,
                bottom: statusSelectedValue != null ? 0 : 16),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.all(0),
          height: 53,
        ),
      ),
    );
  }

  openDateRangePickerWidget() {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TableCalendar(
                      rangeSelectionMode: showIndex == 3
                          ? RangeSelectionMode.enforced
                          : RangeSelectionMode.toggledOff,
                      rangeStartDay: showIndex == 3 ? selectedStartDate : null,
                      rangeEndDay: showIndex == 3 ? selectedEndDate : null,
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month'
                      },
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
                            fontFamily: 'SemiBold',
                            fontSize: 16,
                            color: Colors.black),
                        titleTextFormatter: (date, locale) {
                          return "${DateFormat.y(locale).format(date)}.${DateFormat.M(locale).format(date).length == 1 ? "0" : ""}${DateFormat.M(locale).format(date)}";
                        },
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
                          rangeHighlightColor: CustomColors.backgroundColor2,
                          rangeStartDecoration: const BoxDecoration(
                              color: Color(0xffCC6047), shape: BoxShape.circle),
                          rangeEndDecoration: const BoxDecoration(
                              color: Color(0xffCC6047), shape: BoxShape.circle),
                          todayTextStyle: TextStyle(
                              color: focusedDate.compareTo(kFirstDay) != 0
                                  ? Colors.black
                                  : Colors.white),
                          weekendTextStyle:
                              const TextStyle(color: Color(0xffCC6047)),
                          disabledTextStyle:
                              const TextStyle(color: Colors.grey),
                          disabledDecoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          todayDecoration: BoxDecoration(
                              color: focusedDate.compareTo(kFirstDay) != 0
                                  ? Colors.white
                                  : const Color(0xffCC6047),
                              shape: BoxShape.circle),
                          selectedTextStyle:
                              const TextStyle(color: Colors.white),
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
                      onRangeSelected: (start, end, focusedDay) {
                        setState(() {
                          focusedDate = focusedDay;
                          selectedStartDate = start;
                          selectedEndDate = end;
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
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: CommonButtonWithBorder(
                              buttonTextColor:
                                  CustomColors.buttonBackgroundColor,
                              buttonBorderColor:
                                  CustomColors.buttonBackgroundColor,
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
                                if (showIndex == 2 && selectedDate != null) {
                                  dateController.text =
                                      "${DateFormat('yyyy.MM.dd').format(selectedDate!)} - ${DateFormat('yyyy.MM.dd').format(selectedDate!.add(const Duration(days: 30)))}";
                                } else if (showIndex == 3 &&
                                    selectedStartDate != null &&
                                    selectedEndDate != null) {
                                  dateController.text =
                                      "${DateFormat('yyyy.MM.dd').format(selectedStartDate!)} - ${DateFormat('yyyy.MM.dd').format(selectedEndDate!)}";
                                }

                                Navigator.pop(context);
                              },
                              buttonColor: CustomColors.buttonBackgroundColor,
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

  void goToPreviousPage() {
    if ((statusSelectedValue == null || statusSelectedValue!.isEmpty) &&
        widget.filteredStatusList.isNotEmpty) {
      statusSelectedValue = widget.filteredStatusList.first["value"];
    }
    if (showIndex == 0) {
      selectedStartDate = DateTime.now();
      selectedEndDate = DateTime.now();
    } else if (showIndex == 1) {
      selectedStartDate = DateTime.now();
      selectedEndDate = DateTime.now().add(const Duration(days: 7));
    } else if (showIndex == 2) {
      selectedStartDate = DateTime.now();
      selectedEndDate = DateTime.now().add(const Duration(days: 30));
    }

    String startDay = selectedStartDate?.day.toString() ?? "";
    String startMonth = selectedStartDate?.month.toString() ?? "";
    String startYear = selectedStartDate?.year.toString() ?? "";
    String startDate;
    String endDate;

    if (int.parse(startDay) < 10 && int.parse(startMonth) < 10) {
      startDate = '$startYear-0$startMonth-0$startDay';
    } else if (int.parse(startDay) < 10) {
      startDate = '$startYear-$startMonth-0$startDay';
    } else if (int.parse(startMonth) < 10) {
      startDate = '$startYear-0$startMonth-$startDay';
    } else {
      startDate = '$startYear-$startMonth-$startDay';
    }

    String endDay = selectedEndDate?.day.toString() ?? "";
    String endMonth = selectedEndDate?.month.toString() ?? "";
    String endYear = selectedEndDate?.year.toString() ?? "";

    if (int.parse(endDay) < 10 && int.parse(endMonth) < 10) {
      endDate = '$endYear-0$endMonth-0$endDay';
    } else if (int.parse(endDay) < 10) {
      endDate = '$endYear-$endMonth-0$endDay';
    } else if (int.parse(endMonth) < 10) {
      endDate = '$endYear-0$endMonth-$endDay';
    } else {
      endDate = '$endYear-$endMonth-$endDay';
    }

    // String startDate =
    //     "${selectedStartDate?.year}-${selectedStartDate?.month.toString().length == 1  ? selectedStartDate?.month : selectedStartDate?.month}-${selectedStartDate?.day}";
    // String endDate =
    //     "${selectedEndDate?.year}-${selectedEndDate?.month}-${selectedEndDate?.day}";
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewVisitReservationScreenNew(
            statusSelectedValue, startDate, endDate),
      ),
    );
  }
}
