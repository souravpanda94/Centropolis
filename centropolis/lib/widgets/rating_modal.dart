import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../utils/custom_colors.dart';

class RatingModal extends StatefulWidget {
  final String heading;
  final String description;
  final String firstButtonName;
  final String secondButtonName;

  final Function onFirstBtnTap;
  final Function onSecondBtnTap;

  const RatingModal({
    Key? key,
    required this.heading,
    required this.description,
    required this.firstButtonName,
    required this.secondButtonName,
    required this.onFirstBtnTap,
    required this.onSecondBtnTap,
  }) : super(key: key);

  @override
  State<RatingModal> createState() => _RatingModalState();
}

class _RatingModalState extends State<RatingModal> {
  double complaintRating = 0.0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        insetPadding: const EdgeInsets.only(left: 18.0, right: 18.0),
        contentPadding: const EdgeInsets.only(
            top: 30, bottom: 30.0, left: 30.0, right: 30.0),
        scrollable: true,
        content: SizedBox(
          width: width,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            SizedBox(
              child: Text(
                widget.heading,
                style: const TextStyle(
                  color: CustomColors.textColor8,
                  fontSize: 16,
                  fontFamily: 'SemiBold',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (widget.description != "")
              Container(
                margin: const EdgeInsets.only(top: 15.0, bottom: 10),
                child: Text(
                  widget.description,
                  style: const TextStyle(
                    color: CustomColors.textColor5,
                    fontSize: 14,
                    height: 1.5,
                    fontFamily: 'Regular',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            RatingBar(
              itemSize: 32,
              wrapAlignment: WrapAlignment.center,
              initialRating: 0.0,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              ratingWidget: RatingWidget(
                full: Image.asset(
                  "assets/images/full_star.png",
                  height: 32,
                  width: 32,
                ),
                half: Image.asset(
                  "assets/images/half_star.png",
                  height: 32,
                  width: 32,
                ),
                empty: Image.asset(
                  "assets/images/empty_star.png",
                  height: 32,
                  width: 32,
                ),
              ),
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              onRatingUpdate: (rating) {
                debugPrint("rating ::: $rating");
                setState(() {
                  complaintRating = rating;
                });
              },
            ),
            if (widget.firstButtonName != "" && widget.secondButtonName != "")
              Container(
                  margin: const EdgeInsets.only(top: 24.0, bottom: 2),
                  width: double.infinity,
                  height: 46,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: CustomColors.buttonBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            shadowColor: Colors.transparent,
                          ),
                          child: Text(
                            widget.firstButtonName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: CustomColors.whiteColor,
                              fontFamily: 'Bold',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            widget.onFirstBtnTap();
                          },
                        ),
                      )),
                      const SizedBox(
                        width: 14.0,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 46,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: CustomColors.buttonBackgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              shadowColor: Colors.transparent,
                            ),
                            child: Text(
                              widget.secondButtonName,
                              style: const TextStyle(
                                fontSize: 14,
                                color: CustomColors.whiteColor,
                                fontFamily: 'Bold',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              widget.onSecondBtnTap(complaintRating);
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
          ]),
        ));
  }
}
