import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_colors.dart';

class DetailImageSlider extends StatefulWidget {
  const DetailImageSlider({super.key});

  @override
  State<StatefulWidget> createState() => _DetailImageSliderState();
}

class _DetailImageSliderState extends State<DetailImageSlider> {
  CarouselController buttonCarouselController = CarouselController();
  int initialPage = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Stack(children: [
        CarouselSlider.builder(
          carouselController: buttonCarouselController,
          itemCount: 5,
          options: CarouselOptions(
            viewportFraction: 1,
            padEnds: false,
            height: 230,
            initialPage: 0,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlay: false,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                initialPage = index + 1;
              });
            },
          ),
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Image.asset(
            'assets/images/meeting_room1.png',
            fit: BoxFit.fitHeight,
          ),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => buttonCarouselController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: CustomColors.borderColor,
                size: 20,
              ),
            )),
        Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => buttonCarouselController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear),
              icon: const Icon(Icons.arrow_forward_ios,
                  size: 20, color: CustomColors.borderColor),
            )),
        Align(
            alignment: Alignment.bottomRight,
            child: Container(
                width: 40,
                margin: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 40),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: CustomColors.blackColor.withOpacity(0.4)),
                child: Text(
                  '$initialPage / 5',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: CustomColors.whiteColor,
                      fontFamily: 'Regular',
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                ))),
      ]),
    );
  }
}
