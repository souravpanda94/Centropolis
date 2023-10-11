import 'dart:convert';
import 'dart:math';

import 'package:centropolis/utils/firebase_analytics_events.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../models/user_info_model.dart';
import '../../providers/user_info_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_modal.dart';

class FitnessTabReservation extends StatefulWidget {
  const FitnessTabReservation({super.key});

  @override
  State<FitnessTabReservation> createState() => _FitnessTabReservationState();
}

class _FitnessTabReservationState extends State<FitnessTabReservation> {
  late String language, apiKey, gender;
  String companyName = "";
  String name = "";
  String email = "";
  String mobile = "";
  late FToast fToast;
  bool isLoading = false;
  DateTime kFirstDay = DateTime.now();
  DateTime kLastDay = DateTime.utc(2030, 3, 14);
  DateTime focusedDate = DateTime.now();
  CalendarFormat selectedCalendarFormat = CalendarFormat.month;
  DateTime? selectedDate;
  bool isChecked = false;
  bool selected = false;
  List<dynamic> seatAvailibilityList = [];
  int selectedIndex = 0;
  String? usageTimeSelectedValue;
  String? totalTimeSelectedValue;
  var dateFormat = DateFormat('yyyy-MM-dd');
  List<dynamic> timeList = [];
  List<dynamic> totalUsageTimeList = [];
  String reservationDate = "";
  int selectedSeat = 0;
  bool firstTimeSeatAvailabilityLoading = true;
  TextEditingController seatController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    gender = user.userData['gender'].toString();
    // email = user.userData['email_key'].toString();
    // mobile = user.userData['mobile'].toString();
    //name = user.userData['name'].toString();
    //companyName = user.userData['company_name'].toString();
    internetCheckingForMethods();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.textColor4,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isLoading,
      child: SingleChildScrollView(
          primary: false,
          child: Container(
            color: CustomColors.whiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 8, left: 16, right: 16),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    tr("serviceRequires"),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 12,
                        color: CustomColors.textColor3),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: CustomColors.backgroundColor,
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr("fitnessReservationProgram"),
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 16,
                            color: CustomColors.textColorBlack2),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          tr("vat"),
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 12,
                              color: CustomColors.greyColor1),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      fitnessCustomTableView()

                      // Row(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       const Padding(
                      //         padding: EdgeInsets.only(top: 7),
                      //         child: Icon(
                      //           Icons.circle,
                      //           size: 5,
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         width: 10,
                      //       ),
                      //       Expanded(
                      //         child: Text(
                      //           tr("fitnessReservationProgramDesc"),
                      //           style: const TextStyle(
                      //               fontFamily: 'Regular',
                      //               fontSize: 14,
                      //               height: 1.5,
                      //               color: CustomColors.textColor5),
                      //         ),
                      //       )
                      //     ]),
                    ],
                  ),
                ),

                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   color: CustomColors.whiteColor,
                //   padding: const EdgeInsets.only(
                //       left: 16, right: 16, top: 16, bottom: 8),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         tr("lockerSelection"),
                //         style: const TextStyle(
                //           fontSize: 16,
                //           color: CustomColors.textColor8,
                //           fontFamily: 'SemiBold',
                //         ),
                //       ),
                //       const SizedBox(
                //         height: 8,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         mainAxisSize: MainAxisSize.max,
                //         children: [
                //           Expanded(
                //             flex: 1,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               mainAxisSize: MainAxisSize.min,
                //               children: [
                //                 const Icon(
                //                   Icons.square_outlined,
                //                   size: 15,
                //                   color: CustomColors.textColor9,
                //                 ),
                //                 const SizedBox(
                //                   width: 4,
                //                 ),
                //                 Text(
                //                   tr("availableBasket"),
                //                   style: const TextStyle(
                //                     fontSize: 12,
                //                     color: CustomColors.textColor8,
                //                     fontFamily: 'Medium',
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //           Expanded(
                //             flex: 1,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               mainAxisSize: MainAxisSize.min,
                //               children: [
                //                 const Icon(
                //                   Icons.square_outlined,
                //                   size: 15,
                //                   color: CustomColors.tabColor,
                //                 ),
                //                 const SizedBox(
                //                   width: 4,
                //                 ),
                //                 Text(
                //                   tr("availableLocker"),
                //                   style: const TextStyle(
                //                     fontSize: 12,
                //                     color: CustomColors.textColor8,
                //                     fontFamily: 'Medium',
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 5,
                //           ),
                //         ],
                //       ),
                //       const SizedBox(
                //         height: 8,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         mainAxisSize: MainAxisSize.max,
                //         children: [
                //           Expanded(
                //             flex: 1,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               mainAxisSize: MainAxisSize.min,
                //               children: [
                //                 const Icon(
                //                   Icons.square,
                //                   size: 15,
                //                   color: CustomColors.textColor9,
                //                 ),
                //                 const SizedBox(
                //                   width: 4,
                //                 ),
                //                 Text(
                //                   tr("selectBasket"),
                //                   style: const TextStyle(
                //                     fontSize: 12,
                //                     color: CustomColors.textColor8,
                //                     fontFamily: 'Medium',
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //           Expanded(
                //             flex: 1,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               mainAxisSize: MainAxisSize.min,
                //               children: [
                //                 const Icon(
                //                   Icons.square,
                //                   size: 15,
                //                   color: CustomColors.tabColor,
                //                 ),
                //                 const SizedBox(
                //                   width: 4,
                //                 ),
                //                 Text(
                //                   tr("selectLocker"),
                //                   style: const TextStyle(
                //                     fontSize: 12,
                //                     color: CustomColors.textColor8,
                //                     fontFamily: 'Medium',
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 5,
                //           ),
                //         ],
                //       ),
                //       const SizedBox(
                //         height: 8,
                //       ),
                //       Row(
                //         children: [
                //           const Icon(
                //             Icons.square,
                //             size: 15,
                //             color: CustomColors.borderColor,
                //           ),
                //           const SizedBox(
                //             width: 4,
                //           ),
                //           Text(
                //             tr("taken"),
                //             style: const TextStyle(
                //               fontSize: 12,
                //               color: CustomColors.textColor8,
                //               fontFamily: 'Medium',
                //             ),
                //           )
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // lockerSelectionWidget(),
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
                // Container(
                //   color: CustomColors.whiteColor,
                //   width: MediaQuery.of(context).size.width,
                //   padding: const EdgeInsets.all(16),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         tr("reservationInformation"),
                //         style: const TextStyle(
                //             fontFamily: 'SemiBold',
                //             fontSize: 16,
                //             color: CustomColors.textColor8),
                //       ),
                //       const SizedBox(
                //         height: 16,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             tr("nameLounge"),
                //             style: const TextStyle(
                //                 fontFamily: 'SemiBold',
                //                 fontSize: 14,
                //                 color: CustomColors.textColorBlack2),
                //           ),
                //           Text(
                //             name,
                //             style: const TextStyle(
                //                 fontFamily: 'Regular',
                //                 fontSize: 14,
                //                 color: CustomColors.textColorBlack2),
                //           )
                //         ],
                //       ),
                //       const Padding(
                //         padding: EdgeInsets.symmetric(vertical: 16),
                //         child: Divider(
                //           thickness: 1,
                //           height: 1,
                //           color: CustomColors.backgroundColor2,
                //         ),
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             tr("tenantCompanyLounge"),
                //             style: const TextStyle(
                //                 fontFamily: 'SemiBold',
                //                 fontSize: 14,
                //                 color: CustomColors.textColorBlack2),
                //           ),
                //           Text(
                //             companyName,
                //             style: const TextStyle(
                //                 fontFamily: 'Regular',
                //                 fontSize: 14,
                //                 color: CustomColors.textColorBlack2),
                //           )
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   color: CustomColors.backgroundColor,
                //   height: 10,
                // ),
                // Container(
                //   color: CustomColors.whiteColor,
                //   width: MediaQuery.of(context).size.width,
                //   padding: const EdgeInsets.all(16),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         tr("selectReservationDate"),
                //         style: const TextStyle(
                //             fontFamily: 'SemiBold',
                //             fontSize: 16,
                //             color: CustomColors.textColor8),
                //       ),
                //       const SizedBox(
                //         height: 16,
                //       ),
                //       tableCalendarWidget(),
                //     ],
                //   ),
                // ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   color: CustomColors.backgroundColor,
                //   height: 10,
                // ),
                // Container(
                //   color: CustomColors.whiteColor,
                //   padding: const EdgeInsets.only(
                //       left: 16, right: 16, top: 16, bottom: 16),
                //   width: MediaQuery.of(context).size.width,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         tr("timeSelection"),
                //         style: const TextStyle(
                //             fontFamily: 'SemiBold',
                //             fontSize: 16,
                //             color: CustomColors.textColor8),
                //       ),
                //       const SizedBox(
                //         height: 24,
                //       ),
                //       Text(
                //         tr("usageTime"),
                //         style: const TextStyle(
                //             fontFamily: 'SemiBold',
                //             fontSize: 14,
                //             color: CustomColors.textColor8),
                //       ),
                //       const SizedBox(
                //         height: 8,
                //       ),
                //       usageTimeDropdownWidget(),
                //       const SizedBox(
                //         height: 16,
                //       ),
                //       Text(
                //         tr("totalUsageTime"),
                //         style: const TextStyle(
                //             fontFamily: 'SemiBold',
                //             fontSize: 14,
                //             color: CustomColors.textColor8),
                //       ),
                //       const SizedBox(
                //         height: 8,
                //       ),
                //       totalUsageTimeDropdownWidget(),
                //       const SizedBox(
                //         height: 16,
                //       ),
                //       Text(
                //         tr("selectedSeat"),
                //         style: const TextStyle(
                //             fontFamily: 'SemiBold',
                //             fontSize: 14,
                //             color: CustomColors.textColor8),
                //       ),
                //       const SizedBox(
                //         height: 8,
                //       ),
                //       SizedBox(
                //         height: 46,
                //         child: TextField(
                //           controller: seatController,
                //           readOnly: true,
                //           cursorColor: CustomColors.textColorBlack2,
                //           keyboardType: TextInputType.number,
                //           decoration: InputDecoration(
                //             border: InputBorder.none,
                //             fillColor: CustomColors.whiteColor,
                //             filled: true,
                //             contentPadding: const EdgeInsets.all(16),
                //             enabledBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(4),
                //               borderSide: const BorderSide(
                //                   color: CustomColors.dividerGreyColor,
                //                   width: 1.0),
                //             ),
                //             focusedBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(4),
                //               borderSide: const BorderSide(
                //                   color: CustomColors.dividerGreyColor,
                //                   width: 1.0),
                //             ),
                //             hintText: tr('seatValidation'),
                //             hintStyle: const TextStyle(
                //               height: 1.5,
                //               color: CustomColors.textColor3,
                //               fontSize: 14,
                //               fontFamily: 'Regular',
                //             ),
                //           ),
                //           style: const TextStyle(
                //             height: 1.5,
                //             color: CustomColors.textColorBlack2,
                //             fontSize: 14,
                //             fontFamily: 'Regular',
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   color: CustomColors.backgroundColor,
                //   height: 10,
                // ),
                // Container(
                //   alignment: FractionalOffset.bottomCenter,
                //   color: CustomColors.whiteColor,
                //   width: MediaQuery.of(context).size.width,
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(top: 16),
                //         child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           children: [
                //             SizedBox(
                //               height: 15,
                //               width: 15,
                //               child: Transform.scale(
                //                 scale: 0.8,
                //                 child: Checkbox(
                //                   checkColor: CustomColors.whiteColor,
                //                   activeColor:
                //                       CustomColors.buttonBackgroundColor,
                //                   side: const BorderSide(
                //                       color: CustomColors.greyColor, width: 1),
                //                   value: isChecked,
                //                   onChanged: (value) {
                //                     setState(() {
                //                       isChecked = value!;
                //                       if (isChecked) {
                //                       } else {}
                //                     });
                //                   },
                //                 ),
                //               ),
                //             ),
                //             const SizedBox(
                //               width: 9,
                //             ),
                //             Text(
                //               tr("gxReservationConsent"),
                //               style: const TextStyle(
                //                   fontFamily: 'Regular',
                //                   fontSize: 14,
                //                   color: CustomColors.textColorBlack2),
                //             )
                //           ],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(top: 24, bottom: 32),
                //         child: CommonButton(
                //           onCommonButtonTap: () {
                //             reservationValidationCheck();
                //           },
                //           buttonColor: CustomColors.buttonBackgroundColor,
                //           buttonName: tr("makeReservation"),
                //           isIconVisible: false,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          )),
    );
  }

  usageTimeDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          timeList.isNotEmpty ? timeList.first : "06:30",
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: timeList
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 9),
                        child: Text(
                          item,
                          style: const TextStyle(
                            color: CustomColors.blackColor,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      if (item != timeList.last)
                        const Divider(
                          thickness: 1,
                          height: 1,
                          color: CustomColors.dividerGreyColor,
                        )
                    ],
                  ),
                ))
            .toList(),
        value: usageTimeSelectedValue,
        onChanged: (value) {
          setState(() {
            usageTimeSelectedValue = value as String;
            selectedSeat = 0;
            selectedIndex = 0;
            selected = false;

            seatController.clear();
          });
          loadSeatAvailability();
        },
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          isOverButton: false,
          elevation: 0,
          padding: const EdgeInsets.only(top: 0, bottom: 0),
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
              EdgeInsets.only(bottom: usageTimeSelectedValue != null ? 12 : 0),
          child: SvgPicture.asset(
            "assets/images/ic_drop_down_arrow.svg",
            width: 8,
            height: 8,
            color: CustomColors.textColorBlack2,
          ),
        )),
        buttonStyleData: ButtonStyleData(
            height: 46,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColors.dividerGreyColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            padding: EdgeInsets.only(
                top: 10,
                right: 12,
                left: usageTimeSelectedValue != null ? 0 : 13,
                bottom: usageTimeSelectedValue != null ? 0 : 11),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          overlayColor:
              MaterialStatePropertyAll(CustomColors.dropdownHoverColor),
          padding: EdgeInsets.only(top: 14),
          height: 46,
        ),
      ),
    );
  }

  totalUsageTimeDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          totalUsageTimeList.isNotEmpty
              ? totalUsageTimeList.first["text"]
              : "30 Minutes",
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
                        padding: const EdgeInsets.only(left: 12, bottom: 9),
                        child: Text(
                          item["text"],
                          style: const TextStyle(
                            color: CustomColors.blackColor,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      if (item != totalUsageTimeList.last)
                        const Divider(
                          thickness: 1,
                          height: 1,
                          color: CustomColors.dividerGreyColor,
                        )
                    ],
                  ),
                ))
            .toList(),
        value: totalTimeSelectedValue,
        onChanged: (value) {
          setState(() {
            totalTimeSelectedValue = value.toString();
            selectedSeat = 0;
            selectedIndex = 0;
            selected = false;

            seatController.clear();
          });
          loadSeatAvailability();
        },
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          isOverButton: false,
          elevation: 0,
          padding: const EdgeInsets.only(top: 0, bottom: 0),
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
              EdgeInsets.only(bottom: totalTimeSelectedValue != null ? 12 : 0),
          child: SvgPicture.asset(
            "assets/images/ic_drop_down_arrow.svg",
            width: 8,
            height: 8,
            color: CustomColors.textColorBlack2,
          ),
        )),
        buttonStyleData: ButtonStyleData(
            height: 46,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColors.dividerGreyColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            padding: EdgeInsets.only(
                top: 10,
                right: 12,
                left: totalTimeSelectedValue != null ? 0 : 13,
                bottom: totalTimeSelectedValue != null ? 0 : 11),
            elevation: 0),
        menuItemStyleData: const MenuItemStyleData(
          overlayColor:
              MaterialStatePropertyAll(CustomColors.dropdownHoverColor),
          padding: EdgeInsets.only(top: 14),
          height: 46,
        ),
      ),
    );
  }

  tableCalendarWidget() {
    return TableCalendar(
      availableGestures: AvailableGestures.horizontalSwipe,
      locale: Localizations.localeOf(context).languageCode,
      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
      weekendDays: const [DateTime.sunday, DateTime.saturday],
      daysOfWeekHeight: 50,
      focusedDay: focusedDate,
      calendarFormat: selectedCalendarFormat,
      firstDay: kFirstDay,
      lastDay: kLastDay,
      headerStyle: HeaderStyle(
        leftChevronPadding: const EdgeInsets.only(left: 4),
        rightChevronPadding: const EdgeInsets.only(right: 4),
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
          selectedSeat = 0;
          selectedIndex = 0;
          selected = false;

          seatController.clear();
        });
        loadSeatAvailability();
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

  lockerSelectionWidget() {
    return Container(
      height: 223,
      decoration: BoxDecoration(
        color: CustomColors.backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.only(left: 16),
      padding: const EdgeInsets.only(left: 16, top: 24, bottom: 12),
      child: GridView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            mainAxisExtent: 55,
          ),
          itemCount: seatAvailibilityList.length,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
                onTap: () {
                  if (seatAvailibilityList[index]["available"] == true &&
                      seatAvailibilityList[index]["block"] == false) {
                    setState(() {
                      selected = true;
                      selectedIndex = index;
                      selectedSeat = seatAvailibilityList[index]["seat"];
                      seatController.text = selectedSeat.toString();
                    });
                  }
                },
                // Common seats 1-20 , Female - 29-47, Male - 21-34
                child: Container(
                  width: 40,
                  height: 34,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  margin: const EdgeInsets.only(right: 12, bottom: 12),
                  decoration: BoxDecoration(
                    color: seatAvailibilityList[index]["available"] == false ||
                            seatAvailibilityList[index]["block"] == true
                        ? CustomColors.borderColor
                        : selected && selectedIndex == index
                            ? seatAvailibilityList[index]["seat"] >= 21 &&
                                    seatAvailibilityList[index]["seat"] <= 47
                                ? CustomColors.tabColor
                                : CustomColors.textColor9
                            : CustomColors.whiteColor,
                    border: Border.all(
                        color: seatAvailibilityList[index]["available"] ==
                                    false ||
                                seatAvailibilityList[index]["block"] == true
                            ? CustomColors.borderColor
                            : gender.toString().toLowerCase().trim() == "f" &&
                                    seatAvailibilityList[index]["seat"] >= 29 &&
                                    seatAvailibilityList[index]["seat"] <= 47
                                ? CustomColors.tabColor
                                : gender.toString().toLowerCase().trim() ==
                                            "m" &&
                                        seatAvailibilityList[index]["seat"] >=
                                            21 &&
                                        seatAvailibilityList[index]["seat"] <=
                                            34
                                    ? CustomColors.tabColor
                                    : CustomColors.textColor9,
                        width: 1.0),
                  ),
                  child: Center(
                    child: Text(
                      seatAvailibilityList[index]["seat"].toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: seatAvailibilityList[index]["available"] ==
                                    false ||
                                seatAvailibilityList[index]["block"] == true
                            ? CustomColors.textColor3
                            : selected && selectedIndex == index
                                ? CustomColors.whiteColor
                                : gender.toString().toLowerCase().trim() ==
                                            "f" &&
                                        seatAvailibilityList[index]["seat"] >=
                                            29 &&
                                        seatAvailibilityList[index]["seat"] <=
                                            47
                                    ? CustomColors.tabColor
                                    : gender
                                                    .toString()
                                                    .toLowerCase()
                                                    .trim() ==
                                                "m" &&
                                            seatAvailibilityList[index]
                                                    ["seat"] >=
                                                21 &&
                                            seatAvailibilityList[index]
                                                    ["seat"] <=
                                                34
                                        ? CustomColors.tabColor
                                        : CustomColors.textColor9,
                        fontFamily: 'Regular',
                      ),
                    ),
                  ),
                ));
          }),
    );
  }

  void loadSeatAvailability() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadSeatAvailabilityApi();
    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callLoadSeatAvailabilityApi() {
    if (firstTimeSeatAvailabilityLoading) {
      setState(() {
        firstTimeSeatAvailabilityLoading = false;
      });
    } else {
      setState(() {
        isLoading = true;
      });
    }

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

    Map<String, String> body = {
      "date": reservationDate, //required
      "start_time": usageTimeSelectedValue != null &&
              usageTimeSelectedValue.toString().isNotEmpty
          ? usageTimeSelectedValue.toString().trim()
          : timeList.isNotEmpty
              ? timeList.first.toString().trim()
              : "06:30", //required
      "usage_time": totalTimeSelectedValue != null &&
              totalTimeSelectedValue.toString().isNotEmpty
          ? totalTimeSelectedValue.toString().trim()
          : totalUsageTimeList.isNotEmpty
              ? totalUsageTimeList.first["value"].toString().trim()
              : "0.5" //required
    };
    debugPrint("seatAvailibilityList input================> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getFitnessSeatAvailibilitytUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("seatAvailibilityList ================> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['seats_data'] != null) {
            setState(() {
              seatAvailibilityList = responseJson['seats_data'];
            });
          }
        } else {
          if (responseJson['message'] != null) {
            debugPrint("Server error response ${responseJson['message']}");
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      if (mounted) {
        showErrorCommonModal(
            context: context,
            heading: tr("errorDescription"),
            description: "",
            buttonName: tr("check"));
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void callLoadTimeListApi() {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    Map<String, String> body = {};
    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getFitnessTimeListUrl, body, language.toString(), apiKey);
    response.then((response) {
      if (mounted) {
        var responseJson = json.decode(response.body);

        if (responseJson != null) {
          if (response.statusCode == 200 && responseJson['success']) {
            if (responseJson['schedule'] != null) {
              setState(() {
                timeList = responseJson['schedule'];
              });
            }
          } else {
            if (responseJson['message'] != null) {
              debugPrint("Server error response ${responseJson['message']}");
              // showCustomToast(
              //     fToast, context, responseJson['message'].toString(), "");
              showErrorCommonModal(
                  context: context,
                  heading: responseJson['message'].toString(),
                  description: "",
                  buttonName: tr("check"));
            }
          }
          setState(() {
            isLoading = false;
          });
        }
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      if (mounted) {
        showErrorCommonModal(
            context: context,
            heading: tr("errorDescription"),
            description: "",
            buttonName: tr("check"));
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void callLoadTotalUsageTimeListApi() {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    Map<String, String> body = {};
    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getFitnessTotalUsageTimeListUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      if (mounted) {
        var responseJson = json.decode(response.body);

        if (responseJson != null) {
          if (response.statusCode == 200 && responseJson['success']) {
            if (responseJson['data'] != null) {
              setState(() {
                totalUsageTimeList = responseJson['data'];
              });
              loadSeatAvailability();
            }
          } else {
            if (responseJson['message'] != null) {
              debugPrint("Server error response ${responseJson['message']}");
              // showCustomToast(
              //     fToast, context, responseJson['message'].toString(), "");
              showErrorCommonModal(
                  context: context,
                  heading: responseJson['message'].toString(),
                  description: "",
                  buttonName: tr("check"));
            }
            setState(() {
              isLoading = false;
            });
          }
        }
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      if (mounted) {
        showErrorCommonModal(
            context: context,
            heading: tr("errorDescription"),
            description: "",
            buttonName: tr("check"));
        setState(() {
          isLoading = false;
        });
      }
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
    } else if (usageTimeSelectedValue == null && timeList.isEmpty) {
      showErrorModal(tr("startTimeValidation"));
    } else if (totalTimeSelectedValue == null && totalUsageTimeList.isEmpty) {
      showErrorModal(tr("usageTimeValidation"));
    } else if (selectedSeat == 0) {
      showErrorModal(tr("lockerValidation"));
    } else if (!isChecked) {
      showErrorModal(tr("pleaseConsentToCollect"));
    } else {
      networkCheckForReservation();
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
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callReservationApi();
    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callReservationApi() {
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
          : timeList.first.toString().trim(), //required
      "usage_hours": totalTimeSelectedValue != null &&
              totalTimeSelectedValue.toString().isNotEmpty
          ? totalTimeSelectedValue.toString().trim()
          : totalUsageTimeList.first["value"].toString().trim(), //required
      "seat": selectedSeat.toString().trim(), //required
    };

    debugPrint("fitness reservation input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.makeFitnessReservation, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for fitness reservation ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          showReservationModal(responseJson['title'].toString(),
              responseJson['message'].toString());
          setFirebaseEventForFitnessReservation(fitnessId: "");
        } else {
          if (responseJson['message'] != null) {
            debugPrint("Server error response ${responseJson['message']}");
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
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

  void callLoadPersonalInformationApi() {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    Map<String, String> body = {};

    debugPrint("Get personal info input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getPersonalInfoUrl, body, language, apiKey.trim());
    response.then((response) {
      if (mounted) {
        var responseJson = json.decode(response.body);

        debugPrint("server response for Get personal info ===> $responseJson");

        if (responseJson != null) {
          if (response.statusCode == 200 && responseJson['success']) {
            UserInfoModel userInfoModel = UserInfoModel.fromJson(responseJson);
            Provider.of<UserInfoProvider>(context, listen: false)
                .setItem(userInfoModel);

            setState(() {
              companyName = userInfoModel.companyName.toString();
              name = userInfoModel.name.toString();
              email = userInfoModel.email.toString();
              mobile = userInfoModel.mobile.toString();
            });
          } else {
            if (responseJson['message'] != null) {
              debugPrint("Server error response ${responseJson['message']}");
              // showCustomToast(
              //     fToast, context, responseJson['message'].toString(), "");
              showErrorCommonModal(
                  context: context,
                  heading: responseJson['message'].toString(),
                  description: "",
                  buttonName: tr("check"));
            }
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      if (mounted) {
        showErrorCommonModal(
            context: context,
            heading: tr("errorDescription"),
            description: "",
            buttonName: tr("check"));
        debugPrint("catchError ================> $onError");
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void internetCheckingForMethods() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadPersonalInformationApi();
      callLoadTimeListApi();
      callLoadTotalUsageTimeListApi();
    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  fitnessTableView() {
    return StaggeredGrid.count(
      crossAxisCount: 6,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(tr("sportwear")),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Text(tr("oneTimeRental")),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Text(tr("2,000")),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: Text(""),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Text(tr("monthlyRental")),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Text(tr("30,000")),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: Text(""),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Text(""),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Text(tr("monthlyRental")),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Text(tr("10,000")),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: Text(""),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Text(tr("threeMonthRental")),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Text(tr("27,000")),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: Text(""),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Text(tr("personalLocker")),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Text(tr("oneYearRental")),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Text(tr("10,000")),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: Text(""),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Text(tr("deposit")),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Text(tr("88,000")),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: Text(tr("refund")),
        ),
      ],
    );
  }

  fitnessCustomTableView() {
    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Container(
          width: 700,
          height: 400,
          color: CustomColors.backgroundColor,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      tr("sportwear"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Regular',
                          color: CustomColors.blackColor,
                          height: 1.5,
                          fontSize: 14),
                    ),
                  ),
                ),
                Container(
                    width: 200,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      tr("oneTimeRental"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Regular',
                          color: CustomColors.blackColor,
                          height: 1.5,
                          fontSize: 14),
                    )),
                Container(
                    width: 200,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      tr("2,000"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Regular',
                          color: CustomColors.blackColor,
                          height: 1.5,
                          fontSize: 14),
                    )),
                const Spacer(),
              ],
            ),
            fitnessInfoTableRow(tr("monthlyRental"), tr("30,000")),
            const Divider(
              height: 1,
              thickness: 1,
              color: CustomColors.dividerGreyColor,
            ),
            fitnessInfoTableRow(tr("monthlyRental"), tr("10,000")),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      tr("personalLocker"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Regular',
                          color: CustomColors.blackColor,
                          height: 1.5,
                          fontSize: 14),
                    ),
                  ),
                ),
                Container(
                    width: 200,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      tr("threeMonthRental"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Regular',
                          color: CustomColors.blackColor,
                          height: 1.5,
                          fontSize: 14),
                    )),
                Container(
                    width: 200,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      tr("27,000"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Regular',
                          color: CustomColors.blackColor,
                          height: 1.5,
                          fontSize: 14),
                    )),
                const Spacer(),
              ],
            ),
            fitnessInfoTableRow(tr("oneYearRental"), tr("88,000")),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Spacer(),
                Container(
                    width: 200,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      tr("deposit"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Regular',
                          color: CustomColors.blackColor,
                          height: 1.5,
                          fontSize: 14),
                    )),
                Container(
                    width: 200,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      tr("10,000"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Regular',
                          color: CustomColors.blackColor,
                          height: 1.5,
                          fontSize: 14),
                    )),
                Expanded(
                  flex: 1,
                  child: Text(
                    tr("refund"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'Regular',
                        color: CustomColors.blackColor,
                        height: 1.5,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  fitnessInfoTableRow(String text1, text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Spacer(),
        Container(
            width: 200,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: Text(
              text1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'Regular',
                  color: CustomColors.blackColor,
                  height: 1.5,
                  fontSize: 14),
            )),
        Container(
            width: 200,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: Text(
              text2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'Regular',
                  color: CustomColors.blackColor,
                  height: 1.5,
                  fontSize: 14),
            )),
        const Spacer(),
      ],
    );
  }
}
