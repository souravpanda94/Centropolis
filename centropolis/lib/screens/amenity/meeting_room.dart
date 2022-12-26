import 'package:flutter/cupertino.dart';

import '../../widgets/amenity/amenity_row.dart';

class MeetingRoom extends StatelessWidget {
  const MeetingRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 20),
          child: Column(
            children: const [
              AmenityRow(
                  image: 'assets/images/meeting_room1.png',
                  title: 'Conference Room 1',
                  subTitle:
                      '9:00 am - 6:00 pm / Excluding weekends and holidays',
                  userCount: '00'),
              AmenityRow(
                  image: 'assets/images/meeting_room2.png',
                  title: 'Meeting room',
                  subTitle:
                      '9:00 am - 6:00 pm / Excluding weekends and holidays',
                  userCount: '00')
            ],
          ),
        )
      ],
    );
  }
}
