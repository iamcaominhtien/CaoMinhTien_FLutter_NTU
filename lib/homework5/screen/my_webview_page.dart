// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class MyWebViewPagePlus extends StatefulWidget {
  final String url;
  const MyWebViewPagePlus({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<MyWebViewPagePlus> createState() => _MyWebViewPagePlusState();
}

class _MyWebViewPagePlusState extends State<MyWebViewPagePlus> {
  WebViewPlusController? _controller;
  double _height = 1;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: _height,
          child: WebViewPlus(
            onWebViewCreated: (controller) {
              _controller = controller;
              controller.loadUrl(widget.url);
            },
            onPageFinished: (url) {
              _controller?.getHeight().then((double height) {
                setState(() {
                  _height = height;
                });
              });
            },
            javascriptMode: JavascriptMode.unrestricted,
          ),
        )
      ],
    );
  }
}

class MyWebViewPage extends StatefulWidget {
  final String url;
  const MyWebViewPage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<MyWebViewPage> createState() => _MyWebViewPageState();
}

class _MyWebViewPageState extends State<MyWebViewPage> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}