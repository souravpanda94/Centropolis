import 'package:flutter/cupertino.dart';

class AmenityDetailRow extends StatelessWidget {
  final String title, subtitle;
  final Color titleTextColor, subtitleTextColor;
  final double titleFontSize, subtitleFontSize;

  const AmenityDetailRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.titleFontSize,
    required this.titleTextColor,
    required this.subtitleFontSize,
    required this.subtitleTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: titleTextColor,
              fontFamily: 'Regular',
              fontSize: titleFontSize,
              fontWeight: FontWeight.w400),
        ),
        Text(
          subtitle,
          style: TextStyle(
              color: subtitleTextColor,
              fontFamily: 'Regular',
              fontSize: subtitleFontSize,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
