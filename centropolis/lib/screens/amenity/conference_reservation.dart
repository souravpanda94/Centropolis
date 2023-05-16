import 'package:centropolis/widgets/common_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_modal.dart';

class ConferenceReservation extends StatefulWidget {
  const ConferenceReservation({super.key});

  @override
  State<ConferenceReservation> createState() => _ConferenceReservationState();
}

class _ConferenceReservationState extends State<ConferenceReservation> {
  DateTime kFirstDay = DateTime.now();
  DateTime kLastDay = DateTime.utc(2030, 3, 14);
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  bool _isChecked = false;
  TextEditingController rentalInfoController = TextEditingController();
  String? startTimeSelectedValue, endTimeSelectedValue;

  List<dynamic> timeList = [
    {"startTime": "9:00", "endTime": "12:00"},
    {"startTime": "10:00", "endTime": "13:00"},
    {"startTime": "14:00", "endTime": "18:00"},
    {"startTime": "12:00", "endTime": "19:00"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
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
                  tr("startTime"),
                  style: const TextStyle(
                      fontFamily: 'SemiBold',
                      fontSize: 14,
                      color: CustomColors.textColor8),
                ),
                const SizedBox(
                  height: 8,
                ),
                startTimeWidget(),
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
                endTimeWidget(),
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
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CustomColors.dividerGreyColor,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  height: 288,
                  child: SingleChildScrollView(
                    child: TextField(
                      controller: rentalInfoController,
                      cursorColor: CustomColors.textColorBlack2,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
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
            heading: tr("conferenceReservationComplete"),
            description: "We will contact you after checking the manager.",
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

  startTimeWidget() {
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
                  value: item["startTime"],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 16),
                        child: Text(
                          item["startTime"],
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

  endTimeWidget() {
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
                  value: item["endTime"],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 16),
                        child: Text(
                          item["endTime"],
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
}
