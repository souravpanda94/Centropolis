import 'dart:convert';

import 'package:centropolis/models/conference_history_detail_model.dart';
import 'package:centropolis/utils/firebase_analytics_events.dart';
import 'package:centropolis/widgets/common_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

import '../../models/user_info_model.dart';
import '../../providers/user_info_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_modal.dart';
import '../../widgets/multi_select_amenity_item.dart';
import '../../widgets/multi_select_item_lounge.dart';
import '../my_page/web_view_ui.dart';
import 'conference_availability_modal.dart';

class ConferenceReservation extends StatefulWidget {
  final String operationName;
  final String? conferenceId;
  final ConferenceHistoryDetailModel? conferenceHistoryDetails;

  const ConferenceReservation(
      {super.key,
      required this.operationName,
      this.conferenceId,
      this.conferenceHistoryDetails});

  @override
  State<ConferenceReservation> createState() => _ConferenceReservationState();
}

class _ConferenceReservationState extends State<ConferenceReservation> {
  late String language, apiKey;
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
  TextEditingController rentalInfoController = TextEditingController();
  String? startTimeSelectedValue;
  String? endTimeSelectedValue;
  String? meetingPackageSelectedValue;
  String? conferenceRoomSelectedValue;
  List<dynamic> timeList = [];
  List<dynamic> meetingPackageList = [];
  List<dynamic> conferenceRoomList = [];
  Map<dynamic, dynamic> conferenceRoomScheduleList = {};
  var dateFormat = DateFormat('yyyy-MM-dd');
  String reservationDate = "";
  String reservationRulesLink = "";
  bool servicesEquipmentTooltip = false;
  List<dynamic> _selectedEquipments = [];
  List<dynamic> _selectedEquipmentsValue = [];
  List<dynamic> equipmentsList = [];
  String? equipmentSelectedValue;
  bool isLoadingRequired = false;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    if (widget.operationName == "edit") {
      setDataForEdit();
    }
    setWebViewLink();
    internetCheckingForMethods();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(),
      child: LoadingOverlay(
        opacity: 0.5,
        color: CustomColors.textColor4,
        progressIndicator: const CircularProgressIndicator(
          color: CustomColors.blackColor,
        ),
        isLoading: isLoading,
        child: Scaffold(
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
              primary: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: CustomColors.backgroundColor,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    height: 200,
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            infoTextWidget(tr("conferenceInfoText1")),
                            infoTextWidget(tr("conferenceInfoText2")),
                            infoTextWidget(tr("conferenceInfoText3")),
                            infoTextWidget(tr("conferenceInfoText4")),
                            infoTextWidget(tr("conferenceInfoText5")),
                            infoTextWidget(tr("conferenceInfoText6")),
                            infoTextWidget(tr("conferenceInfoText7")),
                            infoTextWidget(tr("conferenceInfoText8")),
                            infoTextWidget(tr("conferenceInfoText9")),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                          height: 16,
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
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 16),
                    width: MediaQuery.of(context).size.width,
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
                                viewConferenceReservationAvailibility();
                              },
                              child: Text(
                                tr("viewCalendar"),
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    color: CustomColors.textColor9),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(tr("startTime"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8)),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: Text(" *",
                                  style: TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.headingColor)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        startTimeDropdownWidget(),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(tr("endTime"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8)),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: Text(" *",
                                  style: TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.headingColor)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        endTimeDropdownWidget(),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: CustomColors.backgroundColor,
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 16),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("conferenceRoom"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 16,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(tr("preferredConferenceRoom"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8)),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: Text(" *",
                                  style: TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.headingColor)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        conferenceRoomDropdownWidget(),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(tr("meetingPackage"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8)),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: Text(" *",
                                  style: TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.headingColor)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        meetingPackageDropdownWidget(),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          tr("equipments"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              servicesEquipmentTooltip = true;
                            });
                            _showMultiSelect();
                          },
                          child: Container(
                            height: 46,
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.0,
                                  color: CustomColors.dividerGreyColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    child: _selectedEquipments.isEmpty
                                        ? Container(
                                            padding: const EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                top: 12,
                                                bottom: 12),
                                            child: Text(tr('equipmentsHint')))
                                        : Container(
                                            margin:
                                                const EdgeInsets.only(left: 15),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Wrap(
                                                runSpacing: 1.5,
                                                spacing: 0,
                                                direction: Axis.vertical,
                                                children: _selectedEquipments
                                                    .map((e) => Chip(
                                                          visualDensity:
                                                              VisualDensity
                                                                  .compact,
                                                          backgroundColor:
                                                              CustomColors
                                                                  .selectedColor,
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5))),
                                                          label: SizedBox(
                                                            //width: 20,
                                                            child: Text(
                                                                e["text"]
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'SemiBold',
                                                                    fontSize:
                                                                        12,
                                                                    color: CustomColors
                                                                        .whiteColor)),
                                                          ),
                                                        ))
                                                    .toList(),
                                              ),
                                            ),
                                          )),
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.only(
                                      left: 10,
                                      bottom: equipmentSelectedValue != null
                                          ? 16
                                          : 0),
                                  child: SvgPicture.asset(
                                    "assets/images/ic_drop_down_arrow.svg",
                                    width: 8,
                                    height: 8,
                                    color: CustomColors.textColorBlack2,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        if (servicesEquipmentTooltip)
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              tr("conferenceServiceEquipmentTooltip"),
                              style: const TextStyle(
                                  fontFamily: 'Regular',
                                  fontSize: 12,
                                  color: CustomColors.blackColor),
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
                          padding: const EdgeInsets.only(top: 2, bottom: 2),
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CustomColors.dividerGreyColor,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          height: 278,
                          child: TextField(
                            controller: rentalInfoController,
                            cursorColor: CustomColors.textColorBlack2,
                            keyboardType: TextInputType.multiline,
                            maxLines: 14,
                            maxLength: 500,
                            decoration: InputDecoration(
                              counterText: "",
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
                            onTap: () {
                              if (servicesEquipmentTooltip) {
                                setState(() {
                                  servicesEquipmentTooltip = false;
                                });
                              }
                            },
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                  child: Transform.scale(
                                    scale: 0.8,
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
                              ),
                              const SizedBox(
                                width: 9,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: language == "en"
                                    ? InkWell(
                                        onTap: () {
                                          showGeneralDialog(
                                              context: context,
                                              barrierColor: Colors.black12
                                                  .withOpacity(0.6),
                                              // Background color
                                              barrierDismissible: false,
                                              barrierLabel: 'Dialog',
                                              transitionDuration:
                                                  const Duration(
                                                      milliseconds: 400),
                                              pageBuilder: (_, __, ___) {
                                                return WebViewUiScreen(
                                                    tr("conferenceRoomReservation"),
                                                    reservationRulesLink);
                                              });
                                        },
                                        child: Text.rich(
                                          TextSpan(
                                            text: tr("agree"),
                                            style: const TextStyle(
                                                fontFamily: 'Regular',
                                                fontSize: 14,
                                                color: CustomColors
                                                    .textColorBlack2),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: tr(
                                                      "conferenceReservationConsent"),
                                                  style: const TextStyle(
                                                    fontFamily: 'Regular',
                                                    fontSize: 14,
                                                    color: CustomColors
                                                        .buttonBackgroundColor,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          showGeneralDialog(
                                              context: context,
                                              barrierColor: Colors.black12
                                                  .withOpacity(0.6),
                                              // Background color
                                              barrierDismissible: false,
                                              barrierLabel: 'Dialog',
                                              transitionDuration:
                                                  const Duration(
                                                      milliseconds: 400),
                                              pageBuilder: (_, __, ___) {
                                                return WebViewUiScreen(
                                                    tr("conferenceRoomReservation"),
                                                    reservationRulesLink);
                                              });
                                        },
                                        child: Text.rich(
                                          TextSpan(
                                            text: tr(
                                                "conferenceReservationConsent"),
                                            style: const TextStyle(
                                                fontFamily: 'Regular',
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.underline,
                                                color: CustomColors
                                                    .buttonBackgroundColor),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: tr("agree"),
                                                  style: const TextStyle(
                                                    fontFamily: 'Regular',
                                                    fontSize: 14,
                                                    color: CustomColors
                                                        .textColorBlack2,
                                                    decoration:
                                                        TextDecoration.none,
                                                  )),
                                            ],
                                          ),
                                        ),
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
                              //showReservationModal();
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
        ),
      ),
    );
  }

  infoTextWidget(String text) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 7),
            child: Icon(
              Icons.circle,
              size: 5,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontFamily: 'Regular',
                  fontSize: 14,
                  height: 1.5,
                  color: CustomColors.textColor5),
            ),
          )
        ]);
  }

  void showReservationModal(String heading, String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: heading,
            description: message,
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
              Navigator.pop(context, isLoadingRequired);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  startTimeDropdownWidget() {
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
        value: startTimeSelectedValue,
        onChanged: (value) {
          setState(() {
            startTimeSelectedValue = value as String;
          });
        },
        onMenuStateChange: (isOpen) {
          if (servicesEquipmentTooltip) {
            setState(() {
              servicesEquipmentTooltip = false;
            });
          }
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
              EdgeInsets.only(bottom: startTimeSelectedValue != null ? 12 : 0),
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
                left: startTimeSelectedValue != null ? 0 : 13,
                bottom: startTimeSelectedValue != null ? 0 : 11),
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

  endTimeDropdownWidget() {
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
        value: endTimeSelectedValue,
        onChanged: (value) {
          setState(() {
            endTimeSelectedValue = value as String;
          });
        },
        onMenuStateChange: (isOpen) {
          if (servicesEquipmentTooltip) {
            setState(() {
              servicesEquipmentTooltip = false;
            });
          }
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
              EdgeInsets.only(bottom: endTimeSelectedValue != null ? 12 : 0),
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
                left: endTimeSelectedValue != null ? 0 : 13,
                bottom: endTimeSelectedValue != null ? 0 : 11),
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

  conferenceRoomDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          tr('preferredConferenceRoomHint'),
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: conferenceRoomList
            .map((item) => DropdownMenuItem<String>(
                  value: item["value"].toString(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 9),
                        child: Text(
                          item["text"].toString(),
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
                      if (item != conferenceRoomList.last)
                        const Divider(
                          thickness: 1,
                          height: 1,
                          color: CustomColors.dividerGreyColor,
                        )
                    ],
                  ),
                ))
            .toList(),
        value: conferenceRoomSelectedValue,
        onChanged: (value) {
          setState(() {
            conferenceRoomSelectedValue = value.toString();
          });
        },
        onMenuStateChange: (isOpen) {
          if (servicesEquipmentTooltip) {
            setState(() {
              servicesEquipmentTooltip = false;
            });
          }
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
          padding: EdgeInsets.only(
              bottom: conferenceRoomSelectedValue != null ? 12 : 0),
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
                left: conferenceRoomSelectedValue != null ? 0 : 13,
                bottom: conferenceRoomSelectedValue != null ? 0 : 11),
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

  meetingPackageDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          tr('meetingPackageHint'),
          // meetingPackageList.isNotEmpty
          //     ? meetingPackageList.first["package_name"]
          //     : tr('meetingPackageHint'),
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: meetingPackageList
            .map((item) => DropdownMenuItem<String>(
                  value: item["package_id"].toString(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 9),
                        child: Text(
                          item["package_name"].toString(),
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
                      if (item != meetingPackageList.last)
                        const Divider(
                          thickness: 1,
                          height: 1,
                          color: CustomColors.dividerGreyColor,
                        )
                    ],
                  ),
                ))
            .toList(),
        value: meetingPackageSelectedValue,
        onChanged: (value) {
          setState(() {
            meetingPackageSelectedValue = value.toString();
          });
        },
        onMenuStateChange: (isOpen) {
          if (servicesEquipmentTooltip) {
            setState(() {
              servicesEquipmentTooltip = false;
            });
          }
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
          padding: EdgeInsets.only(
              bottom: meetingPackageSelectedValue != null ? 12 : 0),
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
                left: meetingPackageSelectedValue != null ? 0 : 13,
                bottom: meetingPackageSelectedValue != null ? 0 : 11),
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
    );
  }

  void callLoadTimeListApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};
    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getConferenceTimeListUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
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

  void callLoadMeetingPackageListApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};
    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getConferenceMeetingPackageListUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "meeting package responseJson ================> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              meetingPackageList = responseJson['data'];
              Map<dynamic, dynamic> allMap = {
                "package_name": tr("noPackage"),
                "package_id": "0"
              };
              meetingPackageList.insert(0, allMap);
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

  void callLoadConferenceRoomListApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};
    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getConferenceRoomListUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("ConferenceRoom responseJson ================> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              conferenceRoomList = responseJson['data'];
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

  void callLoadloadConferenceScheduleApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};
    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getConferenceRoomScheduleUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "ConferenceRoom Schedule responseJson ================> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['inquiry_data'] != null) {
            setState(() {
              conferenceRoomScheduleList = responseJson['inquiry_data'];
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
    } else if (startTimeSelectedValue == null || startTimeSelectedValue == "") {
      showErrorModal(tr("startTimeValidation"));
    } else if (endTimeSelectedValue == null || startTimeSelectedValue == "") {
      showErrorModal(tr("endTimeValidation"));
    } else if ((startTimeSelectedValue!.compareTo(endTimeSelectedValue!)) >=
        0) {
      showErrorModal(tr("endTimeMustBeGreaterThanStartTime"));
    } else if (conferenceRoomSelectedValue == null ||
        conferenceRoomSelectedValue == "") {
      showErrorModal(tr("preferredConferenceRoomHint"));
    } else if (meetingPackageSelectedValue == null ||
        meetingPackageSelectedValue == "") {
      showErrorModal(tr("meetingPackageHint"));
    } else if (_selectedEquipments.isEmpty) {
      showErrorModal(tr("equipmentsHint"));
    } else if (rentalInfoController.text.isEmpty) {
      showErrorModal(tr("conferenceDescriptionValidation"));
    } else if (!isChecked) {
      showErrorModal(tr("tnc"));
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
    String apiName = "";
    Map<String, dynamic> body;
    setState(() {
      isLoading = true;
    });
    debugPrint("meetingPackageSelectedValue :: $meetingPackageSelectedValue");

    if (widget.operationName == "edit") {
      apiName = ApiEndPoint.editConferenceReservation;
      body = {
        "reservation_id": widget.conferenceId.toString(),
        "email": email.trim(), //required
        "mobile": mobile.trim(), //required
        "reservation_date": reservationDate.toString().trim(), //required
        "start_time": startTimeSelectedValue.toString().trim(), //required
        "end_time": endTimeSelectedValue.toString().trim(), //required
        "description": rentalInfoController.text.toString().trim(), //required
        "desired_conference_hall_id": conferenceRoomSelectedValue != null
            ? conferenceRoomSelectedValue.toString().trim()
            : "", //required
        "package_id": meetingPackageSelectedValue != null
            ? meetingPackageSelectedValue.toString().trim()
            : "0", //no package
        "equipments": _selectedEquipmentsValue //required
      };

      debugPrint("Edit conference reservation input===> $body");
    } else {
      apiName = ApiEndPoint.makeConferenceReservation;
      body = {
        "email": email.trim(), //required
        "mobile": mobile.trim(), //required
        "reservation_date": reservationDate.toString().trim(), //required
        "start_time": startTimeSelectedValue.toString().trim(), //required
        "end_time": endTimeSelectedValue.toString().trim(), //required
        "description": rentalInfoController.text.toString().trim(), //required
        "desired_conference_hall_id": conferenceRoomSelectedValue != null
            ? conferenceRoomSelectedValue.toString().trim()
            : "", //required
        "package_id": meetingPackageSelectedValue != null
            ? meetingPackageSelectedValue.toString().trim()
            : "0", //no package
        "equipments": _selectedEquipmentsValue //required
      };

      debugPrint("conference reservation input===> $body");
    }

    Future<http.Response> response = WebService()
        .callPostMethodWithRawData(apiName, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for conferencce reservation ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          setState(() {
            isLoadingRequired = true;
          });

          showReservationModal(responseJson['title'].toString(),
              responseJson['message'].toString());

          if (widget.operationName == "edit") {
            setFirebaseEventForConferenceReservation(eventName: "cp_edit_conference_reservation",conferenceId: widget.conferenceId.toString());
          } else {
            setFirebaseEventForConferenceReservation(eventName: "cp_make_conference_reservation",conferenceId: "");
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

  void callLoadPersonalInformationApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};

    debugPrint("Get personal info input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getPersonalInfoUrl, body, language, apiKey.trim());
    response.then((response) {
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

  viewConferenceReservationAvailibility() {
    hideKeyboard();
    showDialog(
        context: context,
        useSafeArea: true,
        barrierColor: Colors.black12.withOpacity(0.6),
        barrierDismissible: true,
        barrierLabel: 'Dialog',
        builder: (BuildContext context) {
          return ConferenceAvailabilityModal(
            scheduleList: conferenceRoomScheduleList,
          );
        });
  }

  void setWebViewLink() {
    if (language == "en") {
      setState(() {
        reservationRulesLink = WebViewLinks.conferenceUrlEng;
      });
    } else {
      setState(() {
        reservationRulesLink = WebViewLinks.conferenceUrlKo;
      });
    }
  }

  void internetCheckingForMethods() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadPersonalInformationApi();
      callLoadTimeListApi();
      callLoadMeetingPackageListApi();
      callLoadConferenceRoomListApi();
      callLoadloadConferenceScheduleApi();
      callLoadEquipmentListApi();
    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void _showMultiSelect() async {
    final List<dynamic>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectAmenityEquipments(
          items: equipmentsList,
          alreadySelectedItems: _selectedEquipments,
        );
      },
    );

    // Update UI
    if (results != null) {
      _selectedEquipmentsValue.clear();

      for (var i = 0; i < results.length; i++) {
        if (results[i]["value"] != null &&
            results[i]["value"].toString().isNotEmpty) {
          _selectedEquipmentsValue.add(results[i]["value"]);
        }
      }

      setState(() {
        _selectedEquipments = results;
      });
    }
  }

  void callLoadEquipmentListApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};

    debugPrint("conference equipment List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.conferenceEquipmentListUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for conference Equipment List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            var equipmentNames;
            setState(() {
              equipmentsList = responseJson['data'];
            });
          }
        } else {
          if (responseJson['message'] != null) {
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

  void setDataForEdit() {
    debugPrint(
        "-----------------${widget.conferenceHistoryDetails!.reservationDate.toString()}----------------");
    debugPrint(
        "-----------------${widget.conferenceHistoryDetails!.usageTime.toString()}----------------");
    debugPrint(
        "-----------------${widget.conferenceHistoryDetails!.conferenceRoom.toString()}----------------");
    debugPrint(
        "-----------------${widget.conferenceHistoryDetails!.packageName.toString()}----------------");

    String usageTime = "";
    setState(() {
      usageTime = widget.conferenceHistoryDetails!.usageTime
          .toString()
          .replaceAll(' ', '');
      focusedDate = DateTime.parse(
          widget.conferenceHistoryDetails!.reservationDate.toString());
      startTimeSelectedValue =
          usageTime.substring(0, usageTime.indexOf('~')).toString();
      endTimeSelectedValue = usageTime
          .substring(usageTime.indexOf('~') + 1, usageTime.length)
          .toString();

      conferenceRoomSelectedValue =
          widget.conferenceHistoryDetails!.conferenceRoomId.toString().trim();
      meetingPackageSelectedValue =
          widget.conferenceHistoryDetails?.packageId.toString().trim() ??
              tr("noPackage");
      rentalInfoController = TextEditingController(
          text: widget.conferenceHistoryDetails?.description.toString() ?? "");

      if (widget.conferenceHistoryDetails!.equipments.toString().isEmpty) {
        _selectedEquipments = [
          {"value": "", "text": tr("noRequest")}
        ];
        _selectedEquipmentsValue = [];
      } else {
        if (widget.conferenceHistoryDetails!.equipmentsValue != null &&
            widget.conferenceHistoryDetails!.equipmentsValue!.isNotEmpty) {
          _selectedEquipments =
              widget.conferenceHistoryDetails!.equipmentsValue!;
          for (var i = 0;
              i < widget.conferenceHistoryDetails!.equipmentsValue!.length;
              i++) {
            if (widget.conferenceHistoryDetails!.equipmentsValue![i]["value"] !=
                    null &&
                widget.conferenceHistoryDetails!.equipmentsValue![i]["value"]
                    .toString()
                    .isNotEmpty) {
              _selectedEquipmentsValue.add(widget
                  .conferenceHistoryDetails!.equipmentsValue![i]["value"]);
            }
          }
        } else {
          _selectedEquipments = [
            {"value": "", "text": tr("noRequest")}
          ];
          _selectedEquipmentsValue = [];
        }
      }
    });
  }
}
