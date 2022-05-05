import 'dart:io';
import 'package:caominhtien_61cntt2/homework5/components/rss_helper.dart';
import 'package:caominhtien_61cntt2/homework5/components/rss_item.dart';
import 'package:caominhtien_61cntt2/homework5/screen/rss_list.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class VNExpressApp extends StatefulWidget {
  const VNExpressApp({Key? key}) : super(key: key);

  @override
  State<VNExpressApp> createState() => _VNExpressAppState();
}

class _VNExpressAppState extends State<VNExpressApp> {
  late Future<List<RSSItem>?> rssItems;

  @override
  void initState() {
    super.initState();
    rssItems = RSSHelper.readVNExpressRSS();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  Widget getImage(String? url) {
    if (url != null) {
      return Image.network(
        url,
        fit: BoxFit.fitWidth,
      );
    }
    return const Center(
      child: Icon(Icons.image),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VNExpress'),
      ),
      body: RefreshIndicator(onRefresh: () async {
        debugPrint('onRefresh');
        rssItems = RSSHelper.readVNExpressRSS().whenComplete(() {
          setState(() {});
        });
      }, child: FutureBuilder<List<RSSItem>>(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            debugPrint('Loi xay ra');
            return const Text('Loi xay ra');
          } else {
            debugPrint("Error,${snapshot.hasData}");
            return snapshot.hasData
                ? RSSList(rss: snapshot.data!)
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          }
        },
      )),
    );
  }
}
