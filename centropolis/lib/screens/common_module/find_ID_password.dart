import 'package:centropolis/screens/common_module/findID.dart';
import 'package:centropolis/screens/common_module/findPassword.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';

class FindIDPassword extends StatefulWidget {
  final int page;
  const FindIDPassword({super.key, required this.page});

  @override
  State<FindIDPassword> createState() => _FindIDPasswordState();
}

class _FindIDPasswordState extends State<FindIDPassword>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = widget.page;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.page,
      child: Scaffold(
        backgroundColor: CustomColors.whiteColor,
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              color: CustomColors.whiteColor,
              child: CommonAppBar(tr("findID/Password"), false, () {
                onBackButtonPress(context);
              }, () {}),
            ),
          ),
        ),
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              indicatorColor: CustomColors.buttonColor,
              unselectedLabelColor: CustomColors.greyColor1,
              labelColor: CustomColors.textColor8,
              labelStyle: const TextStyle(
                  fontFamily: 'Bold', fontWeight: FontWeight.w600),
              unselectedLabelStyle: const TextStyle(
                  fontFamily: 'Regular', fontWeight: FontWeight.w500),
              tabs: [
                Tab(
                  child: Text(
                    tr("findID"),
                    style: const TextStyle(fontFamily: 'Regular', fontSize: 14),
                  ),
                ),
                Tab(
                  child: Text(
                    tr("findPassword"),
                    style: const TextStyle(fontFamily: 'Regular', fontSize: 14),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [FindID(), FindPassword()],
              ),
            )
          ],
        ),
      ),
    );
  }
}
