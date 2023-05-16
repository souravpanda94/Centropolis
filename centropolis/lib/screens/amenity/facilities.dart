import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';

import '../../widgets/common_button.dart';
import '../../widgets/fitness_congestion.dart';
import 'sleeping_room_reservation.dart';

class FacilitiesScreen extends StatefulWidget {
  const FacilitiesScreen({super.key});

  @override
  State<FacilitiesScreen> createState() => _FacilitiesScreenState();
}

class _FacilitiesScreenState extends State<FacilitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/images/ic_slider_5.png",
                    height: 320,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  color: CustomColors.whiteColor,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      left: 16, right: 16, top: 24, bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Refresh",
                        style: TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.buttonBackgroundColor),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        tr("facilities"),
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 22,
                            color: CustomColors.textColorBlack2),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        tr("operatingTime"),
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.textColor8),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        tr("facilityOperatingTime"),
                        style: const TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        tr("facilityInformation"),
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.textColor8),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      facilityRow(tr("facilityInfoText1")),
                      facilityRow(tr("facilityInfoText2")),
                      facilityRow(tr("facilityInfoText3")),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        tr("howToUse"),
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.textColor8),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        tr("facilityUsage"),
                        style: const TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
                      ),
                      facilityRow(tr("facilityUsageText1")),
                      facilityRow(tr("facilityUsageText2")),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        tr("inquiry"),
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.textColor8),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        tr("facilityInquiry"),
                        style: const TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        tr("fitnessCongestion"),
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.textColor8),
                      ),
                      const FitnessCongestion(
                        type: "confusion",
                      )
                    ],
                  ),
                ),
              ],
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: CommonButton(
                  onCommonButtonTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SleepingRoomReservation(),
                      ),
                    );
                  },
                  buttonColor: CustomColors.buttonBackgroundColor,
                  buttonName: tr("makeSleepingRoomReservation"),
                  isIconVisible: true,
                ),
              ),
            )
          ],
        ));
  }

  facilityRow(text) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 7, right: 10),
            child: Icon(
              Icons.circle,
              size: 5,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontFamily: 'Regular',
                  fontSize: 14,
                  color: CustomColors.textColorBlack2),
            ),
          )
        ]);
  }
}
