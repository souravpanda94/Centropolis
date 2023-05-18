import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/custom_colors.dart';
import '../../widgets/common_button.dart';
import '../../widgets/view_more.dart';
import 'add_member.dart';
import 'registered_employee_detail.dart';

class EmployeeList extends StatefulWidget {
  final String status;
  const EmployeeList({super.key, required this.status});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List<dynamic> list = [
    {
      "name": "Hong Gil Dong",
      "type": "Conference Room",
      "date": "2023.00.00",
      "status": "Approved"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Executive Lounge",
      "date": "2023.00.00",
      "status": "Approved"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Executive Lounge",
      "date": "2023.00.00",
      "status": "Approved"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Executive Lounge",
      "date": "2023.00.00",
      "status": "Approved"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Executive Lounge",
      "date": "2023.00.00",
      "status": "Approved"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Executive Lounge",
      "date": "2023.00.00",
      "status": "Approved"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Executive Lounge",
      "date": "2023.00.00",
      "status": "Approved"
    },
    {
      "name": "Hong Gil Dong",
      "type": "Executive Lounge",
      "date": "2023.00.00",
      "status": "Approved"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Approved"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Approved"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Suspended"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Suspended"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Suspended"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Suspended"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Suspended"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Suspended"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Suspended"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Suspended"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Suspended"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Suspended"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Suspended"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Suspended"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Suspended"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Before Approval"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Before Approval"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Before Approval"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Before Approval"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Before Approval"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Before Approval"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Before Approval"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Before Approval"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Before Approval"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Before Approval"
    },
    {
      "name": "Hong Gil Dong",
      "type": "",
      "date": "2023.00.00",
      "status": "Before Approval"
    },
  ];
  List<dynamic> approvedList = [];

  @override
  void initState() {
    approvedList = list.where((map) => map["status"] == widget.status).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 33),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    tr("total"),
                    style: const TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 14,
                        color: CustomColors.textColorBlack2),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      "15",
                      style: TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 14,
                          color: CustomColors.textColor9),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    tr("all"),
                    style: const TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 14,
                        color: CustomColors.textColor5),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  SvgPicture.asset("assets/images/ic_drop_down_arrow.svg",
                      color: CustomColors.textColor5)
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 9,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: approvedList.length,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const RegisteredEmployeeDetails(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: CustomColors.whiteColor,
                          border: Border.all(
                            color: CustomColors.borderColor,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4))),
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                approvedList[index]["name"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8),
                              ),
                              if (approvedList[index]["type"]
                                  .toString()
                                  .isNotEmpty)
                                Container(
                                  decoration: BoxDecoration(
                                    color: CustomColors.backgroundColor2,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 5.0,
                                      bottom: 5.0,
                                      left: 12.0,
                                      right: 12.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/ic_logo.svg',
                                        semanticsLabel: 'Back',
                                        width: 15,
                                        height: 15,
                                        alignment: Alignment.center,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        approvedList[index]["type"],
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Bold",
                                          color: CustomColors.textColor8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Row(
                            children: [
                              Text(
                                "${tr("registrationDate")}: ",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 12,
                                    color: CustomColors.textColor3),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                approvedList[index]["date"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 12,
                                    color: CustomColors.textColor3),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                })),
          ),
           ViewMoreWidget(onViewMoreTap: (){},),
          CommonButton(
            onCommonButtonTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddMember(),
                ),
              );
            },
            buttonColor: CustomColors.buttonBackgroundColor,
            buttonName: tr("addMember"),
            isIconVisible: false,
          )
        ],
      ),
    );
  }
}
