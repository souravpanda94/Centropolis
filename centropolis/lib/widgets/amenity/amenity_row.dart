import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/custom_colors.dart';

class AmenityRow extends StatelessWidget {
  final String image, title, subTitle, userCount;
  final Function onPressed;
  const AmenityRow({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.userCount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed.call();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Image.asset(
              image,
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: 62,
              margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                title,
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    color: CustomColors.textColor1),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                subTitle,
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: CustomColors.textColor1),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                'assets/images/user.svg',
                                height: 15,
                                width: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Text(
                                  userCount,
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
