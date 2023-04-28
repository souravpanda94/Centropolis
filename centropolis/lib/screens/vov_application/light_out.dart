import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';


class LightOutScreen extends StatefulWidget {
  const LightOutScreen({super.key});

  @override
  State<LightOutScreen> createState() => _LightOutScreenState();
}

class _LightOutScreenState extends State<LightOutScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Text(
              tr("lightOut"),
              style: const TextStyle(
                  fontFamily: 'SemiBold',
                  fontSize: 20,
                  color: CustomColors.textColor8),
            )
        ));
  }



}