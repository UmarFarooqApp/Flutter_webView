import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


import 'NavigationControls.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.controller, super.key}); // Modify

final Completer<WebViewController> controller;   // Add this attribute

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;


  @override
  Widget build(BuildContext context) {
    return  Stack(
        children: [
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: 'https://flutter.dev',
            onWebViewCreated: (webViewController) {
              widget.controller.complete(webViewController);
            },
            onPageStarted: (url) {
              if(loadingPercentage<100)
                Center(
                  child: CircularProgressIndicator(),
                );
              setState(() {
                loadingPercentage = 0;
              });
            },


            onProgress: (progress) {
              setState(() {
                loadingPercentage = progress;
              });
            },
            onPageFinished: (url) {
              setState(() {
                loadingPercentage = 100;
              });
            },
          ),
          // if (loadingPercentage < 100)
          //   LinearProgressIndicator(
          //     color: Colors.red,
          //     value: loadingPercentage / 100.0,
          //   ),
          if(loadingPercentage<100)
            Center(
              child: CircularProgressIndicator(),
            )

        ],
      );

  }
}