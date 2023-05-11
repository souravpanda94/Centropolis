import 'package:centropolis/utils/custom_colors.dart';
import 'package:centropolis/widgets/common_button_with_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/voc/air_conditioning_details.dart';
import '../screens/voc/inconvenience_details.dart';

class VocCommonHome extends StatefulWidget {
  final String image, title, subTitle, emptyTxt;
  final Function onDrawerClick;
  final List<dynamic>? itemsList;
  const VocCommonHome(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.emptyTxt,
      required this.onDrawerClick,
      this.itemsList});

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
                  ? Container(
                      margin: const EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 100),
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: widget.itemsList!.length,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: () {
                                widget.itemsList![index]["type"]
                                        .toString()
                                        .isNotEmpty
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AirConditioningDetails(
                                                  type: widget.itemsList![index]
                                                          ["status"]
                                                      .toString()),
                                        ),
                                      )
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              InconvenienceDetails(
                                                  type: widget.itemsList![index]
                                                          ["status"]
                                                      .toString()),
                                        ),
                                      );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: CustomColors.whiteColor,
                                    border: Border.all(
                                      color: CustomColors.borderColor,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4))),
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.only(bottom: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.itemsList![index]["type"]
                                            .toString()
                                            .isNotEmpty
                                        ? Row(
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                size: 8,
                                                color: widget.itemsList![index]
                                                            ["type"] ==
                                                        "Heating"
                                                    ? CustomColors.headingColor
                                                    : CustomColors.coolingColor,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                widget.itemsList![index]
                                                    ["type"],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'SemiBold',
                                                    fontSize: 12,
                                                    color: CustomColors
                                                        .textColorBlack2),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    widget.itemsList![index]["type"]
                                            .toString()
                                            .isNotEmpty
                                        ? const SizedBox(
                                            height: 18,
                                          )
                                        : Container(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            widget.itemsList![index]["title"],
                                            style: const TextStyle(
                                                fontFamily: 'SemiBold',
                                                fontSize: 14,
                                                color: CustomColors.textColor8),
                                          ),
                                        ),
                                        if (widget.itemsList![index]["status"]
                                            .toString()
                                            .isNotEmpty)
                                          Container(
                                            decoration: BoxDecoration(
                                              color: widget.itemsList![index]
                                                              ["status"]
                                                          .toString() ==
                                                      "Received"
                                                  ? CustomColors
                                                      .backgroundColor3
                                                  : widget.itemsList![index]
                                                                  ["status"]
                                                              .toString() ==
                                                          "Answered"
                                                      ? CustomColors
                                                          .backgroundColor
                                                      : widget.itemsList![index]
                                                                      ["status"]
                                                                  .toString() ==
                                                              "In Progress"
                                                          ? CustomColors
                                                              .greyColor2
                                                          : CustomColors
                                                              .textColorBlack2,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 10.0,
                                                right: 10.0),
                                            child: Text(
                                              widget.itemsList![index]
                                                  ["status"],
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: "SemiBold",
                                                color: widget.itemsList![index]
                                                                ["status"]
                                                            .toString() ==
                                                        "Received"
                                                    ? CustomColors.textColor9
                                                    : widget.itemsList![index]
                                                                    ["status"]
                                                                .toString() ==
                                                            "Answered"
                                                        ? CustomColors
                                                            .textColorBlack2
                                                        : widget.itemsList![
                                                                        index][
                                                                        "status"]
                                                                    .toString() ==
                                                                "In Progress"
                                                            ? CustomColors
                                                                .brownColor
                                                            : CustomColors
                                                                .textColorBlack2,
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
                                            widget.itemsList![index]["module"],
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
                                            widget.itemsList![index]["date"],
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
                          })))
                  : Container(
                      color: CustomColors.backgroundColor,
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
