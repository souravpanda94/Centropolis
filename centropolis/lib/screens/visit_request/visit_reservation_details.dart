import 'package:centropolis/screens/visit_request/view_visit_reservation.dart';
import 'package:centropolis/screens/visit_request/visit_inquiry.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';

class VisitReservationDetailsScreen extends StatefulWidget {
  const VisitReservationDetailsScreen({super.key});

  @override
  State<VisitReservationDetailsScreen> createState() =>
      _VisitReservationDetailsScreenState();
}

class _VisitReservationDetailsScreenState
    extends State<VisitReservationDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.whiteColor,
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              color: CustomColors.whiteColor,
              child: CommonAppBar(tr("visitor"), false, () {
                onBackButtonPress(context);
              }, () {}),
            ),
          ),
        ),
        body: Container()
    );
  }
}