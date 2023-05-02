import 'package:flutter/material.dart';

import '../../utils/custom_colors.dart';

class MyPageRow extends StatelessWidget {
  final List<dynamic> requestList;
  final Function onRowPressed;
  const MyPageRow(
      {super.key, required this.requestList, required this.onRowPressed});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: requestList.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return InkWell(
            onTap: () {
              onRowPressed.call();
            },
            child: Container(
                margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                decoration: BoxDecoration(
                  color: CustomColors.whiteColor,
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: CustomColors.borderColor, width: 1.0),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          requestList[index]["name"],
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: "Bold",
                              color: CustomColors.textColor1),
                        ),
                        Row(
                          children: [
                            Visibility(
                              visible:
                                  requestList[index]["status"].toString() ==
                                              'cancellation' ||
                                          requestList[index]["status"]
                                              .toString()
                                              .isEmpty
                                      ? false
                                      : true,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Icon(
                                  Icons.circle,
                                  size: 5,
                                  color:
                                      requestList[index]["status"].toString() ==
                                              'heating'
                                          ? CustomColors.headingColor
                                          : CustomColors.coolingColor,
                                ),
                              ),
                            ),
                            Text(
                              requestList[index]["status"],
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Bold",
                                  color:
                                      requestList[index]["status"].toString() ==
                                              'cancellation'
                                          ? CustomColors.textColor6
                                          : CustomColors.textColor7),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 6),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            requestList[index]["dateTime"],
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: "Regular",
                              color: CustomColors.unSelectedColor,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ))
                  ],
                )));
      },
    );
  }
}
