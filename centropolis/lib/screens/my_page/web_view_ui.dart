import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/app_bar_for_dialog.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_web_view.dart';


class WebViewUiScreen extends StatefulWidget {
  final String pageTitle,webUrl;

  const WebViewUiScreen(
      this.pageTitle,
      this.webUrl, {
    Key ?key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WebViewUiScreenState();
  }
}

class _WebViewUiScreenState extends State<WebViewUiScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              color: CustomColors.whiteColor,
              child: CommonAppBar(widget.pageTitle, false, () {
                onBackButtonPress(context);
              }, () {}),
            ),
          ),
        ),
        body: CommonWebview(
          webUrl: widget.webUrl,
        )

    );
  }
}
