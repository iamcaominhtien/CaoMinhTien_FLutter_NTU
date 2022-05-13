import 'package:caominhtien_61cntt2/homework6/cpu_z/screens/network.dart';
import 'package:flutter/material.dart';

import 'contact_page.dart';
import 'setting_page.dart';

class CPUReader extends StatefulWidget {
  const CPUReader({Key? key}) : super(key: key);

  @override
  State<CPUReader> createState() => _CPUReaderState();
}

class _CPUReaderState extends State<CPUReader> {
  int index = 0;
  String titleAppbar = "Chọn danh bạ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(titleAppbar),
        ),
        body: buildBody(context),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
              if (index == 0) {
                titleAppbar = "Chọn danh bạ";
              }
              else if (index==1){
                titleAppbar = "Thông tin thiết bị";
              }
              else if (index==2){
                titleAppbar = "Thông tin mạng";
              }
              else{
                titleAppbar = "Bluetooth & Device";
              }
            });
          },
          items: const [
            //index = 0
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_box,
                  color: Colors.blue,
                ),
                label: "Contact"),
            //index = 1
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
                label: "Settings"),
            //index = 2
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.wifi,
                  color: Colors.green,
                ),
                label: "Network"),
            //index = 3
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.bluetooth,
                  color: Colors.green,
                ),
                label: "Device"),
          ],
        ));
  }

  Widget buildContact(BuildContext context) {
    return const ContactePage();
  }

  Widget buildSettings(BuildContext context) {
    return const SettingPage();
  }

  Widget buildNetwork(BuildContext context) {
    return const NetworkPage();
  }

  Widget buildBody(BuildContext context) {
    if (index == 0) {
      return buildContact(context);
    }
    if (index == 1) {
      return buildSettings(context);
    }
    if (index == 2) {
      return buildNetwork(context);
    }
    return buildDevice(context);
  }

  Widget buildDevice(BuildContext context) {
    return const Center(
      child: Text(
        "Divice",
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}
