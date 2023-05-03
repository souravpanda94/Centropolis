import 'package:centropolis/screens/visit_request/view_visit_reservation.dart';
import 'package:centropolis/screens/visit_request/visit_inquiry.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';



enum StatusEnum { approval, rejection }

class VisitReservationDetailsScreen extends StatefulWidget {
  final String status;

  const VisitReservationDetailsScreen(
    this.status, {
    super.key,
  });

  @override
  State<VisitReservationDetailsScreen> createState() =>
      _VisitReservationDetailsScreenState();
}

class _VisitReservationDetailsScreenState extends State<VisitReservationDetailsScreen> {
  StatusEnum? _statusType = StatusEnum.approval;
  String statusTypeValue = "approval";





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.whiteColor,
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              color: CustomColors.whiteColor,
              child: CommonAppBar(tr("visitor"), false, () {
                onBackButtonPress(context);
              }, () {}),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.only(top: 25.0, left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr("personInChargeInformation"),
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "SemiBold",
                          color: CustomColors.textColor8),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: widget.status == "Approved"
                            ? CustomColors.backgroundColor
                            : widget.status == "In Progress"
                                ? CustomColors.backgroundColor3
                                : CustomColors.backgroundColor4,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 10, right: 10),
                      child: Text(
                        widget.status,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Bold",
                          color: widget.status == "Approved"
                              ? CustomColors.textColorBlack2
                              : widget.status == "In Progress"
                                  ? CustomColors.textColor9
                                  : CustomColors.headingColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.only(top: 15.0, left: 16.0, right: 16.0),
                decoration: BoxDecoration(
                  color: CustomColors.backgroundColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.only(
                    top: 22, bottom: 22, left: 15, right: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          tr("nameOfPersonInCharge"),
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "Bold",
                            color: CustomColors.textColor8,
                          ),
                        ),
                        Text(
                          tr("*"),
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "Bold",
                            color: CustomColors.headingColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7.0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Hong Gil Dong",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Regular",
                            color: CustomColors.textColorBlack2,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        children: [
                          Text(
                            tr("tenantCompany"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: CustomColors.textColor8,
                            ),
                          ),
                          Text(
                            tr("*"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: CustomColors.headingColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7.0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "CBRE",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Regular",
                            color: CustomColors.textColorBlack2,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        children: [
                          Text(
                            tr("visitBuilding"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: CustomColors.textColor8,
                            ),
                          ),
                          Text(
                            tr("*"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: CustomColors.headingColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7.0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Tower A",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Regular",
                            color: CustomColors.textColorBlack2,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        children: [
                          Text(
                            tr("landingFloor"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: CustomColors.textColor8,
                            ),
                          ),
                          Text(
                            tr("*"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: CustomColors.headingColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7.0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "11F",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Regular",
                            color: CustomColors.textColorBlack2,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 10.0,
                color: CustomColors.backgroundColor,
                margin: const EdgeInsets.only(top: 20, bottom: 20),
              ),
              Container(
                margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tr("visitorInformation"),
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "SemiBold",
                        color: CustomColors.textColor8),
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.only(top: 15.0, left: 16.0, right: 16.0),
                decoration: BoxDecoration(
                  color: CustomColors.backgroundColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.only(
                    top: 22, bottom: 22, left: 15, right: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          tr("visitorName"),
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "Bold",
                            color: CustomColors.textColor8,
                          ),
                        ),
                        Text(
                          tr("*"),
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "Bold",
                            color: CustomColors.headingColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7.0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Hong Gil Dong",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Regular",
                            color: CustomColors.textColorBlack2,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        children: [
                          Text(
                            tr("company"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: CustomColors.textColor8,
                            ),
                          ),
                          Text(
                            tr("*"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: CustomColors.headingColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7.0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Centropolis",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Regular",
                            color: CustomColors.textColorBlack2,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        children: [
                          Text(
                            tr("email"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: CustomColors.textColor8,
                            ),
                          ),
                          Text(
                            tr("*"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: CustomColors.headingColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7.0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "test1@centropolis.com",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Regular",
                            color: CustomColors.textColorBlack2,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        children: [
                          Text(
                            tr("contactNo"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: CustomColors.textColor8,
                            ),
                          ),
                          Text(
                            tr("*"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: CustomColors.headingColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7.0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "010-0000-0000",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Regular",
                            color: CustomColors.textColorBlack2,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        children: [
                          Text(
                            tr("dateOfVisit"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: CustomColors.textColor8,
                            ),
                          ),
                          Text(
                            tr("*"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: CustomColors.headingColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7.0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "2023.00.00",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Regular",
                            color: CustomColors.textColorBlack2,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        children: [
                          Text(
                            tr("visitTime"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: CustomColors.textColor8,
                            ),
                          ),
                          Text(
                            tr("*"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: CustomColors.headingColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7.0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "09:00",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Regular",
                            color: CustomColors.textColorBlack2,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        children: [
                          Text(
                            tr("purposeOfVisit"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: CustomColors.textColor8,
                            ),
                          ),
                          Text(
                            tr("*"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: CustomColors.headingColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7.0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "business discussion",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Regular",
                            color: CustomColors.textColorBlack2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 10.0,
                color: CustomColors.backgroundColor,
                margin: const EdgeInsets.only(top: 20, bottom: 20),
              ),
              Container(
                margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tr("visitApproval"),
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "SemiBold",
                        color: CustomColors.textColor8),
                  ),
                ),
              ),

              if(widget.status == "In Progress")
              Container(
                margin:
                    const EdgeInsets.only(top: 15.0, left: 16.0, right: 16.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _statusType = StatusEnum.approval;
                            statusTypeValue = "approval";
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SvgPicture.asset(
                                _statusType == StatusEnum.approval
                                    ? 'assets/images/ic_radio_check.svg'
                                    : 'assets/images/ic_radio_uncheck.svg',
                                semanticsLabel: 'Back',
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Text(
                              tr("approval"),
                              style: const TextStyle(
                                color: CustomColors.textColor4,
                                fontSize: 14,
                                fontFamily: 'Medium',
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      width: 50.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _statusType = StatusEnum.rejection;
                          statusTypeValue = "rejection";
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SvgPicture.asset(
                              _statusType == StatusEnum.rejection
                                  ? 'assets/images/ic_radio_check.svg'
                                  : 'assets/images/ic_radio_uncheck.svg',
                              semanticsLabel: 'Back',
                              width: 20,
                              height: 20,
                            ),
                          ),
                          Text(
                            tr("rejection"),
                            style: const TextStyle(
                              color: CustomColors.textColor4,
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if(widget.status == "In Progress")
              Container(
                  margin:
                  const EdgeInsets.only(top: 25.0, left: 16.0, right: 16.0),
                child:  TextField(
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
                    hintText: tr('id'),
                    hintStyle: const TextStyle(
                      color: CustomColors.textColor3,
                      fontSize: 14,
                      fontFamily: 'Regular',
                    ),
                  ),
                  onChanged: (text){

                  },
                  style: const TextStyle(
                    color: CustomColors.blackColor,
                    fontSize: 14,
                    fontFamily: 'Regular',
                  ),
                ),
              ),


              Container(
                width: MediaQuery.of(context).size.width,
                height: 46,
                margin: const EdgeInsets.only(top: 30, bottom: 30,left: 16.0, right: 16.0),
                child: CommonButton(
                    onCommonButtonTap: () {
                    },
                    buttonColor: CustomColors.buttonBackgroundColor,
                    buttonName: tr("check"),
                    isIconVisible: false),
              ),


            ],
          ),
        ));
  }
}
