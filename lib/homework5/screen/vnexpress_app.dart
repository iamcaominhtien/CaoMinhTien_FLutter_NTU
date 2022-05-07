import 'package:caominhtien_61cntt2/homework5/components/rss_helper.dart';
import 'package:caominhtien_61cntt2/homework5/components/rss_item.dart';
import 'package:caominhtien_61cntt2/homework5/screen/rss_list.dart';
import 'package:flutter/material.dart';
import '../components/constants.dart';

class VNExpressApp extends StatefulWidget {
  const VNExpressApp({Key? key}) : super(key: key);
  @override
  State<VNExpressApp> createState() => _VNExpressAppState();
}

class _VNExpressAppState extends State<VNExpressApp> {
  late Future<List<RSSItem>> rssItems;
  String header = 'VNEpress';
  late List<Widget> listItem;

  void updateState(String header) {
    setState(() {
      this.header = header;
      RSSHelper.rssURL = listRSS[header]!;
      rssItems = RSSHelper.readVNExpressRSS();
    });
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    rssItems = RSSHelper.readVNExpressRSS();
    listItem = listRSS.keys
        .map((e) => ListTile(
              title: Text(e),
              onTap: () {
                updateState(e);
              },
            ))
        .toList();
    listItem.insert(
        0,
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: appColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  header,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                  ),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
          onTap: null,
        ));
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
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
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: listItem,
        )),
        appBar: AppBar(
          backgroundColor: appColor,
          actions: [
            IconButton(
              icon: const Icon(Icons.turn_left),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
          title: Text(header),
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              debugPrint('onRefresh');
              setState(() {
                rssItems = RSSHelper.readVNExpressRSS();
              });
            },
            child: FutureBuilder<List<RSSItem>>(
              future: rssItems,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  debugPrint('Loi xay ra');
                  return const Text('Loi xay ra');
                } else {
                  debugPrint("Has Data?,${snapshot.hasData}");
                  return snapshot.hasData
                      ? (RSSList(rss: snapshot.data!))
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                }
              },
            )),
      ),
    );
  }
}
