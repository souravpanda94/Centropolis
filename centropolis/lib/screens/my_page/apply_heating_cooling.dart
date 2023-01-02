import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button_with_icon.dart';
import '../../widgets/my_page/my_page_row.dart';
import 'heating_cooling_detail.dart';

class ApplyForHeatingCooling extends StatefulWidget {
  const ApplyForHeatingCooling({super.key});

  @override
  State<StatefulWidget> createState() => _ApplyForHeatingCoolingState();
}

class _ApplyForHeatingCoolingState extends State<ApplyForHeatingCooling> {
  List<dynamic> requestList = [
    {
      "id": 1,
      "name": "Tenant company name",
      "dateTime": "2021.03.21 13:00",
      "status": "heating"
    },
    {
      "id": 2,
      "name": "Tenant company name",
      "dateTime": "2021.03.21 13:00",
      "status": "cooling"
    },
    {
      "id": 3,
      "name": "Tenant company name",
      "dateTime": "2021.03.21 13:00",
      "status": "cooling"
    },
    {
      "id": 4,
      "name": "Tenant company name",
      "dateTime": "2021.03.21 13:00",
      "status": "heating"
    },
    {
      "id": 5,
      "name": "Tenant company name",
      "dateTime": "2021.03.21 13:00",
      "status": "cancellation"
    },
    {
      "id": 6,
      "name": "Tenant company name",
      "dateTime": "2021.03.21 13:00",
      "status": "cooling"
    },
    {
      "id": 7,
      "name": "Tenant company name",
      "dateTime": "2021.03.21 13:00",
      "status": "cooling"
    },
    {
      "id": 9,
      "name": "Tenant company name",
      "dateTime": "2021.03.21 13:00",
      "status": "cancellation"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("heatingCoolingExtensionApplication"), true,
                () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
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
                  onRowPressed: goToHeatingCoolingtDetailsScreen),
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
          ),
        ),
      ),
    );
  }

  void goToHeatingCoolingtDetailsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HeatingCoolingDetail(),
      ),
    );
  }
}
