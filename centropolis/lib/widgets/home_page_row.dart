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
      margin: const EdgeInsets.only(left: 16, top: 60),
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
            child: Image.asset(
              widget.image,
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            height: 20,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 12, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        const SizedBox(
                          width: 4,
                        ),
                        const Text('-',
                            style: TextStyle(
                              color: CustomColors.blackColor,
                            )),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(widget.max,
                            style: const TextStyle(
                              color: CustomColors.textColorBlack2,
                              fontSize: 13,
                              fontFamily: 'Pretendard-Regular',
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const VerticalDivider(
                      color: CustomColors.dividerGreyColor,
                    ),
                    const SizedBox(
                      width: 12,
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
                Row(
                  children: [
                    const Text('예약하기',
                        style: TextStyle(
                          color: CustomColors.textColorBlack2,
                          fontSize: 14,
                          fontFamily: 'Pretendard-Regular',
                          fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    SvgPicture.asset(
                      'assets/images/ic_right_arrow_white.svg',
                      color: CustomColors.textColorBlack2,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
