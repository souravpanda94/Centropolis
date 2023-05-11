import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/voc_common_home.dart';
import 'air_inc_light_list.dart';
import 'complaints_received.dart';
import 'inconvenience_list.dart';

class InconvenienceScreen extends StatefulWidget {
  const InconvenienceScreen({super.key});

  @override
  State<InconvenienceScreen> createState() => _InconvenienceScreenState();
}

class _InconvenienceScreenState extends State<InconvenienceScreen> {
  List<dynamic> itemList = [
    // {
    //   "id": 1,
    //   "name": "heating",
    //   "businessType": "Centropolis",
    //   "type": "11F",
    //   "dateTime": "2021.03.21 13:00",
    //   "status": "Received"
    // },
    // {
    //   "id": 2,
    //   "name": "heating",
    //   "businessType": "Centropolis",
    //   "type": "11F",
    //   "dateTime": "2021.03.21 13:00",
    //   "status": "Received"
    // },
    // {
    //   "id": 3,
    //   "name": "Air conditioning",
    //   "businessType": "Centropolis",
    //   "type": "11F",
    //   "dateTime": "2021.03.21 13:00",
    //   "status": "Received"
    // }

    {
      "title": "Enter the title of the complaint inquiry.",
      "status": "Received",
      "date": "2023.00.00",
      "module": "maintenance",
      "type": ""
    },
    {
      "title": "Enter the title of the complaint inquiry.",
      "status": "Received",
      "date": "2023.00.00",
      "module": "maintenance",
      "type": ""
    },
    {
      "title": "Enter the title of the complaint inquiry.",
      "status": "Received",
      "date": "2023.00.00",
      "module": "construct",
      "type": ""
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: VocCommonHome(
          image: 'assets/images/inconvenience_dummy_image.png',
          title: tr("customerComplaints"),
          subTitle: tr("customerComplaints"),
          emptyTxt: tr("inconvenienceEmptyText"),
          itemsList: itemList,
          onDrawerClick: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const InconvenienceList()),
            );
          },
        ),
        bottomSheet: Container(
          margin:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
          child: CommonButton(
            buttonName: tr("complaintsReceived"),
            buttonColor: CustomColors.buttonBackgroundColor,
            isIconVisible: true,
            onCommonButtonTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ComplaintsReceived()),
              );
            },
          ),
        ));
  }
}
