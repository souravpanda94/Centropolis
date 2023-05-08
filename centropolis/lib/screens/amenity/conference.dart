import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import '../../widgets/common_button.dart';
import 'conference_reservation.dart';

class ConferenceScreen extends StatefulWidget {
  const ConferenceScreen({super.key});

  @override
  State<ConferenceScreen> createState() => _ConferenceScreenState();
}

class _ConferenceScreenState extends State<ConferenceScreen> {
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
                    "assets/images/conference.png",
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
                        "Conference",
                        style: TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.buttonBackgroundColor),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        tr("conference"),
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
                      const Text(
                        "9 am to 6 pm (weekdays only)",
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        tr("capacityByType"),
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.textColor8),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 7),
                              child: Icon(
                                Icons.circle,
                                size: 5,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "3 standard conference rooms (combinable, accommodating over 100 people)",
                                style: TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    color: CustomColors.textColorBlack2),
                              ),
                            )
                          ]),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 7),
                              child: Icon(
                                Icons.circle,
                                size: 5,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "1 video conference room (room for 12 people)",
                                style: TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    color: CustomColors.textColorBlack2),
                              ),
                            )
                          ]),
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
                      const Text(
                        "02-6370-5151 / 5152",
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
                      ),
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
                        builder: (context) => const ConferenceReservation(),
                      ),
                    );
                  },
                  buttonColor: CustomColors.buttonBackgroundColor,
                  buttonName: tr("makeConferenceRoomReservation"),
                  isIconVisible: true,
                ),
              ),
            )
          ],
        ));
  }
}
