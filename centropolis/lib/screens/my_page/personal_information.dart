import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              color: CustomColors.whiteColor,
              child: CommonAppBar(tr("personalInformationSetting"), false, () {
                onBackButtonPress(context);
              }, () {}),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(left: 16, right: 16),
              color: CustomColors.whiteColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tr("myProfile"),
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: "SemiBold",
                          color: CustomColors.textColor5,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 1.0,
                    color: CustomColors.dividerGreyColor,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 12.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          tr("editPersonalInformation"),
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "SemiBold",
                            color: CustomColors.textColor5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 13.0, bottom: 15.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          tr("changePassword"),
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "SemiBold",
                            color: CustomColors.textColor5,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(left: 16, right: 16),
                color: CustomColors.whiteColor,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 12.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            tr("withdrawal"),
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: "SemiBold",
                              color: CustomColors.textColor3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13.0, bottom: 15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            tr("logOut"),
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: "SemiBold",
                              color: CustomColors.textColor3,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        )));
  }
}
