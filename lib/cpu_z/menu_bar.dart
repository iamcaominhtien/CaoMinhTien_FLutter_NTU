import 'package:caominhtien_61cntt2/cpu_z/battery_info.dart';
import 'package:caominhtien_61cntt2/cpu_z/device_info.dart';
import 'package:caominhtien_61cntt2/cpu_z/network_info.dart';
import 'package:flutter/material.dart';

import 'about_info.dart';
import 'system_info.dart';

class MenuBar extends StatefulWidget {
  const MenuBar({
    Key? key,
    required this.menu,
  }) : super(key: key);

  final List<String> menu;

  @override
  State<MenuBar> createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  Widget bodyContent = const DeviceInfo();
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.black,
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.menu.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Container(
                      //   color: Colors.transparent,
                      //   width: 0.0,
                      // ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 0.0,
                                    color: Colors.white,
                                    style: BorderStyle.none),
                                borderRadius: BorderRadius.zero),
                          ),
                        ),
                        onPressed: () => whatFunction(index),
                        child: Text(
                          widget.menu[index],
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                      //   child: Container(
                      //     color: Colors.white,
                      //     width: 2,
                      //   ),
                      // ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Container(
                    height: 5,
                    width: 80,
                    color: selected == index ? Colors.blue : Colors.black,
                  )
                ],
              );
            },
          ),
        ),
        bodyContent,
      ],
    );
  }

  void whatFunction(int index) {
    debugPrint('Click');
    setState(() {
      selected = index;
      switch (index) {
        case 0:
          bodyContent = const DeviceInfo();
          break;
        case 1:
          bodyContent = const SystemInfo();
          break;
        case 2:
          bodyContent = const BatteryInfo();
          break;
        case 3:
          bodyContent = const NetworkInformation();
          break;
        default:
          bodyContent = const AboutInfo();
          break;
      }
    });
  }
}
