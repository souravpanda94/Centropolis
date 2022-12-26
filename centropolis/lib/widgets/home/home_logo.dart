import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/custom_colors.dart';

class HomeLogo extends StatelessWidget {
  const HomeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/home_image.png',
          fit: BoxFit.fitWidth,
          width: MediaQuery.of(context).size.width,
        ),
        Column(
          children: [
            Image.asset(
              'assets/images/centropolis_logo.png',
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              tr('homeTitle'),
              style: const TextStyle(
                  color: CustomColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(tr('homeSubtitle'),
                style: const TextStyle(
                    color: CustomColors.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }
}
