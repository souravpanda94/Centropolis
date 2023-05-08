import 'package:centropolis/widgets/voc/voc_common_home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import 'air_inc_light_list.dart';

class LightOutScreen extends StatefulWidget {
  const LightOutScreen({super.key});

  @override
  State<LightOutScreen> createState() => _LightOutScreenState();
}

class _LightOutScreenState extends State<LightOutScreen> {
  List<dynamic> itemList = [
    {
      "id": 1,
      "name": "Hong Gil Dong",
      "businessType": "consulting",
      "type": "business",
      "dateTime": "2021.03.21 13:00",
      "status": "before visit"
    },
    {
      "id": 2,
      "name": "Hong Gil Dong",
      "businessType": "consulting",
      "type": "business",
      "dateTime": "2021.03.21 13:00",
      "status": "before visit"
    },
    {
      "id": 3,
      "name": "Hong Gil Dong",
      "businessType": "consulting",
      "type": "business",
      "dateTime": "2021.03.21 13:00",
      "status": "before visit"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: VocCommonHome(
            image: 'assets/images/inconvenience_dummy_image.png',
            title: 'Request for Light Out',
            subTitle: 'Request for Light Out',
            emptyTxt: "There is no history of lights out.",
            buttonName: tr("requestForLightsOut"),
            itemsList: itemList,
            onDrawerClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AirIncLightList(
                          emptyTxt: "There is no history of lights out.",
                          itemsList: itemList,
                        )),
              );
            },
            onPressed: () {
              debugPrint("===================================");
            }));
  }
}
