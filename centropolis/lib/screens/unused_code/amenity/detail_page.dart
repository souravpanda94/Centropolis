import 'package:carousel_slider/carousel_slider.dart';
import 'package:centropolis/widgets/common_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../utils/custom_colors.dart';
import '../../../widgets/amenity/detail_image_slider.dart';
import '../../../widgets/amenity/detail_info_row.dart';
import 'make_reservation.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  CarouselController buttonCarouselController = CarouselController();
  int initialPage = 1;
  var subTitles = <String>[];

  @override
  Widget build(BuildContext context) {
    subTitles.clear();
    subTitles.add('Hours: 9:00 am - 6:00 pm / Excluding weekends and holidays');
    subTitles.add('Number of people: Up to 00 people available');
    subTitles.add('Minimum reservation time: 00 hours');

    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.whiteColor,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: CustomColors.blackColor,
              size: 18,
            )),
      ),
      body: Stack(
        children: [
          const DetailImageSlider(),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 200),
              decoration: const BoxDecoration(
                  color: CustomColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  )),
              child: Container(
                color: CustomColors.whiteColor,
                margin:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Conference Room 1',
                            style: TextStyle(
                                color: CustomColors.textColor1,
                                fontFamily: 'Regular',
                                fontSize: 26,
                                fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              '9:00 am - 6:00 pm / Excluding weekends and holidays',
                              style: TextStyle(
                                  color: CustomColors.textColor1,
                                  fontFamily: 'Regular',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      DetailInfoRow(
                        image: 'assets/images/ic_info.svg',
                        title: 'meeting room information',
                        subtitles: subTitles,
                        info: '',
                      ),
                      DetailInfoRow(
                        image: 'assets/images/ic_time.svg',
                        title: 'Provided by the tenant company',
                        subtitles: List.empty(),
                        info:
                            'Free use of meeting room every month according to contract',
                      ),
                      DetailInfoRow(
                        image: 'assets/images/ic_details.svg',
                        title: 'Provided by the tenant company',
                        subtitles: List.empty(),
                        info:
                            'Free use of meeting room every month according to contract',
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CommonButton(
                        buttonName: tr('bookmeetingRoom'),
                        isIconVisible: false,
                        buttonColor: CustomColors.buttonBackgroundColor,
                        onCommonButtonTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AmenityMakeReservation(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
