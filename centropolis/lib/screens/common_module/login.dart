import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("login"), false, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: Container(
        color: CustomColors.whiteColor,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/centropolis_logo.png',
                height: 69.38,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 32,
              ),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: CustomColors.whiteColor,
                  filled: true,
                  contentPadding: const EdgeInsets.all(16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                        color: CustomColors.dividerGreyColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                        color: CustomColors.dividerGreyColor, width: 1.0),
                  ),
                  hintText: tr('id'),
                  hintStyle: const TextStyle(
                    color: CustomColors.dividerGreyColor,
                    fontSize: 14,
                    fontFamily: 'Regular',
                  ),
                ),
                style: const TextStyle(
                  color: CustomColors.textColor3,
                  fontSize: 14,
                  fontFamily: 'Regular',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: CustomColors.whiteColor,
                  filled: true,
                  contentPadding: const EdgeInsets.all(16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                        color: CustomColors.dividerGreyColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                        color: CustomColors.dividerGreyColor, width: 1.0),
                  ),
                  hintText: tr('password'),
                  hintStyle: const TextStyle(
                    color: CustomColors.textColor3,
                    fontSize: 14,
                    fontFamily: 'Regular',
                  ),
                ),
                style: const TextStyle(
                  color: CustomColors.blackColor,
                  fontSize: 14,
                  fontFamily: 'Regular',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
