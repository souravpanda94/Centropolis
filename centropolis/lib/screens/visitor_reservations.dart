import 'dart:convert';
import 'package:centropolis/widgets/CommonButtonWithIcon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../utils/custom_colors.dart';
import '../widgets/common_app_bar.dart';
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
        // child: Text(
        //   "visitor reservations screen",
        //   style: TextStyle(
        //     fontSize: 25,
        //     color: Colors.orange,
        //     fontFamily: 'Regular',
        //   ),
        // ),


        child: CommonButtonWithIcon(
          buttonName: "Visit Reservation Application",
            isEnable: true,
            buttonColor: CustomColors.buttonBackgroundColor,
            onCommonButtonTap: (){}
        ),


      ),
    );
  }
}
