import 'dart:convert';
import 'package:centropolis/widgets/common_button_with_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/custom_colors.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/common_button.dart';
import '../widgets/common_button_with_border.dart';
import '../widgets/home_page_app_bar.dart';

class VisitorReservationsScreen extends StatefulWidget {
  const VisitorReservationsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VisitorReservationsScreenState();
  }
}

class _VisitorReservationsScreenState extends State<VisitorReservationsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: HomePageAppBar(tr("visitorReservations"), () {}, () {}),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20,bottom: 20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  const Text(
                    "TODAY",
                    style: TextStyle(
                      fontSize: 26,
                      color: CustomColors.textColor1,
                      fontFamily: 'SemiBold',
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(
                    child: SvgPicture.asset(
                      'assets/images/ic_right_arrow.svg',
                      semanticsLabel: 'Back',
                      width: 15,
                      height: 15,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
            ),










            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: CommonButtonWithIcon(
                      buttonName: tr("visitReservationApplication"),
                      isEnable: true,
                      buttonColor: CustomColors.buttonBackgroundColor,
                      onCommonButtonTap: () {},
                    )),
            )
          ],
        ),





        // child: CommonButtonWithIcon(
        //   buttonName: "Visit Reservation Application",
        //     isEnable: true,
        //     buttonColor: CustomColors.buttonBackgroundColor,
        //     onCommonButtonTap: (){}
        // ),

        // // child: CommonButton(
        // //     buttonName: "Visit Reservation Application",
        // //     isIconVisible: true,
        // //     buttonColor: CustomColors.buttonBackgroundColor,
        // //     onCommonButtonTap: (){}
        // // ),
        //
        // child: CommonButtonWithBorder(
        //     buttonName: "Visit Reservation Application",
        //     buttonColor: CustomColors.whiteColor,
        //     buttonBorderColor: CustomColors.borderColor,
        //     onCommonButtonTap: (){}
        // ),
      ),
    );
  }
}
