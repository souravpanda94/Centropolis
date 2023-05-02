import 'package:centropolis/widgets/common_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/home_page_app_bar.dart';

class BarCodeScreen extends StatefulWidget {
  const BarCodeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _BarCodeScreenState();
}

class _BarCodeScreenState extends State<BarCodeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("barCodeHeader"), true, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 90, bottom: 16),
                child: Text(
                  tr('barCodeTitle'),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: const TextStyle(
                      fontFamily: 'Regular',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.textColorBlack2),
                ),
              ),
              Text(
                tr('barCodeSubTitle'),
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(
                    fontFamily: 'Regular',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: CustomColors.greyColor1),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: CustomColors.whiteColor,
                      borderRadius: BorderRadius.circular(4)),
                  margin: const EdgeInsets.only(top: 32, bottom: 122),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 66, vertical: 32),
                  child: Image.asset('assets/images/bar_code.png')),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(bottom: 40),
                  child: CommonButton(
                    isIconVisible: false,
                    onCommonButtonTap: () {},
                    buttonColor: CustomColors.buttonColor,
                    buttonName: tr("check"),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
