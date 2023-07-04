import 'package:centropolis/screens/voc/light_out_details.dart';
import 'package:centropolis/utils/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/air_conditioning_list_model.dart';
import '../models/inconvenience_list_model.dart';
import '../models/light_out_list_model.dart';
import '../screens/voc/air_conditioning_details.dart';
import '../screens/voc/inconvenience_details.dart';

class VocCommonHome extends StatefulWidget {
  final String image;
  final String title;
  final String subTitle;
  final String emptyTxt;
  final String category;
  final Function onDrawerClick;
  final List<IncovenienceListModel>? inconvenienceList;
  final List<LightOutListModel>? lightoutList;
  final List<AirConditioningListModel>? airConditioningList;
  const VocCommonHome({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.emptyTxt,
    required this.onDrawerClick,
    required this.category,
    this.inconvenienceList,
    this.lightoutList,
    this.airConditioningList,
  });

  @override
  State<VocCommonHome> createState() => _VocCommonHomeState();
}

class _VocCommonHomeState extends State<VocCommonHome> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //onPressed.call();
      },
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Image.asset(
                widget.image,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: 300,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 15),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      fontFamily: 'SemiBold',
                      fontSize: 14,
                      color: CustomColors.textColor9),
                ),
              ),
              Container(
                //height: 62,
                margin: const EdgeInsets.only(top: 8, left: 15, right: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0, right: 8),
                        child: Text(
                          widget.subTitle,
                          maxLines: 2,
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 22,
                              color: CustomColors.textColorBlack2),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        widget.onDrawerClick();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: SizedBox(
                          child: SvgPicture.asset(
                            'assets/images/ic_list.svg',
                            semanticsLabel: 'Back',
                            width: 20,
                            height: 20,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              widget.inconvenienceList != null &&
                      widget.inconvenienceList!.isNotEmpty
                  ? inconvenienceListWidget()
                  : widget.lightoutList != null &&
                          widget.lightoutList!.isNotEmpty
                      ? lightOutListWidget()
                      : widget.airConditioningList != null &&
                              widget.airConditioningList!.isNotEmpty
                          ? airConditioningListWidget()
                          : emptyViewWidget()
            ],
          ),
        ),
      ),
    );
  }

  inconvenienceListWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: widget.inconvenienceList?.length,
          itemBuilder: ((context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InconvenienceDetails(
                        inquiryId: widget.inconvenienceList?[index].inquiryId
                                .toString() ??
                            ""),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: CustomColors.whiteColor,
                    border: Border.all(
                      color: CustomColors.borderColor,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(4))),
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            widget.inconvenienceList?[index].title ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (widget.inconvenienceList != null &&
                            widget.inconvenienceList![index].status
                                .toString()
                                .isNotEmpty)
                          Container(
                            decoration: BoxDecoration(
                              color: setStatusBackgroundColor(widget
                                  .inconvenienceList?[index].status
                                  .toString()
                                  .toLowerCase()),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                            child: Text(
                              widget.inconvenienceList?[index].displayStatus ??
                                  "",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "SemiBold",
                                color: setStatusTextColor(widget
                                    .inconvenienceList?[index].status
                                    .toString()
                                    .toLowerCase()),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Text(
                            widget.inconvenienceList?[index].type ?? "",
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
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: VerticalDivider(
                              thickness: 1,
                              color: CustomColors.borderColor,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.inconvenienceList?[index].registeredDate ??
                                "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 12,
                                color: CustomColors.textColor3),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          })),
    );
  }

  emptyViewWidget() {
    return Container(
      color: CustomColors.backgroundColor,
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 100),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Text(
        widget.emptyTxt,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontFamily: 'Regular',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: CustomColors.textColor5),
      ),
    );
  }

  lightOutListWidget() {
    return Container(
        margin:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: widget.lightoutList?.length,
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LightsOutDetails(
                          id: widget.lightoutList?[index].inquiryId
                                  .toString() ??
                              ""),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: CustomColors.whiteColor,
                      border: Border.all(
                        color: CustomColors.borderColor,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              widget.lightoutList?[index].description ?? "",
                              //"Centropolis",
                              maxLines: 1,
                              style: const TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 14,
                                  color: CustomColors.textColor8),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (widget.lightoutList != null &&
                              widget.lightoutList![index].status
                                  .toString()
                                  .isNotEmpty)
                            Container(
                              decoration: BoxDecoration(
                                color: setStatusBackgroundColor(widget
                                    .lightoutList?[index].status
                                    .toString()
                                    .toLowerCase()),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 5.0,
                                  left: 10.0,
                                  right: 10.0),
                              child: Text(
                                widget.lightoutList?[index].displayStatus ?? "",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "SemiBold",
                                  color: setStatusTextColor(widget
                                      .lightoutList?[index].status
                                      .toString()
                                      .toLowerCase()),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Text(
                              widget.lightoutList?[index].requestedFloors
                                      .toString()
                                      .toUpperCase() ??
                                  "",
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
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: VerticalDivider(
                                thickness: 1,
                                color: CustomColors.borderColor,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${widget.lightoutList?[index].registeredDate ?? ""} ${widget.lightoutList?[index].startTime ?? ""}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Regular',
                                  fontSize: 12,
                                  color: CustomColors.textColor3),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            })));
  }

  airConditioningListWidget() {
    return Container(
        margin:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: widget.airConditioningList?.length,
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AirConditioningDetails(
                          inquiryId: widget
                                  .airConditioningList?[index].inquiryId
                                  .toString() ??
                              "",
                          appBarTitle: tr("requestForHeatingAndCooling")),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: CustomColors.whiteColor,
                      border: Border.all(
                        color: CustomColors.borderColor,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: widget.airConditioningList?[index].type
                                        .toString()
                                        .trim()
                                        .toLowerCase() ==
                                    "heating"
                                ? CustomColors.headingColor
                                : CustomColors.coolingColor,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            widget.airConditioningList?[index].displayType
                                    .toString() ??
                                "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 12,
                                color: CustomColors.textColorBlack2),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              widget.airConditioningList?[index].description ??
                                  "",
                              //"Centropolis",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 14,
                                  color: CustomColors.textColor8),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (widget.airConditioningList != null &&
                              widget.airConditioningList![index].status
                                  .toString()
                                  .isNotEmpty)
                            Container(
                              decoration: BoxDecoration(
                                color: setStatusBackgroundColor(widget
                                    .airConditioningList?[index].status
                                    .toString()
                                    .toLowerCase()),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 5.0,
                                  left: 10.0,
                                  right: 10.0),
                              child: Text(
                                widget.airConditioningList?[index]
                                        .displayStatus ??
                                    "",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "SemiBold",
                                  color: setStatusTextColor(widget
                                      .airConditioningList?[index].status
                                      .toString()
                                      .toLowerCase()),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Text(
                              widget.airConditioningList?[index].requestedFloors
                                      .toString()
                                      .toUpperCase() ??
                                  "",
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
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: VerticalDivider(
                                thickness: 1,
                                color: CustomColors.borderColor,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${widget.airConditioningList?[index].registeredDate ?? ""} ${widget.airConditioningList?[index].startTime ?? ""}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Regular',
                                  fontSize: 12,
                                  color: CustomColors.textColor3),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            })));
  }

  Color setStatusBackgroundColor(String? status) {
    if (status == "rejected") {
      return CustomColors.backgroundColor3;
    } else {
      return CustomColors.backgroundColor;
    }
  }

  Color setStatusTextColor(String? status) {
    if (status == "rejected") {
      return CustomColors.textColor9;
    } else if (status == "completed") {
      return CustomColors.textColor3;
    } else {
      return CustomColors.textColorBlack2;
    }
  }
}
