import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/my_page/my_page_detail_info.dart';

class HeatingCoolingDetail extends StatefulWidget {
  const HeatingCoolingDetail({super.key});

  @override
  State<StatefulWidget> createState() => _HeatingCoolingDetailState();
}

class _HeatingCoolingDetailState extends State<HeatingCoolingDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("heatingCoolingExtensionApplication"), false,
                () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.only(top: 30.0, bottom: 30.0),
        child: Column(
          children: [
            const MyPageDetailInfo(
                applicantName: 'Hong Gil Dong',
                companyName: 'Centro Consulting',
                phoneNumber: '010-0000-0000',
                emailID: 'welcome@centropolis.co.kr'),
            Container(
              color: CustomColors.backgroundColor,
              height: 10,
              margin: const EdgeInsets.only(
                top: 25,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('choiceOfAirConditioner'),
                    style: const TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: CustomColors.textColor1),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
