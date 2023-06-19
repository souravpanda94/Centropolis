import 'package:flutter/material.dart';
import 'package:qr_code_scanner/src/types/barcode.dart';

import '../../utils/custom_colors.dart';

class ResultScreen extends StatefulWidget {
  final String? result;

  const ResultScreen(this.result, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
   return Center(
     child: Text(
       widget.result.toString(),
       style: const TextStyle(
         fontSize: 12,
         fontFamily: "Bold",
         color: CustomColors.textColor8,
       ),
     ),
   );
  }

}