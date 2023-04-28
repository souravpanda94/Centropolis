import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  dynamic notificationList = [
    {
      "title": "불편사항 접수 게시판에 답변이 작성되었습니다.",
      "subtitle":
          "I heard that the feature is open, when will it be released? I heard that the feature is open, when will it be released?",
      "datetime": "2023.00.00 13:00",
      "content": "Contents"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.greyColor2,
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              color: CustomColors.whiteColor,
              child: CommonAppBar(tr("notificationHistory"), true, () {
                onBackButtonPress(context);
              }, () {}),
            ),
          ),
        ),
        body: Container(
            margin: const EdgeInsets.only(top: 32, left: 16, right: 16),
            child: ListView.builder(itemBuilder: ((context, index) {
              return Container(
                padding: const EdgeInsets.all(16),
              );
            }))));
  }
}
