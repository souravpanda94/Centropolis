import 'package:centropolis/widgets/common_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button_with_border.dart';

class VisitReservationApplication extends StatefulWidget {
  const VisitReservationApplication({super.key});

  @override
  State<VisitReservationApplication> createState() =>
      _VisitReservationApplicationState();
}

class _VisitReservationApplicationState
    extends State<VisitReservationApplication> {
  TextEditingController consentController = TextEditingController();
  TextEditingController visitorNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController purposeVisitController = TextEditingController();

  bool isChecked = false;
  String? timeSelectedValue;
  String? purposeSelectedValue;

  DateTime kFirstDay = DateTime.now();
  DateTime kLastDay = DateTime.utc(2030, 3, 14);
  DateTime focusedDate = DateTime.now();
  CalendarFormat selectedCalendarFormat = CalendarFormat.month;
  DateTime? selectedDate;

  List<dynamic> list = [
    {"time": "10:00", "purpose": "Business Discussion"},
    {"time": "11:00", "purpose": "Business"},
    {"time": "12:00", "purpose": "Discussion"},
    {"time": "13:00", "purpose": "test"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("visitReservationApplication"), false, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: CustomColors.whiteColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr("signUpConsent"),
                      style: const TextStyle(
                          fontFamily: 'Bold',
                          fontSize: 16,
                          color: CustomColors.textColor8),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      tr("visitReservationApplicationWarning"),
                      style: const TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 14,
                          color: CustomColors.textColorBlack2),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: CustomColors.dividerGreyColor,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      height: 264,
                      child: SingleChildScrollView(
                        child: TextField(
                          controller: consentController,
                          cursorColor: CustomColors.textColorBlack2,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: CustomColors.whiteColor,
                            filled: true,
                            contentPadding: const EdgeInsets.all(16),
                            hintText: tr('signUpConsentHint'),
                            hintStyle: const TextStyle(
                              color: CustomColors.textColor3,
                              fontSize: 14,
                              fontFamily: 'Regular',
                            ),
                          ),
                          style: const TextStyle(
                            color: CustomColors.blackColor,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            tr("signUpConsentConfirmation"),
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
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
                height: 10,
                color: CustomColors.backgroundColor,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                color: CustomColors.whiteColor,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr("personInChargeInformation"),
                      style: const TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 16,
                          color: CustomColors.textColor8),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: CustomColors.backgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: tr("nameOfPersonInCharge"),
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
                          const Text(
                            "Hong Gil Dong",
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          RichText(
                            text: TextSpan(
                                text: tr("tenantCompany"),
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
                          const Text(
                            "CBRE",
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          RichText(
                            text: TextSpan(
                                text: tr("visitBuilding"),
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
                          const Text(
                            "Tower A",
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          RichText(
                            text: TextSpan(
                                text: tr("landingFloor"),
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
                          const Text(
                            "11F",
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 10,
                color: CustomColors.backgroundColor,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                color: CustomColors.whiteColor,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr("visitorInformation"),
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
                          text: tr("visitorName"),
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
                    TextField(
                      controller: visitorNameController,
                      cursorColor: CustomColors.textColorBlack2,
                      keyboardType: TextInputType.text,
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
                        hintText: tr('visitorNameHint'),
                        hintStyle: const TextStyle(
                          color: CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.blackColor,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                          text: tr("companyName"),
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
                    TextField(
                      controller: companyNameController,
                      cursorColor: CustomColors.textColorBlack2,
                      keyboardType: TextInputType.text,
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
                        hintText: tr('companyNameHint'),
                        hintStyle: const TextStyle(
                          color: CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.blackColor,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                          text: tr("email"),
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
                    TextField(
                      controller: emailController,
                      cursorColor: CustomColors.textColorBlack2,
                      keyboardType: TextInputType.text,
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
                        hintText: tr('emailDemoHint'),
                        hintStyle: const TextStyle(
                          color: CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.blackColor,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                          text: tr("contact"),
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
                    TextField(
                      controller: contactController,
                      cursorColor: CustomColors.textColorBlack2,
                      keyboardType: TextInputType.text,
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
                        hintText: tr('contactHint'),
                        hintStyle: const TextStyle(
                          color: CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.blackColor,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                          text: tr("dateOfVisit"),
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
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      cursorColor: CustomColors.textColorBlack2,
                      keyboardType: TextInputType.text,
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
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SvgPicture.asset(
                            "assets/images/ic_date.svg",
                            width: 8,
                            height: 4,
                            color: CustomColors.textColorBlack2,
                          ),
                        ),
                        hintText: "YYYY.MM.DD",
                        hintStyle: const TextStyle(
                          color: CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.blackColor,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                      onTap: () {
                        openDatePickerWidget();
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                          text: tr("visitTime"),
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
                    visitTimeDropdownWidget(),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                          text: tr("purposeOfVisit"),
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
                    purposeVisitDropdownWidget(),
                  ],
                ),
              ),
              Container(
                height: 10,
                color: CustomColors.backgroundColor,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                alignment: FractionalOffset.bottomCenter,
                width: MediaQuery.of(context).size.width,
                color: CustomColors.whiteColor,
                padding: const EdgeInsets.only(
                    top: 16, left: 16, right: 16, bottom: 40),
                child: CommonButton(
                  onCommonButtonTap: () {},
                  buttonColor: CustomColors.buttonBackgroundColor,
                  buttonName: tr("visitReservationApplication"),
                  isIconVisible: false,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  visitTimeDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          tr('visitTimeHint'),
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: list
            .map((item) => DropdownMenuItem<String>(
                  value: item["time"],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 16),
                        child: Text(
                          item["time"],
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
        value: timeSelectedValue,
        onChanged: (value) {
          setState(() {
            timeSelectedValue = value as String;
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
          padding: EdgeInsets.only(bottom: timeSelectedValue != null ? 16 : 0),
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
                left: timeSelectedValue != null ? 0 : 16,
                bottom: timeSelectedValue != null ? 0 : 16),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.all(0),
          height: 53,
        ),
      ),
    );
  }

  purposeVisitDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: const Text(
          "business discussion",
          style: TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: list
            .map((item) => DropdownMenuItem<String>(
                  value: item["purpose"],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 16),
                        child: Text(
                          item["purpose"],
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
        value: purposeSelectedValue,
        onChanged: (value) {
          setState(() {
            purposeSelectedValue = value as String;
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
              EdgeInsets.only(bottom: purposeSelectedValue != null ? 16 : 0),
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
                left: purposeSelectedValue != null ? 0 : 16,
                bottom: purposeSelectedValue != null ? 0 : 16),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.all(0),
          height: 53,
        ),
      ),
    );
  }

  openDatePickerWidget() {
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
                                if (selectedDate != null) {
                                  dateController.text = DateFormat('yyyy.MM.dd')
                                      .format(selectedDate!);
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
}
