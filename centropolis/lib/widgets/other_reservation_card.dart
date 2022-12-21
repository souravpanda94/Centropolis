import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/custom_colors.dart';

class OtherReservationCard extends StatefulWidget {
  final String title;

  const OtherReservationCard({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _OtherReservationCardState();
}

class _OtherReservationCardState extends State<OtherReservationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColors.cardBackgroundGreyColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 10, right: 48, bottom: 36),
            child: Text(widget.title,
                style: const TextStyle(
                  color: CustomColors.textColor1,
                  fontSize: 14,
                  fontFamily: 'Pretendard-Regular',
                  fontWeight: FontWeight.w600,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10),
            child: Row(
              children: [
                const Text('바로가기',
                    style: TextStyle(
                      color: CustomColors.textGreyColor,
                      fontSize: 12,
                      fontFamily: 'Pretendard-Regular',
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(
                  width: 8,
                ),
                SvgPicture.asset(
                  'assets/images/ic_right_arrow_white.svg',
                  color: CustomColors.textGreyColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
