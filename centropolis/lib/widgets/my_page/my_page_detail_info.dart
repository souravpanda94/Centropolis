import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/custom_colors.dart';

class MyPageDetailInfo extends StatelessWidget {
  final String emailID, applicantName, companyName, phoneNumber;
  const MyPageDetailInfo(
      {super.key,
      required this.applicantName,
      required this.companyName,
      required this.phoneNumber,
      required this.emailID});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              tr("tenantCompanyInformation"),
              style: const TextStyle(
                fontSize: 18,
                color: CustomColors.textColor1,
                fontWeight: FontWeight.w400,
                fontFamily: 'Regular',
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: CustomColors.backgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          margin: const EdgeInsets.only(
            top: 10,
            left: 16,
            right: 16,
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  tr("applicantName"),
                  style: const TextStyle(
                    fontSize: 11,
                    color: CustomColors.textColor5,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Regular',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 6),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    applicantName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: CustomColors.textColor1,
                      fontFamily: 'Regular',
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tr("companyName"),
                    style: const TextStyle(
                      fontSize: 11,
                      color: CustomColors.textColor5,
                      fontFamily: 'Regular',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 6),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    companyName,
                    style: const TextStyle(
                      fontSize: 14,
                      color: CustomColors.textColor1,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Regular',
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tr("mobilePhoneNumber"),
                    style: const TextStyle(
                      fontSize: 11,
                      color: CustomColors.textColor5,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Regular',
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 6),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    phoneNumber,
                    style: const TextStyle(
                      fontSize: 14,
                      color: CustomColors.textColor1,
                      fontFamily: 'Regular',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tr("email"),
                    style: const TextStyle(
                      fontSize: 11,
                      color: CustomColors.textColor5,
                      fontFamily: 'Regular',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 6),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    emailID,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: CustomColors.textColor1,
                      fontFamily: 'Regular',
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
