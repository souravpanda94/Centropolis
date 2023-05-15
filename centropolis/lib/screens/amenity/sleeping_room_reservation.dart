import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';

class SleepingRoomReservation extends StatefulWidget {
  const SleepingRoomReservation({super.key});

  @override
  State<SleepingRoomReservation> createState() =>
      _SleepingRoomReservationState();
}

class _SleepingRoomReservationState extends State<SleepingRoomReservation> {
  DateTime kFirstDay = DateTime.now();
  DateTime kLastDay = DateTime.utc(2030, 3, 14);
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  bool _isChecked = false, selected = false;
  List<dynamic> listData = [];
  List<dynamic> femaleListData = [];
  int selectedIndex = 0;

  String type = "female";
  String? usageTimeSelectedValue, totalTimeSelectedValue;

  List<dynamic> usageTimeList = [
    {"usageTime": "11:00", "total": "30 Minutes"},
    {"usageTime": "12:00", "total": "60 Minutes"},
    {"usageTime": "13:00", "total": "90 Minutes"},
    {"usageTime": "14:00", "total": "15 Minutes"},
  ];

  @override
  void initState() {
    super.initState();
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
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: CustomColors.whiteColor,
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
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
          Visibility(
            visible: type == "male",
            replacement: Container(
              height: 116,
              width: MediaQuery.of(context).size.width,
              color: CustomColors.backgroundColor,
              margin: const EdgeInsets.only(left: 16, right: 16),
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 24, bottom: 12),
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                              margin:
                                  const EdgeInsets.only(right: 15, bottom: 12),
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
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 24, bottom: 12),
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                              margin:
                                  const EdgeInsets.only(right: 15, bottom: 12),
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
          ),
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
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: const Text(
                            "11:00",
                            style: TextStyle(
                              color: CustomColors.textColorBlack2,
                              fontSize: 14,
                              fontFamily: 'Regular',
                            ),
                          ),
                          items: usageTimeList
                              .map((item) => DropdownMenuItem<String>(
                                    value: item["usageTime"],
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, bottom: 16),
                                          child: Text(
                                            item["usageTime"],
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4))),
                          ),
                          iconStyleData: IconStyleData(
                              icon: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    usageTimeSelectedValue != null ? 16 : 0),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4))),
                              padding: EdgeInsets.only(
                                  top: 16,
                                  right: 16,
                                  left: usageTimeSelectedValue != null ? 0 : 16,
                                  bottom:
                                      usageTimeSelectedValue != null ? 0 : 16),
                              elevation: 0),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.all(0),
                            height: 53,
                          ),
                        ),
                      ),
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
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: const Text(
                            "10 minutes",
                            style: TextStyle(
                              color: CustomColors.textColorBlack2,
                              fontSize: 14,
                              fontFamily: 'Regular',
                            ),
                          ),
                          items: usageTimeList
                              .map((item) => DropdownMenuItem<String>(
                                    value: item["total"],
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, bottom: 16),
                                          child: Text(
                                            item["total"],
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
                              totalTimeSelectedValue = value as String;
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4))),
                          ),
                          iconStyleData: IconStyleData(
                              icon: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    totalTimeSelectedValue != null ? 16 : 0),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4))),
                              padding: EdgeInsets.only(
                                  top: 16,
                                  right: 16,
                                  left: totalTimeSelectedValue != null ? 0 : 16,
                                  bottom:
                                      totalTimeSelectedValue != null ? 0 : 16),
                              elevation: 0),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.all(0),
                            height: 53,
                          ),
                        ),
                      ),
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
            ),
          ),
        ],
      )),
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
}
