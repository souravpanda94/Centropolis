import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/custom_colors.dart';
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
      backgroundColor: CustomColors.whiteColor,
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 54,
        centerTitle: true,
        backgroundColor: CustomColors.whiteColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        title: Text(
          tr('barCodeHeader'),
          style: const TextStyle(
              fontSize: 16,
              color: CustomColors.textColorBlack1,
              fontFamily: 'Regular',
              fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: SvgPicture.asset(
                'assets/images/ic_close.svg',
                color: CustomColors.textColor4,
                height: 15,
                width: 15,
              ))
        ],
      ),
      body: Center(
          child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 118),
                  child: Text(
                    tr('barCodeTitle'),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: const TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: CustomColors.textColorBlack1),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 18),
                  child: Text(
                    tr('barCodeSubTitle'),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: CustomColors.textGreyColor),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(74),
                    child: Image.asset('assets/images/bar_code.png'))
              ],
            ),
          ),
        ],
      )),
    );
  }
}
