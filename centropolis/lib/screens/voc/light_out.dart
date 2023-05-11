import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_colors.dart';
import '../../widgets/common_button.dart';
import '../../widgets/voc_common_home.dart';
import 'light_out_list.dart';
import 'light_out_request.dart';

class LightOutScreen extends StatefulWidget {
  const LightOutScreen({super.key});

  @override
  State<LightOutScreen> createState() => _LightOutScreenState();
}

class _LightOutScreenState extends State<LightOutScreen> {
  List<dynamic> itemList = [
    // {
    //   "id": 1,
    //   "name": "Hong Gil Dong",
    //   "businessType": "consulting",
    //   "type": "business",
    //   "dateTime": "2021.03.21 13:00",
    //   "status": "before visit"
    // },
    // {
    //   "id": 2,
    //   "name": "Hong Gil Dong",
    //   "businessType": "consulting",
    //   "type": "business",
    //   "dateTime": "2021.03.21 13:00",
    //   "status": "before visit"
    // },
    // {
    //   "id": 3,
    //   "name": "Hong Gil Dong",
    //   "businessType": "consulting",
    //   "type": "business",
    //   "dateTime": "2021.03.21 13:00",
    //   "status": "before visit"
    // }
    {
      "title": "Centropolis",
      "status": "Received",
      "date": "2023.00.00 13:00",
      "module": "11F",
      "type": ""
    },
    {
      "title": "Centropolis",
      "status": "Received",
      "date": "2023.00.00 13:00",
      "module": "11F",
      "type": ""
    },
    {
      "title": "Centropolis",
      "status": "Received",
      "date": "2023.00.00 13:00",
      "module": "11F",
      "type": ""
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: VocCommonHome(
        image: 'assets/images/ic_slider_6.png',
        title: tr("requestForLightsOut"),
        subTitle: tr("requestForLightsOut"),
        emptyTxt: tr("lightOutEmptyText"),
        itemsList: itemList,
        onDrawerClick: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LightsOutList()),
          );
        },
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
        child: CommonButton(
          buttonName: tr("requestForLightsOut"),
          buttonColor: CustomColors.buttonBackgroundColor,
          isIconVisible: true,
          onCommonButtonTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LightOutRequest()),
            );
          },
        ),
      ),
    );
  }
}
