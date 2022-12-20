import 'dart:convert';
import 'package:centropolis/widgets/common_button_with_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
          child:  Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("visitorReservations"),true,() {}, (){} ),
          ),
        ),
      ),

      body:  Container(
        margin: const EdgeInsets.only(left: 20,right: 20),


        // child: CommonButtonWithIcon(
        //   buttonName: "Visit Reservation Application",
        //     isEnable: true,
        //     buttonColor: CustomColors.buttonBackgroundColor,
        //     onCommonButtonTap: (){}
        // ),

        // child: CommonButton(
        //     buttonName: "Visit Reservation Application",
        //     isIconVisible: true,
        //     buttonColor: CustomColors.buttonBackgroundColor,
        //     onCommonButtonTap: (){}
        // ),

        child: CommonButtonWithBorder(
            buttonName: "Visit Reservation Application",
            buttonColor: CustomColors.whiteColor,
            buttonBorderColor: CustomColors.borderColor,
            onCommonButtonTap: (){}
        ),


      ),
    );
  }
}
