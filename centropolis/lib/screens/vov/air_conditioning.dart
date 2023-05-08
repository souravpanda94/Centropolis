import 'package:centropolis/widgets/voc/voc_common_home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import 'air_inc_light_list.dart';

class AirConditioningScreen extends StatefulWidget {
  const AirConditioningScreen({super.key});

  @override
  State<AirConditioningScreen> createState() => _AirConditioningScreenState();
}

class _AirConditioningScreenState extends State<AirConditioningScreen> {
  List<dynamic> itemList = [
    {
      "id": 1,
      "name": "heating",
      "businessType": "Centropolis",
      "type": "11F",
      "dateTime": "2021.03.21 13:00",
      "status": "Received"
    },
    {
      "id": 2,
      "name": "heating",
      "businessType": "Centropolis",
      "type": "11F",
      "dateTime": "2021.03.21 13:00",
      "status": "Received"
    },
    {
      "id": 3,
      "name": "Air conditioning",
      "businessType": "Centropolis",
      "type": "11F",
      "dateTime": "2021.03.21 13:00",
      "status": "Received"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: VocCommonHome(
            image: 'assets/images/inconvenience_dummy_image.png',
            title: 'Request for Heating and Cooling',
            subTitle: 'Request for Heating and Cooling',
            emptyTxt: "There is no cooling & heating application history.",
            buttonName: tr("AirConditioning"),
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
