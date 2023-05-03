import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';

class FitnessCongestion extends StatefulWidget {
  final String type;
  const FitnessCongestion({super.key, required this.type});

  @override
  State<FitnessCongestion> createState() => _FitnessCongestionState();
}

class _FitnessCongestionState extends State<FitnessCongestion> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(
                color: CustomColors.backgroundColor2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(50))),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: CustomColors.spareColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50))),
                      width: MediaQuery.of(context).size.width / 4,
                      height: 5,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 5,
                      color: widget.type == "commonly" ||
                              widget.type == "confusion" ||
                              widget.type == "full"
                          ? CustomColors.commonlyColor
                          : CustomColors.whiteColor,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 5,
                      color: widget.type == "confusion" || widget.type == "full"
                          ? CustomColors.confusionColor
                          : CustomColors.whiteColor,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 5,
                      decoration: BoxDecoration(
                          color: widget.type == "full"
                              ? CustomColors.fullColor
                              : CustomColors.whiteColor,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(tr("spare"),
                style: TextStyle(
                    fontFamily: widget.type == "spare" ? 'SemiBold' : 'Regular',
                    fontSize: 14,
                    color: widget.type == "spare"
                        ? CustomColors.textColorBlack2
                        : CustomColors.dividerGreyColor)),
            Text(tr("commonly"),
                style: TextStyle(
                    fontFamily:
                        widget.type == "commonly" ? 'SemiBold' : 'Regular',
                    fontSize: 14,
                    color: widget.type == "commonly"
                        ? CustomColors.textColorBlack2
                        : CustomColors.dividerGreyColor)),
            Text(tr("confusion"),
                style: TextStyle(
                    fontFamily:
                        widget.type == "confusion" ? 'SemiBold' : 'Regular',
                    fontSize: 14,
                    color: widget.type == "confusion"
                        ? CustomColors.textColorBlack2
                        : CustomColors.dividerGreyColor)),
            Text(tr("full"),
                style: TextStyle(
                    fontFamily: widget.type == "full" ? 'SemiBold' : 'Regular',
                    fontSize: 14,
                    color: widget.type == "full"
                        ? CustomColors.textColorBlack2
                        : CustomColors.dividerGreyColor))
          ],
        )
      ],
    );
  }
}
