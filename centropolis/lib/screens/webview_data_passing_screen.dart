import 'dart:convert';
import 'package:centropolis/widgets/bottom_navigation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebviewDataPassingScreen extends StatefulWidget {
  const WebviewDataPassingScreen({super.key});

  @override
  State<WebviewDataPassingScreen> createState() => _WebviewDataPassingScreenState();
}

class _WebviewDataPassingScreenState extends State<WebviewDataPassingScreen> {
  WebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(
        initialUrl: 'about:blank',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          _webViewController = webViewController;
          String fileContent = await rootBundle.loadString('assets/index.html');
          _webViewController?.loadUrl(Uri.dataFromString(fileContent, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString());
        },



        //------WebView to receive messages from the web page.-------
        javascriptChannels: <JavascriptChannel>{
          JavascriptChannel(
            name: 'messageHandler',
            onMessageReceived: (JavascriptMessage message) {
              print("message from the web view=\"${message.message}\"");
            },
          )
        },

      ),
    );
  }






}