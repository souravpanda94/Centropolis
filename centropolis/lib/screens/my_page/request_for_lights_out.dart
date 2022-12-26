import 'dart:convert';
import 'package:centropolis/screens/my_page/request_for_lights_out_details.dart';
import 'package:centropolis/utils/utils.dart';
import 'package:centropolis/widgets/common_button_with_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/custom_colors.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_modal.dart';
import '../../widgets/home_page_app_bar.dart';

class RequestForLightsOutScreen extends StatefulWidget {
  const RequestForLightsOutScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RequestForLightsOutScreenState();
  }
}

class _RequestForLightsOutScreenState extends State<RequestForLightsOutScreen> {
  List<dynamic> requestList = [
    {
      "id": 1,
      "name": "Tenant company name",
      "dateTime": "2021.03.21 13:00",
      "status": "cancellation"
    },
    {
      "id": 2,
      "name": "Tenant company name",
      "dateTime": "2021.03.21 13:00",
      "status": ""
    },
    {
      "id": 3,
      "name": "Tenant company name",
      "dateTime": "2021.03.21 13:00",
      "status": ""
    },
    {
      "id": 4,
      "name": "Tenant company name",
      "dateTime": "2021.03.21 13:00",
      "status": "cancellation"
    },
    {
      "id": 5,
      "name": "Tenant company name",
      "dateTime": "2021.03.21 13:00",
      "status": ""
    },
    {
      "id": 6,
      "name": "Tenant company name",
      "dateTime": "2021.03.21 13:00",
      "status": "cancellation"
    },
    {
      "id": 7,
      "name": "Tenant company name",
      "dateTime": "2021.03.21 13:00",
      "status": ""
    },
    {
      "id": 8,
      "name": "Tenant company name",
      "dateTime": "2021.03.21 13:00",
      "status": ""
    },
    {
      "id": 9,
      "name": "Tenant company name",
      "dateTime": "2021.03.21 13:00",
      "status": "cancellation"
    }
  ];

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
        backgroundColor: CustomColors.whiteColor,
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              color: CustomColors.whiteColor,
              child: CommonAppBar(tr("requestForLightsOut"), true, () {
                onBackButtonPress(context);
              }, () {}),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 20),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        tr("providedByTheTenantCompany"),
                        style: const TextStyle(
                          fontSize: 14,
                          color: CustomColors.textColor1,
                          fontFamily: 'Regular',
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),

                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: requestList.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return InkWell(
                          onTap: () {
                            goToRequestForLightsOutDetailsScreen();
                          },
                          child: Container(
                              margin:
                                  const EdgeInsets.only(top: 5.0, bottom: 5.0),
                              decoration: BoxDecoration(
                                color: CustomColors.whiteColor,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: CustomColors.borderColor,
                                    width: 1.0),
                              ),
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        requestList[index]["name"],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Bold",
                                            color: CustomColors.textColor1),
                                      ),
                                      Text(
                                        requestList[index]["status"],
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontFamily: "Bold",
                                            color: CustomColors.textColor6),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 6),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          requestList[index]["dateTime"],
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Regular",
                                            color: CustomColors.unSelectedColor,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ))
                                ],
                              )));
                    },
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: CommonButtonWithIcon(
                          buttonName: tr("applyForHeatingAndCooling"),
                          isEnable: true,
                          buttonColor: CustomColors.buttonBackgroundColor,
                          onCommonButtonTap: () {

                          },
                        )),
                  ),

                ],
              )),
        ));
  }


  void goToRequestForLightsOutDetailsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RequestForLightsOutDetailsScreen(),
      ),
    );
  }


}
