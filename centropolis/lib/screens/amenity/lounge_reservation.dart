import 'dart:convert';
import 'package:centropolis/widgets/common_button.dart';
import 'package:centropolis/widgets/multi_select_item_lounge.dart';
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
import '../my_page/web_view_ui.dart';

class LoungeReservation extends StatefulWidget {
  const LoungeReservation({super.key});

  @override
  State<LoungeReservation> createState() => _LoungeReservationState();
}

class _LoungeReservationState extends State<LoungeReservation> {
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
  String? usageTimeSelectedValue;
  String? startTimeSelectedValue;
  String? endTimeSelectedValue;
  String? numberOfParticipantsSelectedValue;
  String? paymentMethodSelectedValue;
  bool tooltip = false;


  String reservationDate = "";
  List<dynamic> usageTimeList = [];
  List<dynamic> timeList = [];
  List<dynamic> numberOfParticipantsList = [];
  List<dynamic> paymentMethodList = [];
  String reservationRulesLink = "";


  List<dynamic> _selectedEquipments = [];
    List<dynamic> _selectedEquipmentsValue = [];

  List<dynamic> equipmentsList = [];
  String? equipmentSelectedValue;


  TextEditingController eventPurposeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    // email = user.userData['email_key'].toString();
    // mobile = user.userData['mobile'].toString();
    //name = user.userData['name'].toString();
    //companyName = user.userData['company_name'].toString();
    setWebViewLink();
    loadPersonalInformation();
    loadUsageTimeList();
    loadTimeList();
    loadNumberOfParticipantsList();
    loadPaymentMethodList();
    loadEquipmentList();



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
      child: Scaffold(
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
            primary: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: CustomColors.backgroundColor,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(left: 16,right: 16),
                  height: 200,
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          infoTextWidget(tr("loungeInfoText1")),
                          infoTextWidget(tr("loungeInfoText2")),
                          infoTextWidget(tr("loungeInfoText3")),
                          infoTextWidget(tr("loungeInfoText4")),
                          infoTextWidget(tr("loungeInfoText5")),
                          infoTextWidget(tr("loungeInfoText6")),
                          infoTextWidget(tr("loungeInfoText7")),
                          infoTextWidget(tr("loungeInfoText8")),
                          infoTextWidget(tr("loungeInfoText9")),
                                 
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
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
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
                      usageTimeWidget(),
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
                      startTimeDropDownWidget(),
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
                      endTimeDropDownWidget(),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr("eventPurpose"),
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.textColor8),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 46,
                        child: TextField(
                          controller: eventPurposeController,
                          cursorColor: CustomColors.textColorBlack2,
                          keyboardType: TextInputType.number,
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
                            hintText: tr('eventPurposeHint'),
                            hintStyle: const TextStyle(
                              height: 1.5,
                              color: CustomColors.textColor3,
                              fontSize: 14,
                              fontFamily: 'Regular',
                            ),
                          ),
                          style: const TextStyle(
                            height: 1.5,
                            color: CustomColors.textColorBlack2,
                            fontSize: 14,
                            fontFamily: 'Regular',
                          ),
                        ),
                      ),
                       const SizedBox(
                        height: 16,
                      ),

                      Text(
                        tr("numberOfParticipants"),
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.textColor8),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      numberOfParticipantsWidget(),
                      const SizedBox(
                        height: 16,
                      ),

                      Text(
                        tr("paymentMethod"),
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.textColor8),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      paymentMethodWidget(),
                      if (tooltip)
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              tr("paymentMethodTooltip"),
                              style: const TextStyle(
                                  fontFamily: 'Regular',
                                  fontSize: 12,
                                  color: CustomColors.blackColor),
                            ),
                          ),
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
                                                top: 10,
                                                bottom: 10),
                                            child: Text(
                                                tr('equipmentsHint')))
                                        : Container(
                                            margin:
                                                const EdgeInsets.only(left: 15),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Wrap(
                                                runSpacing: 1.5,
                                                direction: Axis.vertical,
                                                children: _selectedEquipments
                                                    .map((e) => Chip(
                                                          visualDensity:
                                                              VisualDensity
                                                                  .standard,
                                                          backgroundColor:
                                                              CustomColors
                                                                  .selectedColor,
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 5),
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              5))),
                                                          label: SizedBox(
                                                            //width: 20,
                                                            child: Text(
                                                                e["text"]
                                                                    .toString()
                                                                    ,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'SemiBold',
                                                                    fontSize: 12,
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
                                      bottom:
                                          equipmentSelectedValue != null ? 16 : 0),
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

                    ]
                    
                    ,
                  ),

                ),
                 Container(
                  width: MediaQuery.of(context).size.width,
                  color: CustomColors.backgroundColor,
                  height: 10,
                ),
                Container(
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
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: language =="en" ? InkWell(
                                  onTap: () {
                                    showGeneralDialog(
                            context: context,
                            barrierColor: Colors.black12.withOpacity(0.6),
                            // Background color
                            barrierDismissible: false,
                            barrierLabel: 'Dialog',
                            transitionDuration:
                                const Duration(milliseconds: 400),
                            pageBuilder: (_, __, ___) {
                              return WebViewUiScreen(
                                  tr("loungeReservation"), reservationRulesLink);
                            });
                                  },
                                  child: Text.rich(
                                  TextSpan(
                                    text: tr("agree"),
                                    style: const TextStyle(fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.textColorBlack2),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: tr("loungeReservationConsent"),
                                          style: const TextStyle(
                                            fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.buttonBackgroundColor,
                                            decoration: TextDecoration.underline,
                                          )),
                                     
                                    ],
                                  ),
                                ),
                                ) : InkWell(
                                  onTap: () {
                                    showGeneralDialog(
                            context: context,
                            barrierColor: Colors.black12.withOpacity(0.6),
                            // Background color
                            barrierDismissible: false,
                            barrierLabel: 'Dialog',
                            transitionDuration:
                                const Duration(milliseconds: 400),
                            pageBuilder: (_, __, ___) {
                              return WebViewUiScreen(
                                  tr("loungeReservation"), reservationRulesLink);
                            });
                                  },
                                  child: Text.rich(
                                  TextSpan(
                                    text: tr("loungeReservationConsent"),
                                    style: const TextStyle(fontFamily: 'Regular',
                                        fontSize: 14,
                                                                                    decoration: TextDecoration.underline,

                                        color: CustomColors.buttonBackgroundColor),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: tr("agree"),
                                          style: const TextStyle(
                                            fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.textColorBlack2,
                                            decoration: TextDecoration.none,
                                          )),
                                     
                                    ],
                                  ),
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
                            // showReservationModal();
                            reservationValidationCheck();
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
    );
  }
  
  infoTextWidget(String text){
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

  void _showMultiSelect() async {
    final List<dynamic>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectLoungeEquipments(
          items: equipmentsList,
          alreadySelectedItems: _selectedEquipments,
         

        );
      },
    );


    // Update UI
    if (results != null) {
      _selectedEquipmentsValue.clear();
       
       for(var i =0;i<results.length;i++){
            _selectedEquipmentsValue.add(results[i]["value"]);
         }

      setState(() {
        _selectedEquipments = results;
      });
    }
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
              Navigator.pop(context);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  Widget paymentMethodWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          "${tr('paymentMethodHint')}.",
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: paymentMethodList
            .map(
              (item) => DropdownMenuItem<String>(
                value: item["value"],
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
                    if (item != paymentMethodList.last)
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: CustomColors.dividerGreyColor,
                      )
                  ],
                ),
               
              ),
            )
            .toList(),
        value: paymentMethodSelectedValue,
        onChanged: (value) {
          setState(() {
            paymentMethodSelectedValue = value as String;
          });
        },
        dropdownStyleData: DropdownStyleData(
         
          isOverButton: false,
          padding: const EdgeInsets.only(top: 0, bottom: 0),
          elevation: 0,
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              border: Border.all(
                color: CustomColors.dividerGreyColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
        ),
        onMenuStateChange: (isOpen) {
          setState(() {
            tooltip=true;
          });
        },
        iconStyleData: IconStyleData(
            icon: Padding(
          padding:
              EdgeInsets.only(bottom: paymentMethodSelectedValue != null ? 12 : 0),
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
                left: paymentMethodSelectedValue != null ? 0 : 13,
                bottom: paymentMethodSelectedValue != null ? 0 : 11),
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

  Widget numberOfParticipantsWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          "${tr('numberOfparticipantsHint')}.",
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: numberOfParticipantsList
            .map(
              (item) => DropdownMenuItem<String>(
                value: item["value"],
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
                    if (item != numberOfParticipantsList.last)
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: CustomColors.dividerGreyColor,
                      )
                  ],
                ),
               
              ),
            )
            .toList(),
        value: numberOfParticipantsSelectedValue,
        onChanged: (value) {
          setState(() {
            numberOfParticipantsSelectedValue = value as String;
          });
        },
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          isOverButton: false,
          padding: const EdgeInsets.only(top: 0, bottom: 0),
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
              EdgeInsets.only(bottom: numberOfParticipantsSelectedValue != null ? 12 : 0),
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
                left: numberOfParticipantsSelectedValue != null ? 0 : 13,
                bottom: numberOfParticipantsSelectedValue != null ? 0 : 11),
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

  Widget usageTimeWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          "${tr('selectUsageTime')}.",
          style: const TextStyle(
            color: CustomColors.textColorBlack2,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: usageTimeList
            .map(
              (item) => DropdownMenuItem<String>(
                enabled: item["available"] ? true : false,
                value: item["value"],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 9),
                      child: Text(
                        item["text"],
                        style: TextStyle(
                          color: item["available"]
                              ? CustomColors.blackColor
                              : CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    if (item != usageTimeList.last)
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: CustomColors.dividerGreyColor,
                      )
                  ],
                ),
                onTap: () {
                  if (item["value"] == "manual") {
                    startTimeSelectedValue = null;
                    endTimeSelectedValue = null;
                  } else {
                    setState(() {
                      startTimeSelectedValue = item["start_time"];
                      endTimeSelectedValue = item["end_time"];
                    });
                  }
                },
              ),
            )
            .toList(),
        value: usageTimeSelectedValue,
        onChanged: (value) {
          setState(() {
            usageTimeSelectedValue = value as String;
          });
        },
        dropdownStyleData: DropdownStyleData(
          isOverButton: false,
          padding: const EdgeInsets.only(top: 0, bottom: 0),
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

  Widget startTimeDropDownWidget() {
    if (usageTimeSelectedValue == "manual") {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            "${tr('selectStartTime')}.",
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
                bottom: startTimeSelectedValue != null ? 12 : 0),
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
            padding: EdgeInsets.only(top: 16),
            height: 48,
          ),
        ),
      );
    } else {
      return Container(
        height: 46,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 12, right: 16),
        decoration: BoxDecoration(
            border: Border.all(
              color: CustomColors.dividerGreyColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              startTimeSelectedValue ?? "${tr('selectStartTime')}.",
              style: const TextStyle(
                color: CustomColors.blackColor,
                fontSize: 14,
                fontFamily: 'Regular',
              ),
            ),
            SvgPicture.asset(
              "assets/images/ic_drop_down_arrow.svg",
              width: 8,
              height: 8,
              color: CustomColors.textColorBlack2,
            ),
          ],
        ),
      );
    }
  }

  Widget endTimeDropDownWidget() {
    if (usageTimeSelectedValue == "manual") {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            "${tr('selectEndTime')}.",
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
          dropdownStyleData: DropdownStyleData(
            maxHeight: 150,
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
    } else {
      return Container(
        height: 46,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 12, right: 16),
        decoration: BoxDecoration(
            border: Border.all(
              color: CustomColors.dividerGreyColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              endTimeSelectedValue ?? "${tr('selectEndTime')}.",
              style: const TextStyle(
                color: CustomColors.blackColor,
                fontSize: 14,
                fontFamily: 'Regular',
              ),
            ),
            SvgPicture.asset(
              "assets/images/ic_drop_down_arrow.svg",
              width: 8,
              height: 8,
              color: CustomColors.textColorBlack2,
            ),
          ],
        ),
      );
    }
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
          usageTimeSelectedValue = null;
          startTimeSelectedValue = null;
          endTimeSelectedValue = null;
          paymentMethodSelectedValue=null;
          numberOfParticipantsSelectedValue=null;
          eventPurposeController.clear();
          tooltip=false;
          _selectedEquipments.clear();
          _selectedEquipmentsValue.clear();
        });
        loadUsageTimeList();
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

  void loadUsageTimeList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadUsageTimeListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callLoadUsageTimeListApi() {
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
    debugPrint("Selected Date ====> $selectedDate");
    setState(() {
      reservationDate = selectedDate;
      isLoading = true;
    });

    Map<String, String> body = {"reservation_date": reservationDate.trim()};

    debugPrint("Usage Time List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getUsageTimeListUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Usage Time List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              usageTimeList = responseJson['data'];
            });
          }
        } else {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isLoading = false;
      });
    });
  }

  void loadTimeList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadTimeListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callLoadTimeListApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};

    debugPrint("Time List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getTimeListUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Time List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              timeList = responseJson['data'];
            });
          }
        } else {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isLoading = false;
      });
    });
  }

  void loadNumberOfParticipantsList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadNumberOfParticipantsListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callLoadNumberOfParticipantsListApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};

    debugPrint("NumberOfParticipants List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.numberOfParticipantsListUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for NumberOfParticipants List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              numberOfParticipantsList = responseJson['data'];
            });
          }
        } else {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isLoading = false;
      });
    });
  }
  void loadPaymentMethodList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadPaymentMethodListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callLoadPaymentMethodListApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};

    debugPrint("PaymentMethod List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.paymentMethodListUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for PaymentMethod List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              paymentMethodList = responseJson['data'];
            });
          }
        } else {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isLoading = false;
      });
    });
  }

  void loadEquipmentList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadEquipmentListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callLoadEquipmentListApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};

    debugPrint("Equipment List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.equipmentListUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Equipment List ===> $responseJson");

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
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
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
    debugPrint("Selected Date ====> $selectedDate");
    setState(() {
      reservationDate = selectedDate;
    });

    if (reservationDate == "") {
      showErrorModal(tr("applicationDateValidation"));
    } else if (usageTimeSelectedValue == null || startTimeSelectedValue == "") {
      showErrorModal(tr("usageTimeValidation"));
    } else if (startTimeSelectedValue == null || startTimeSelectedValue == "") {
      showErrorModal(tr("startTimeValidation"));
    } else if (endTimeSelectedValue == null || startTimeSelectedValue == "") {
      showErrorModal(tr("endTimeValidation"));
    } else if ((startTimeSelectedValue!.compareTo(endTimeSelectedValue!)) >=
        0) {
      showErrorModal(tr("endTimeMustBeGreaterThanStartTime"));
    } 
    else if (eventPurposeController.text.trim().isEmpty) {
      showErrorModal(tr("eventPurposeHint"));
    }
    else if (numberOfParticipantsSelectedValue == null) {
      showErrorModal(tr("numberOfparticipantsHint"));
    }
    else if (paymentMethodSelectedValue == null ) {
      showErrorModal(tr("paymentMethodHint"));
    }else if (_selectedEquipments.isEmpty) {
      showErrorModal(tr("equipmentsHint"));
    }
    else if (!isChecked) {
      showErrorModal(tr("tnc"));
    } else {
      networkCheckForReservation();
    }
  }

  void networkCheckForReservation() async {
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callReservationApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callReservationApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> body = {
      "email": email.trim(), //required
      "mobile": mobile.trim(), //required
      "reservation_date": reservationDate.trim(), //required
      "start_time": startTimeSelectedValue.toString().trim(), //required
      "end_time": endTimeSelectedValue.toString().trim(), //required
      "type": usageTimeSelectedValue.toString().trim(), //required
      "purpose":eventPurposeController.text.toString().trim(),//required
      "no_of_participants":numberOfParticipantsSelectedValue.toString().trim(),//required
      "payment_method":paymentMethodSelectedValue.toString().trim(),//required
      "equipments": _selectedEquipmentsValue //required
    };

    debugPrint("lounge reservation input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.makeLoungeReservation, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for lounge reservation ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['title'] != null) {
            showReservationModal(responseJson['title'].toString(),
                responseJson['message'].toString());
          } else {
            showReservationModal(responseJson['message'].toString(), "");
          }
        } else {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isLoading = false;
      });
    });
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

  void loadPersonalInformation() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadPersonalInformationApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
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
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isLoading = false;
      });
    });
  }

  void setWebViewLink() {
    if (language == "en") {
      setState(() {
        reservationRulesLink = WebViewLinks.loungeConferenceUrlEng;
      });
    } else {
      setState(() {
       
        reservationRulesLink = WebViewLinks.loungeConferenceUrlKo;
      });
    }
  }
}
