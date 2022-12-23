import 'dart:convert';
import 'package:centropolis/widgets/common_button_with_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_modal.dart';
import '../../widgets/home_page_app_bar.dart';

class VisitReservationApplicationScreen extends StatefulWidget {
  const VisitReservationApplicationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VisitReservationApplicationScreenState();
  }
}

class _VisitReservationApplicationScreenState
    extends State<VisitReservationApplicationScreen> {
  String visitorName = "";
  String companyName = "";
  String mobileNumber = "";
  String email = "";
  String buildingVisited = "";
  String landingFloor = "";
  String dateTimeOfVisit = "";
  String visitTime = "";
  String purposeOfVisit = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("visitReservationApplication"), true, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 25.0, bottom: 25.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                tr("required"),
                style: const TextStyle(
                  fontSize: 16,
                  color: CustomColors.buttonBackgroundColor,
                  fontFamily: 'Regular',
                ),
                textAlign: TextAlign.right,
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child:  Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  tr("visitorName"),
                  style: const TextStyle(
                    fontSize: 16,
                    color: CustomColors.textColor1,
                    fontFamily: 'Regular',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: CustomColors.whiteColor,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 17.0,
                  horizontal: 12.0,
                ),
                enabledBorder: const UnderlineInputBorder(
                  //<-- SEE HERE
                  borderSide:
                      BorderSide(width: 1, color: CustomColors.borderColor2),
                ),
                hintText: tr("pleaseEnterTheCorrectVisitorName"),
                hintStyle: const TextStyle(
                  color: CustomColors.unSelectedColor,
                  fontSize: 14,
                  fontFamily: 'Regular',
                ),
              ),
              style: const TextStyle(
                color: CustomColors.textColorBlack2,
                fontSize: 14,
                fontFamily: 'Regular',
              ),
              onChanged: (text) => {
                setState(() {
                  visitorName = text;
                }),
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  tr("companyName"),
                  style: const TextStyle(
                    fontSize: 16,
                    color: CustomColors.textColor1,
                    fontFamily: 'Regular',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: CustomColors.whiteColor,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 17.0,
                  horizontal: 12.0,
                ),
                enabledBorder: const UnderlineInputBorder(
                  //<-- SEE HERE
                  borderSide:
                      BorderSide(width: 1, color: CustomColors.borderColor2),
                ),
                hintText: tr("pleaseEnterTheCorrectCompanyName"),
                hintStyle: const TextStyle(
                  color: CustomColors.unSelectedColor,
                  fontSize: 14,
                  fontFamily: 'Regular',
                ),
              ),
              style: const TextStyle(
                color: CustomColors.textColorBlack2,
                fontSize: 14,
                fontFamily: 'Regular',
              ),
              onChanged: (text) => {
                setState(() {
                  companyName = text;
                }),
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  tr("mobilePhoneNumber"),
                  style: const TextStyle(
                    fontSize: 16,
                    color: CustomColors.textColor1,
                    fontFamily: 'Regular',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: CustomColors.whiteColor,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 17.0,
                  horizontal: 12.0,
                ),
                enabledBorder: const UnderlineInputBorder(
                  //<-- SEE HERE
                  borderSide:
                      BorderSide(width: 1, color: CustomColors.borderColor2),
                ),
                hintText: tr("pleaseEnterOnlyNumbersWithout"),
                hintStyle: const TextStyle(
                  color: CustomColors.unSelectedColor,
                  fontSize: 14,
                  fontFamily: 'Regular',
                ),
              ),
              style: const TextStyle(
                color: CustomColors.textColorBlack2,
                fontSize: 14,
                fontFamily: 'Regular',
              ),
              onChanged: (text) => {
                setState(() {
                  mobileNumber = text;
                }),
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  tr("email"),
                  style: const TextStyle(
                    fontSize: 16,
                    color: CustomColors.textColor1,
                    fontFamily: 'Regular',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: CustomColors.whiteColor,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 17.0,
                  horizontal: 12.0,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: CustomColors.borderColor2),
                ),
                hintText: tr("emailExample"),
                hintStyle: const TextStyle(
                  color: CustomColors.unSelectedColor,
                  fontSize: 14,
                  fontFamily: 'Regular',
                ),
              ),
              style: const TextStyle(
                color: CustomColors.textColorBlack2,
                fontSize: 14,
                fontFamily: 'Regular',
              ),
              onChanged: (text) => {
                setState(() {
                  email = text;
                }),
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  tr("buildingVisited"),
                  style: const TextStyle(
                    fontSize: 16,
                    color: CustomColors.textColor1,
                    fontFamily: 'Regular',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: CustomColors.whiteColor,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 17.0,
                  horizontal: 12.0,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: CustomColors.borderColor2),
                ),
                suffixIcon: SvgPicture.asset(
                  'assets/images/ic_drop_down_arrow.svg',
                  semanticsLabel: 'Back',
                ),
                suffixIconConstraints:
                const BoxConstraints.tightFor(width: 15, height: 15),
                hintText: tr("pleaseSelectBuildingToVisit"),
                hintStyle: const TextStyle(
                  color: CustomColors.unSelectedColor,
                  fontSize: 14,
                  fontFamily: 'Regular',
                ),
              ),
              style: const TextStyle(
                color: CustomColors.textColorBlack2,
                fontSize: 14,
                fontFamily: 'Regular',
              ),
              onChanged: (text) => {
                setState(() {
                  buildingVisited = text;
                }),
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  tr("landingFloor"),
                  style: const TextStyle(
                    fontSize: 16,
                    color: CustomColors.textColor1,
                    fontFamily: 'Regular',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: CustomColors.whiteColor,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 17.0,
                  horizontal: 12.0,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: CustomColors.borderColor2),
                ),
                suffixIcon: SvgPicture.asset(
                  'assets/images/ic_drop_down_arrow.svg',
                  semanticsLabel: 'Back',
                ),
                suffixIconConstraints:
                const BoxConstraints.tightFor(width: 15, height: 15),
                hintText: tr("pleaseSelectFloorToVisit"),
                hintStyle: const TextStyle(
                  color: CustomColors.unSelectedColor,
                  fontSize: 14,
                  fontFamily: 'Regular',
                ),
              ),
              style: const TextStyle(
                color: CustomColors.textColorBlack2,
                fontSize: 14,
                fontFamily: 'Regular',
              ),
              onChanged: (text) => {
                setState(() {
                  landingFloor = text;
                }),
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  tr("dateAndTimeOfVisitWithStar"),
                  style: const TextStyle(
                    fontSize: 16,
                    color: CustomColors.textColor1,
                    fontFamily: 'Regular',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: CustomColors.whiteColor,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 17.0,
                  horizontal: 12.0,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: CustomColors.borderColor2),
                ),
                suffixText: tr("choose"),
                suffixStyle: const TextStyle(
                  color: CustomColors.buttonBackgroundColor,
                  fontSize: 13,
                  fontFamily: 'Regular',
                ),
                hintText: tr("dateAndTimeOfVisit"),
                hintStyle: const TextStyle(
                  color: CustomColors.unSelectedColor,
                  fontSize: 14,
                  fontFamily: 'Regular',
                ),
              ),
              style: const TextStyle(
                color: CustomColors.textColorBlack2,
                fontSize: 14,
                fontFamily: 'Regular',
              ),
              onChanged: (text) => {
                setState(() {
                  dateTimeOfVisit = text;
                }),
              },
            ),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: CustomColors.whiteColor,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 17.0,
                  horizontal: 12.0,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: CustomColors.borderColor2),
                ),
                suffixText: tr("choose"),
                suffixStyle: const TextStyle(
                  color: CustomColors.buttonBackgroundColor,
                  fontSize: 13,
                  fontFamily: 'Regular',
                ),
                hintText: tr("visitTime"),
                hintStyle: const TextStyle(
                  color: CustomColors.unSelectedColor,
                  fontSize: 14,
                  fontFamily: 'Regular',
                ),
              ),
              style: const TextStyle(
                color: CustomColors.textColorBlack2,
                fontSize: 14,
                fontFamily: 'Regular',
              ),
              onChanged: (text) => {
                setState(() {
                  visitTime = text;
                }),
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  tr("purposeOfVisit"),
                  style: const TextStyle(
                    fontSize: 16,
                    color: CustomColors.textColor1,
                    fontFamily: 'Regular',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: CustomColors.whiteColor,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 17.0,
                  horizontal: 12.0,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: CustomColors.borderColor2),
                ),
                suffixIcon: SvgPicture.asset(
                  'assets/images/ic_drop_down_arrow.svg',
                  semanticsLabel: 'Back',
                ),
                suffixIconConstraints:
                    const BoxConstraints.tightFor(width: 15, height: 15),
                hintText: tr("businessDiscussion"),
                hintStyle: const TextStyle(
                  color: CustomColors.unSelectedColor,
                  fontSize: 14,
                  fontFamily: 'Regular',
                ),
              ),
              style: const TextStyle(
                color: CustomColors.textColorBlack2,
                fontSize: 14,
                fontFamily: 'Regular',
              ),
              onChanged: (text) => {
                setState(() {
                  purposeOfVisit = text;
                }),
              },
            ),
            Container(
                margin: const EdgeInsets.only(top: 40.0),
                child: CommonButton(
                  buttonName: tr("lookup"),
                  isIconVisible: false,
                  buttonColor: CustomColors.buttonBackgroundColor,
                  onCommonButtonTap: () {},
                )),
          ],
        ),
      )),
    );
  }
}
