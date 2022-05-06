// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:caominhtien_61cntt2/homework5/components/rss_item.dart';
import 'package:flutter/material.dart';

import 'web_view_page.dart';

class RSSList extends StatelessWidget {
  final List<RSSItem> rss;
  const RSSList({
    Key? key,
    required this.rss,
  }) : super(key: key);
  // const PhotoList({Key key, this.photos}) : super(key: key);

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
    return ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                debugPrint(rss[index].link);
                return WebViewPage(
                  url: rss[index].link!,
                );
              }));
            },
            child: ListTile(
              title: Row(children: [
                // Image.asset(rss[index].title!),
                Expanded(child: getImage(rss[index].imgUrl)),
                const SizedBox(
                  width: 15,
                ),
                Expanded(child: Text(rss[index].title!)),
              ]),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(
              height: 1,
              thickness: 1,
            ),
        itemCount: rss.length);
  }
}
