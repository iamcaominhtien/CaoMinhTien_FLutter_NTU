// import 'dart:html';
// import 'package:flutter/cupertino.dart';

import 'package:caominhtien_61cntt2/photoAlbum.dart';
import 'package:caominhtien_61cntt2/provider/my_app.dart';
import 'package:flutter/material.dart';

import 'BaiTap4/my_list_product.dart';
import 'form/PageFormGoods.dart';
import 'gridView/grid_view.dart';
import 'my_input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyListProduct(),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hello 61.CNTT2'),
        ),
        body: Center(
          child: Container(
            width: 300,
            height: 200,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            // height: 300,
            // color: Colors.yellow,
            decoration: BoxDecoration(
                color: Colors.yellow,
                border: Border.all(color: Colors.black, width: 8),
                borderRadius: BorderRadius.circular(20)),
            child: const Center(
              child: Text(
                'Chao Cao Minh Tien',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ));
  }
}

class MyHome1 extends StatelessWidget {
  const MyHome1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Cao Minh Tiến')),
      ),
      body: SizedBox(
          width: 500,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  border: Border.all(color: Colors.black, width: 8),
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: const Text(
                "Hello word",
                textAlign: TextAlign.center,
              ))),
    );
  }
}
