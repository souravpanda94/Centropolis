import 'package:centropolis/screens/vov_application/air_inc_light_list.dart';
import 'package:centropolis/widgets/voc/voc_common_home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';

class InconvenienceScreen extends StatefulWidget {
  const InconvenienceScreen({super.key});

  @override
  State<InconvenienceScreen> createState() => _InconvenienceScreenState();
}

class _InconvenienceScreenState extends State<InconvenienceScreen> {
  List<dynamic> itemList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: VocCommonHome(
          image: 'assets/images/inconvenience_dummy_image.png',
          title: 'Customer Complaints',
          subTitle: ' Customer Complaints',
          emptyTxt: "There is no record of complaints received.",
          buttonName: tr("otherReservationCard3"),
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
          }),
    );
  }
}
