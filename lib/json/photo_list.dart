// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'photo.dart';

class PhotoList extends StatelessWidget {
  final List<Photo> photos;
  const PhotoList({
    Key? key,
    required this.photos,
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
          photos.length,
          (index) => Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                ),
                child: Image.network(photos[index].thumbnailUrl!),
              )),
    );
  }
}
