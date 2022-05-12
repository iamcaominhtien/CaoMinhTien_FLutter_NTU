import 'package:flutter/material.dart';

class PhuongAlbum extends StatefulWidget {
  const PhuongAlbum({Key? key}) : super(key: key);

  @override
  State<PhuongAlbum> createState() => _PhuongAlbumState();
}

class _PhuongAlbumState extends State<PhuongAlbum> {
  // ignore: non_constant_identifier_names
  int current_image = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Phuong Album',
            style: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/photoAlbum/pic$current_image.jpg',
            width: 300,
          ),
          const SizedBox(
            width: double.infinity,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child:
                    const Icon(Icons.arrow_left, size: 100, color: Colors.blue),
                onPressed: () {
                  setState(() {
                    current_image--;
                    if (current_image < 1) {
                      current_image = 1;
                    }
                  });
                  debugPrint('Left button was pressed $current_image');
                },
              ),
              TextButton(
                child: const Icon(Icons.arrow_right,
                    size: 100, color: Colors.blue),
                onPressed: () {
                  setState(() {
                    current_image++;
                    if (current_image > 6) {
                      current_image = 6;
                    }
                  });
                  debugPrint('Right button was pressed $current_image');
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
