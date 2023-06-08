import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import 'conference.dart';
import 'facilities.dart';
import 'fitness.dart';
import 'lounge.dart';

class TenantServiceScreen extends StatefulWidget {
  final int tabIndex;

  const TenantServiceScreen(this.tabIndex, {super.key});

  @override
  State<TenantServiceScreen> createState() => _TenantServiceScreenState();
}

class _TenantServiceScreenState extends State<TenantServiceScreen> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: tr("lounge")),
    Tab(text: tr("conferenceHeading")),
    Tab(text: tr("fitness")),
    Tab(text: tr("facilities")),
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
      length: 4,
      initialIndex: widget.tabIndex,
      //initialIndex: 0,
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
                isScrollable: true,
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
            LoungeScreen(),
            ConferenceScreen(),
            FitnessScreen(),
            FacilitiesScreen()
          ],
        ),
      ),
    );
  }
}
