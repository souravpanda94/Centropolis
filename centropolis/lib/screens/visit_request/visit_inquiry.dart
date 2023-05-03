import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';


class VisitInquiryScreen extends StatefulWidget {
  const VisitInquiryScreen({super.key});

  @override
  State<VisitInquiryScreen> createState() => _VisitInquiryScreenState();
}

class _VisitInquiryScreenState extends State<VisitInquiryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Text(
              tr("visitInquiry"),
              style: const TextStyle(
                  fontFamily: 'SemiBold',
                  fontSize: 20,
                  color: CustomColors.textColor8),
            )
        ));
  }



}