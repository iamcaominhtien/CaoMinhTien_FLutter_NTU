import 'package:caominhtien_61cntt2/json/photo_list.dart';
import 'package:flutter/material.dart';

import 'photo.dart';

class MyJsonPhoto extends StatefulWidget {
  const MyJsonPhoto({Key? key}) : super(key: key);

  @override
  State<MyJsonPhoto> createState() => _MyJsonPhotoState();
}

class _MyJsonPhotoState extends State<MyJsonPhoto> {
  late Future<List<Photo>> photos;

  @override
  void initState() {
    super.initState();
    photos = Photo().fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Photo'),
      ),
      body: FutureBuilder<List<Photo>>(
          future: photos,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              debugPrint('Loi xay ra');
              return const Text('Loi xay ra');
            }
            return snapshot.hasData
                ? PhotoList(photos: snapshot.data!)
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}
