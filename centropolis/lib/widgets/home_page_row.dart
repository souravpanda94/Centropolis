import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/custom_colors.dart';

class HomePageRow extends StatefulWidget {
  final String title, subtitle, name, image, min, max;

  const HomePageRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.min,
    required this.max,
    required this.name,
  });

  @override
  State<StatefulWidget> createState() => _HomePageRowState();
}

class _HomePageRowState extends State<HomePageRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 16, top: 60, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                    color: CustomColors.textColorBlack1,
                    fontSize: 24,
                    fontFamily: 'Pretendard-Regular',
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                width: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(widget.subtitle,
                    style: const TextStyle(
                        fontFamily: 'Pretendard-Regular',
                        color: CustomColors.textColorGrey,
                        fontSize: 14)),
              )
            ],
          ),
          Container(
              margin: const EdgeInsets.only(top: 5),
              child: ImageSlideshow(
                  height: 350,
                  initialPage: 0,
                  indicatorBackgroundColor:
                      CustomColors.indicatorDotBackgroundColor,
                  indicatorColor: CustomColors.selectedColor,
                  children: [
                    Image.asset(
                      widget.image,
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Image.asset(
                      widget.image,
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Image.asset(
                      widget.image,
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Image.asset(
                      widget.image,
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width,
                    )
                  ])),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.min,
                        style: const TextStyle(
                          color: CustomColors.textColorBlack2,
                          fontSize: 13,
                          fontFamily: 'Pretendard-Regular',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4, right: 4),
                        child: const Text('-',
                            style: TextStyle(
                              color: CustomColors.blackColor,
                            )),
                      ),
                      Text(widget.max,
                          style: const TextStyle(
                            color: CustomColors.textColorBlack2,
                            fontSize: 13,
                            fontFamily: 'Pretendard-Regular',
                            fontWeight: FontWeight.w400,
                          )),
                      Container(
                        margin: const EdgeInsets.only(left: 12, right: 12),
                        child: const VerticalDivider(
                          color: CustomColors.dividerGreyColor,
                        ),
                      ),
                      Text(widget.name,
                          style: const TextStyle(
                            color: CustomColors.textColorBlack2,
                            fontSize: 14,
                            fontFamily: 'Pretendard-Regular',
                            fontWeight: FontWeight.w700,
                          ))
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          tr('homeRowBook'),
                          maxLines: 1,
                          style: const TextStyle(
                            color: CustomColors.textColorBlack2,
                            fontSize: 14,
                            fontFamily: 'Pretendard-Regular',
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          margin: const EdgeInsets.only(left: 8),
                          child: SvgPicture.asset(
                            'assets/images/ic_right_arrow_white.svg',
                            color: CustomColors.textColorBlack2,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
