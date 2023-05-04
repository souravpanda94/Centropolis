import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../utils/constants.dart';
import '../utils/custom_colors.dart';


class CommonWebview extends StatefulWidget {
  final webUrl;

   const CommonWebview({
    Key ?key,
    this.webUrl,
  }) : super(key: key);

  @override
  _CommonWebviewState createState() => _CommonWebviewState();
}

class _CommonWebviewState extends State<CommonWebview> {
  bool isLoading = true;


  @override
  Widget build(BuildContext context) {
   return Stack(
      children: <Widget>[
        WebView(
          initialUrl: widget.webUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (finish) {
            setState(() {
              isLoading = false;
            });
          },
        ),
        isLoading ? const Center( child: CircularProgressIndicator(color: CustomColors.blackColor,),)
            : Stack(),
      ],
    );
  }
}