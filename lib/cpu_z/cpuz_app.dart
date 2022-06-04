import 'package:flutter/material.dart';

import 'constant.dart';
import 'menu_bar.dart';

class CPUZApp extends StatefulWidget {
  const CPUZApp({Key? key}) : super(key: key);

  @override
  State<CPUZApp> createState() => _CPUZAppState();
}

class _CPUZAppState extends State<CPUZApp> {
  int index = 0;
  var menu = ['DEVICE', 'SYSTEM', 'BATTERY', 'NETWORK', 'ABOUT'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/cpu_z/cpuZ.jpg',
                height: 40,
              ),
              const SizedBox(
                width: 5,
              ),
              const Text('CPU-Z'),
            ],
          ),
        ),
        body: Container(
          color: const Color(0xFFD9D9D9),
          child: MenuBar(menu: menu),
        ));
  }
}
