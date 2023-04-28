import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../utils/custom_colors.dart';



class VisitReservationScreen extends StatefulWidget {
  const VisitReservationScreen({super.key});

  @override
  State<VisitReservationScreen> createState() => _VisitReservationScreenState();
}

class _VisitReservationScreenState extends State<VisitReservationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Text(
              tr("visitor"),
              style: const TextStyle(
                  fontFamily: 'SemiBold',
                  fontSize: 20,
                  color: CustomColors.textColor8),
            )
        ));
  }



}