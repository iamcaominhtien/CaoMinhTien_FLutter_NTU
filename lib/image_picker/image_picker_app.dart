import 'package:caominhtien_61cntt2/image_picker/library_example.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'camera_example.dart';

class ImagePickerApp extends StatefulWidget {
  const ImagePickerApp({Key? key}) : super(key: key);

  @override
  State<ImagePickerApp> createState() => _ImagePickerAppState();
}

class _ImagePickerAppState extends State<ImagePickerApp> {
  String? linkImage;
  late CameraDescription camera;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialCamera();
    debugPrint("1");
  }

  _initialCamera() async {
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    debugPrint(cameras.toString());
    camera = cameras.first;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TakePictureScreen(camera: camera),
        ));
    debugPrint("2");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => const LibraryExample(),
                child: const Text('Pick a photo from Library'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _initialCamera();
                },
                child: const Text('Pick a photo from Camera'),
              ),
            )
          ],
        ),
      ),
    );
    // debugPrint("3");
    // return Container(
    //   color: Colors.white,
    // );
  }
}
