import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/voc_common_home.dart';
import 'air_conditioning_application.dart';
import 'air_conditioning_list.dart';
import 'air_inc_light_list.dart';

class AirConditioningScreen extends StatefulWidget {
  const AirConditioningScreen({super.key});

  @override
  State<AirConditioningScreen> createState() => _AirConditioningScreenState();
}

class _AirConditioningScreenState extends State<AirConditioningScreen> {
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
      "title": "Centropolis",
      "status": "Received",
      "date": "2023.00.00",
      "module": "11F",
      "type": "heating"
    },
    {
      "title": "Centropolis",
      "status": "Received",
      "date": "2023.00.00",
      "module": "11F",
      "type": "heating"
    },
    {
      "title": "Centropolis",
      "status": "Received",
      "date": "2023.00.00",
      "module": "11F",
      "type": "Air conditioning"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: VocCommonHome(
        image: 'assets/images/air_conditioning.png',
        title: tr("requestForHeatingAndCooling"),
        subTitle: tr("requestForHeatingAndCooling"),
        emptyTxt: tr("airConditioningEmptyText"),
        itemsList: itemList,
        onDrawerClick: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AirConditioningList()),
          );
        },
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
        child: CommonButton(
          buttonName: tr("AirConditioning"),
          buttonColor: CustomColors.buttonBackgroundColor,
          isIconVisible: true,
          onCommonButtonTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AirConditioningApplication()),
            );
          },
        ),
      ),
    );
  }
}
