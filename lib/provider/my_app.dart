import 'package:caominhtien_61cntt2/provider/my_counter_page.dart';
import 'package:flutter/material.dart';
import 'change_notifier.dart';
import 'package:provider/provider.dart';

class MyCounterApp extends StatelessWidget {
  const MyCounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Counter(),
        child: const MaterialApp(
          home: MyCounterPage(),
        ));
  }
}
