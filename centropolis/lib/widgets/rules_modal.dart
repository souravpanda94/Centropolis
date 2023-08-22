import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';

class RulesModal extends StatefulWidget {
  final String heading;
  final String description;
  final String buttonName;
  

  final Function onConfirmBtnTap;


  const RulesModal({
    Key? key,
    required this.heading,
    required this.description,
    required this.buttonName,
    
    required this.onConfirmBtnTap,
   
  }) : super(key: key);

  @override
  _RulesModalState createState() => _RulesModalState();
}

class _RulesModalState extends State<RulesModal> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return AlertDialog(
      
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        insetPadding: const EdgeInsets.only(left: 18.0, right: 18.0,bottom: 30),
        contentPadding: const EdgeInsets.only(
            top: 30, bottom: 30.0, left: 30.0, right: 30.0),
        scrollable: true,
        content: SizedBox(
          width: width,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            if (widget.heading != "")SizedBox(
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
                margin: const EdgeInsets.only(top: 15.0),
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
            // if (widget.buttonName != "")
            //   Container(
            //       margin: const EdgeInsets.only(top: 30.0, bottom: 2),
            //       height: 46,
            //       width: double.infinity,
            //       child: ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //             // padding: const EdgeInsets.only(left: 45.0, right: 45.0),
            //             primary: CustomColors.buttonBackgroundColor,
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(4),
            //             ),
            //             shadowColor: Colors.transparent),
            //         child: Text(
            //           widget.buttonName,
            //           style: const TextStyle(
            //             fontSize: 14,
            //             color: CustomColors.whiteColor,
            //             fontFamily: 'Bold',
            //           ),
            //           textAlign: TextAlign.center,
            //         ),
            //         onPressed: () {
            //           widget.onConfirmBtnTap();
            //         },
            //       )),
            
          ]),
        ));
  }
}
