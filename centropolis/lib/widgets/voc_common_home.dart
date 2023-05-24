import 'package:centropolis/screens/voc/light_out_details.dart';
import 'package:centropolis/utils/custom_colors.dart';
import 'package:centropolis/widgets/common_button_with_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  final List<dynamic>? itemsList;
  const VocCommonHome(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.emptyTxt,
      required this.onDrawerClick,
      required this.category,
      this.itemsList});

  @override
  State<VocCommonHome> createState() => _VocCommonHomeState();
}

class _VocCommonHomeState extends State<VocCommonHome> {
  List<IncovenienceListModel>? inconvenienceList = [];
  List<LightOutListModel>? lightoutList = [];
  @override
  void initState() {
    if (widget.category == "inconvenience") {
      inconvenienceList = widget.itemsList?.cast<IncovenienceListModel>();
    } else if (widget.category == "lightout") {
      lightoutList = widget.itemsList?.cast<LightOutListModel>();
    }
    super.initState();
  }

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
                height: 320,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 15),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      fontFamily: 'Regular',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.textColor9),
                ),
              ),
              Container(
                //height: 62,
                margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          widget.subTitle,
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: CustomColors.textColorBlack2),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        widget.onDrawerClick();
                      },
                      child: SizedBox(
                        child: SvgPicture.asset(
                          'assets/images/ic_drawer.svg',
                          semanticsLabel: 'Back',
                          width: 25,
                          height: 25,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              widget.itemsList!.isNotEmpty
                  ? inconvenienceList != null && inconvenienceList!.isNotEmpty
                      ? inconvenienceListWidget()
                      : lightoutList != null && lightoutList!.isNotEmpty
                          ? lightOutListWidget()
                          : Container()
                  : emptyViewWidget(),
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
          itemCount: inconvenienceList?.length,
          itemBuilder: ((context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InconvenienceDetails(
                        inquiryId:
                            inconvenienceList?[index].inquiryId.toString() ??
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
                        Expanded(
                          child: Text(
                            inconvenienceList?[index].title ?? "",
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        if (inconvenienceList != null &&
                            inconvenienceList![index]
                                .status
                                .toString()
                                .isNotEmpty)
                          Container(
                            decoration: BoxDecoration(
                              color:
                                  inconvenienceList?[index].status.toString() ==
                                              "Received" ||
                                          inconvenienceList?[index]
                                                  .status
                                                  .toString() ==
                                              "Not Answered"
                                      ? CustomColors.backgroundColor3
                                      : inconvenienceList?[index]
                                                      .status
                                                      .toString() ==
                                                  "Answered" ||
                                              inconvenienceList?[index]
                                                      .status
                                                      .toString() ==
                                                  "Completed"
                                          ? CustomColors.backgroundColor
                                          : inconvenienceList?[index]
                                                      .status
                                                      .toString() ==
                                                  "In Progress"
                                              ? CustomColors.greyColor2
                                              : CustomColors.textColorBlack2,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                            child: Text(
                              inconvenienceList?[index].status.toString() ==
                                      "Not Answered"
                                  ? "Received"
                                  : inconvenienceList?[index].status ?? "",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "SemiBold",
                                color: inconvenienceList?[index]
                                                .status
                                                .toString() ==
                                            "Received" ||
                                        inconvenienceList?[index]
                                                .status
                                                .toString() ==
                                            "Not Answered"
                                    ? CustomColors.textColor9
                                    : inconvenienceList?[index]
                                                    .status
                                                    .toString() ==
                                                "Answered" ||
                                            inconvenienceList?[index]
                                                    .status
                                                    .toString() ==
                                                "Completed"
                                        ? CustomColors.textColorBlack2
                                        : inconvenienceList?[index]
                                                    .status
                                                    .toString() ==
                                                "In Progress"
                                            ? CustomColors.brownColor
                                            : CustomColors.textColorBlack2,
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
                            inconvenienceList?[index].type ?? "",
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
                          const VerticalDivider(
                            thickness: 1,
                            color: CustomColors.borderColor,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            inconvenienceList?[index].registeredDate ?? "",
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
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 40, bottom: 40),
      child: Text(
        widget.emptyTxt,
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
            itemCount: lightoutList?.length,
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LightsOutDetails(
                          type: lightoutList?[index].status.toString() ?? ""),
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
                          Expanded(
                            child: Text(
                              lightoutList?[index].description ?? "",
                              //"Centropolis",
                              maxLines: 1,
                              style: const TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 14,
                                  color: CustomColors.textColor8),
                            ),
                          ),
                          if (lightoutList != null &&
                              lightoutList![index].status.toString().isNotEmpty)
                            Container(
                              decoration: BoxDecoration(
                                color: lightoutList?[index].status.toString() ==
                                        "Received"
                                    ? CustomColors.backgroundColor3
                                    : lightoutList?[index].status.toString() ==
                                                "Answered" ||
                                            lightoutList?[index]
                                                    .status
                                                    .toString() ==
                                                "Approved"
                                        ? CustomColors.backgroundColor
                                        : lightoutList?[index]
                                                    .status
                                                    .toString() ==
                                                "In Progress"
                                            ? CustomColors.greyColor2
                                            : CustomColors.textColorBlack2,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 5.0,
                                  left: 10.0,
                                  right: 10.0),
                              child: Text(
                                lightoutList?[index].status ?? "",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "SemiBold",
                                  color: lightoutList?[index]
                                              .status
                                              .toString() ==
                                          "Received"
                                      ? CustomColors.textColor9
                                      : lightoutList?[index]
                                                      .status
                                                      .toString() ==
                                                  "Answered" ||
                                              lightoutList?[index]
                                                      .status
                                                      .toString() ==
                                                  "Approved"
                                          ? CustomColors.textColorBlack2
                                          : lightoutList?[index]
                                                      .status
                                                      .toString() ==
                                                  "In Progress"
                                              ? CustomColors.brownColor
                                              : CustomColors.textColorBlack2,
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
                              lightoutList?[index].requestedFloors.toString() ??
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
                            const VerticalDivider(
                              thickness: 1,
                              color: CustomColors.borderColor,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${lightoutList?[index].registeredDate ?? ""} ${lightoutList?[index].startTime ?? ""}",
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
}
