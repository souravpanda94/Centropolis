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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Text(
              tr("inconvenience"),
              style: const TextStyle(
                  fontFamily: 'SemiBold',
                  fontSize: 20,
                  color: CustomColors.textColor8),
            )
        ));
  }



}