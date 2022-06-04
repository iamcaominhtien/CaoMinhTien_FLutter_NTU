import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LibraryExample extends StatefulWidget {
  const LibraryExample({Key? key}) : super(key: key);

  @override
  State<LibraryExample> createState() => _LibraryExampleState();
}

class _LibraryExampleState extends State<LibraryExample> {
  XFile? xImg;

  void _chonAnh(BuildContext context) async {
    xImg = await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chonAnh(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: Image.file(
              File(xImg!.path),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
