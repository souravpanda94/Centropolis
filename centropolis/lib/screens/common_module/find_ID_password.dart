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
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.only(top: 32, left: 16, right: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: tr("email"),
                                style: const TextStyle(
                                    fontFamily: 'Bold',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: CustomColors.textColor8),
                                children: const [
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: CustomColors.heatingColor,
                                          fontSize: 12))
                                ]),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextField(
                            cursorColor: CustomColors.textColorBlack2,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: CustomColors.whiteColor,
                              filled: true,
                              contentPadding: const EdgeInsets.all(16),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                    color: CustomColors.dividerGreyColor,
                                    width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                    color: CustomColors.dividerGreyColor,
                                    width: 1.0),
                              ),
                              hintText: tr('emailHint'),
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
                          Container(
                            margin: const EdgeInsets.only(top: 32, bottom: 16),
                            child: CommonButton(
                                onCommonButtonTap: () {},
                                buttonColor: CustomColors.buttonColor,
                                buttonName: tr("findID"),
                                isIconVisible: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.only(top: 32, left: 16, right: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: tr("IDHeading"),
                                style: const TextStyle(
                                    fontFamily: 'Bold',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: CustomColors.textColor8),
                                children: const [
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: CustomColors.heatingColor,
                                          fontSize: 12))
                                ]),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextField(
                            cursorColor: CustomColors.textColorBlack2,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: CustomColors.whiteColor,
                              filled: true,
                              contentPadding: const EdgeInsets.all(16),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                    color: CustomColors.dividerGreyColor,
                                    width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                    color: CustomColors.dividerGreyColor,
                                    width: 1.0),
                              ),
                              hintText: tr('IDHint'),
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
                          const SizedBox(
                            height: 16,
                          ),
                          RichText(
                            text: TextSpan(
                                text: tr("email"),
                                style: const TextStyle(
                                    fontFamily: 'Bold',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: CustomColors.textColor8),
                                children: const [
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: CustomColors.heatingColor,
                                          fontSize: 12))
                                ]),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextField(
                            cursorColor: CustomColors.textColorBlack2,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: CustomColors.whiteColor,
                              filled: true,
                              contentPadding: const EdgeInsets.all(16),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                    color: CustomColors.dividerGreyColor,
                                    width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                    color: CustomColors.dividerGreyColor,
                                    width: 1.0),
                              ),
                              hintText: tr('emailHint'),
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
                          Container(
                            margin: const EdgeInsets.only(top: 32, bottom: 16),
                            child: CommonButton(
                                onCommonButtonTap: () {},
                                buttonColor: CustomColors.buttonColor,
                                buttonName: tr("findPassword"),
                                isIconVisible: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
