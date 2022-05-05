// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:caominhtien_61cntt2/homework5/components/rss_item.dart';
import 'package:flutter/material.dart';

class RSSList extends StatelessWidget {
  final List<RSSItem> rss;
  const RSSList({
    Key? key,
    required this.rss,
  }) : super(key: key);
  // const PhotoList({Key key, this.photos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 200,
      padding: const EdgeInsets.all((5)),
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      children: List.generate(
          rss.length,
          (index) => Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                ),
                child: Image.network(rss[index].imgUrl!),
              )),
    );
  }
}
