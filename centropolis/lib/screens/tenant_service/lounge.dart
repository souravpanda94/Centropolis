import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';


class LoungeScreen extends StatefulWidget {
  const LoungeScreen({super.key});

  @override
  State<LoungeScreen> createState() => _LoungeScreenState();
}

class _LoungeScreenState extends State<LoungeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Text(
              tr("lounge"),
              style: const TextStyle(
                  fontFamily: 'Regular',
                  fontSize: 14,
                  color: CustomColors.textColor8),
            )
        ));
  }



}