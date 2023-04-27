import 'package:centropolis/widgets/home/home_logo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/custom_colors.dart';
import '../widgets/home/home_page_row.dart';
import '../widgets/home/other_reservation_card.dart';
import 'home/bar_code.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: CustomColors.blackColor.withOpacity(0.5),
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BarCodeScreen(),
                  ),
                );
              },
              icon: SvgPicture.asset('assets/images/ic_drawer.svg')),
          title: Image.asset('assets/images/logo_image.png'),
          actions: [
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/images/ic_home_notification.svg',
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const HomeLogo(),
              HomePageRow(
                  title: tr('conference'),
                  subtitle: tr('conferenceSubTitle'),
                  image: 'assets/images/conference.png',
                  min: '02',
                  max: '04',
                  name: tr('conferenceRoom')),
              HomePageRow(
                  title: tr('visitReservation'),
                  subtitle: tr('visitor'),
                  image: 'assets/images/visitor_reservation.png',
                  min: '01',
                  max: '08',
                  name: tr('lobby')),
              Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.symmetric(vertical: 60, horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          tr('otherReservation'),
                          style: const TextStyle(
                              color: CustomColors.textColor1,
                              fontSize: 24,
                              fontFamily: 'Pretendard-Regular',
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(tr('otherReservationSubtitle'),
                              style: const TextStyle(
                                  fontFamily: 'Pretendard-Regular',
                                  color: CustomColors.textColorGrey,
                                  fontSize: 14)),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: OtherReservationCard(
                              title: tr('otherReservationCard1')),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: OtherReservationCard(
                              title: tr('otherReservationCard2')),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: OtherReservationCard(
                              title: tr('otherReservationCard3')),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
