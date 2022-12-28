import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/custom_colors.dart';
import '../../widgets/amenity/bullet_info.dart';

class DetailInfoRow extends StatelessWidget {
  final String image, title, info;
  final List<String> subtitles;
  const DetailInfoRow({
    super.key,
    required this.image,
    required this.title,
    required this.subtitles,
    required this.info,
  });

  Widget getBulletedList(List<String> strings) {
    List<Widget> list = [];

    for (var i = 0; i < strings.length; i++) {
      list.add(BulletInfo(info: strings[i], bulletVisibility: true));
    }
    return Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(image),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: CustomColors.textColor1,
                        fontFamily: 'Regular',
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  subtitles.isNotEmpty
                      ? getBulletedList(subtitles)
                      : BulletInfo(
                          info: info,
                          bulletVisibility: false,
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
