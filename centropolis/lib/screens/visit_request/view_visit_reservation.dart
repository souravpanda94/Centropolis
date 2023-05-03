import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';


class ViewVisitReservationScreen extends StatefulWidget {
  const ViewVisitReservationScreen({super.key});

  @override
  State<ViewVisitReservationScreen> createState() => _ViewVisitReservationScreenState();
}

class _ViewVisitReservationScreenState extends State<ViewVisitReservationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Text(
              tr("viewVisitReservation"),
              style: const TextStyle(
                  fontFamily: 'SemiBold',
                  fontSize: 20,
                  color: CustomColors.textColor8),
            )
        ));
  }



}