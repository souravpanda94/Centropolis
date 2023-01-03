import 'package:centropolis/screens/my_page/request_for_lights_out_details.dart';
import 'package:centropolis/utils/utils.dart';
import 'package:centropolis/widgets/bottom_bar.dart';
import 'package:centropolis/widgets/common_button_with_icon.dart';
import 'package:centropolis/widgets/my_page/my_page_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import '../../widgets/common_app_bar.dart';
import '../home.dart';
import 'apply_heating_cooling.dart';

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
                //onBackButtonPress(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomBar(),
                  ),
                );
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
                  MyPageRow(
                      requestList: requestList,
                      onRowPressed: goToRequestForLightsOutDetailsScreen),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: CommonButtonWithIcon(
                          buttonName: tr("applyForHeatingAndCooling"),
                          isEnable: true,
                          buttonColor: CustomColors.buttonBackgroundColor,
                          onCommonButtonTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ApplyForHeatingCooling(),
                              ),
                            );
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
