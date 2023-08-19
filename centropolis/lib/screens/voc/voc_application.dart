import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import 'air_conditioning.dart';
import 'inconvenience.dart';
import 'light_out.dart';

class VocApplicationScreen extends StatefulWidget {
  const VocApplicationScreen({super.key});

  @override
  State<VocApplicationScreen> createState() => _VocApplicationScreenState();
}

class _VocApplicationScreenState extends State<VocApplicationScreen> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: tr("inconvenience")),
    Tab(text: tr("airConditioning")),
    Tab(text: tr("lightOutExtension")),
  ];

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
    return DefaultTabController(
      length: 3,
      // initialIndex: widget.page,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: CustomColors.whiteColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: CustomColors.whiteColor,
                border: Border(
                    bottom: BorderSide(
                        color: CustomColors.backgroundColor2, width: 0.5)),
              ),
              child: TabBar(
                labelPadding: EdgeInsets.zero,
                tabs: myTabs,
                labelColor: CustomColors.textColor8,
                labelStyle: const TextStyle(
                  color: CustomColors.textColor8,
                  fontSize: 14,
                  fontFamily: 'SemiBold',
                ),
                unselectedLabelColor: CustomColors.greyColor1,
                unselectedLabelStyle: const TextStyle(
                  color: CustomColors.greyColor1,
                  fontSize: 14,
                  fontFamily: 'Regular',
                ),
                indicatorColor: CustomColors.textColor9,
                indicator: const UnderlineTabIndicator(
                  borderSide:
                      BorderSide(width: 2.0, color: CustomColors.textColor9),
                  // insets: EdgeInsets.symmetric(horizontal:16.0)
                ),
              ),
            )),
        body: const TabBarView(
          // physics: const NeverScrollableScrollPhysics(),
          children: [
            InconvenienceScreen(),
            AirConditioningScreen(),
            LightOutScreen(),
          ],
        ),
      ),
    );
  }
}
