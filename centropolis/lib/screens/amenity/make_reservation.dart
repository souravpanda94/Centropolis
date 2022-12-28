import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';

class AmenityMakeReservation extends StatefulWidget {
  const AmenityMakeReservation({super.key});

  @override
  State<StatefulWidget> createState() => _AmenityMakeReservationState();
}

class _AmenityMakeReservationState extends State<AmenityMakeReservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.borderColor2,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("homeRowBook"), false, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: CustomColors.whiteColor,
              child: Container(
                margin: const EdgeInsets.only(
                    left: 16, right: 16, top: 24, bottom: 10),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select meeting date',
                          style: TextStyle(
                              color: CustomColors.textColor1,
                              fontFamily: 'Regular',
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: const Divider(
                            thickness: 1,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 10),
              color: CustomColors.whiteColor,
              child: Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'time selection',
                          style: TextStyle(
                              color: CustomColors.textColor1,
                              fontFamily: 'Regular',
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const Text(
                            'meeting start',
                            style: TextStyle(
                                color: CustomColors.textColor1,
                                fontFamily: 'Regular',
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
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
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: CustomColors.borderColor, width: 1.0),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: SvgPicture.asset(
                                'assets/images/ic_drop_down_arrow.svg',
                                color: CustomColors.textColorBlack2,
                                semanticsLabel: 'Back',
                              ),
                            ),
                            hintText: '13:30',
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
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: const Text(
                            'end of meeting',
                            style: TextStyle(
                                color: CustomColors.textColor1,
                                fontFamily: 'Regular',
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
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
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: CustomColors.borderColor, width: 1.0),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: SvgPicture.asset(
                                'assets/images/ic_drop_down_arrow.svg',
                                color: CustomColors.textColorBlack2,
                                semanticsLabel: 'Back',
                              ),
                            ),
                            hintText: '15:30',
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
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 10),
              color: CustomColors.whiteColor,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'number of participants',
                      style: TextStyle(
                          color: CustomColors.textColor1,
                          fontFamily: 'Regular',
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start,
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset('assets/images/ic_remove.svg'),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'One',
                              style: TextStyle(
                                  color: CustomColors.textColor1,
                                  fontFamily: 'Regular',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SvgPicture.asset('assets/images/ic_add.svg'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
