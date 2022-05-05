import 'package:flutter/material.dart';

class MyPhotoAlbum extends StatefulWidget {
  const MyPhotoAlbum({Key? key}) : super(key: key);

  @override
  State<MyPhotoAlbum> createState() => _MyPhotoAlbumState();
}

class _MyPhotoAlbumState extends State<MyPhotoAlbum> {
  int indexPic = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Photo Album'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/photoAlbum/pic$indexPic.jpg',
                height: 550,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shadowColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      indexPic = ((indexPic - 1) == 0) ? 6 : indexPic - 1;
                    });
                  },
                  child: const Icon(
                    Icons.arrow_left,
                    color: Colors.red,
                    size: 90,
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shadowColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      indexPic = ((indexPic + 1) > 6) ? 1 : indexPic + 1;
                    });
                  },
                  child: const Icon(
                    Icons.arrow_right,
                    color: Colors.red,
                    size: 90,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
