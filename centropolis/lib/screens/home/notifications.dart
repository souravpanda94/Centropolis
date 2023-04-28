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
    },
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
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: ((context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: CustomColors.whiteColor,
                        border: Border.all(
                          color: CustomColors.borderColor,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notificationList[index]["title"],
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.textColor8),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  notificationList[index]["subtitle"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: CustomColors.textColorBlack2),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                notificationList[index]["content"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: CustomColors.textColorBlack2),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          notificationList[index]["datetime"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: CustomColors.textColor3),
                        ),
                      ],
                    ),
                  );
                }))));
  }
}
