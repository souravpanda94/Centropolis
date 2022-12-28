import 'package:centropolis/screens/amenity/detail_page.dart';
import 'package:flutter/material.dart';

import '../../widgets/amenity/amenity_row.dart';

class MeetingRoom extends StatelessWidget {
  const MeetingRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 20),
        child: Column(
          children: [
            AmenityRow(
                image: 'assets/images/meeting_room1.png',
                title: 'Conference Room 1',
                subTitle: '9:00 am - 6:00 pm / Excluding weekends and holidays',
                userCount: '00',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailPage(),
                    ),
                  );
                }),
            AmenityRow(
                image: 'assets/images/meeting_room2.png',
                title: 'Meeting room',
                subTitle: '9:00 am - 6:00 pm / Excluding weekends and holidays',
                userCount: '00',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailPage(),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
