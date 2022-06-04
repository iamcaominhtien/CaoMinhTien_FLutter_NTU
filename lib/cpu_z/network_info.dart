import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

import 'device_info.dart';

class MyNetworkInfo {
  String? wifiName;
  String? wifiBSSID;
  String? wifiIP;
  String? wifiIPv6;
  String? wifiSubmask;
  String? wifiBroadcast;
  String? wifiGateway;

  MyNetworkInfo(
      {this.wifiName,
      this.wifiBSSID,
      this.wifiIP,
      this.wifiIPv6,
      this.wifiSubmask,
      this.wifiBroadcast,
      this.wifiGateway});

  static Future<MyNetworkInfo> getNetworkIndfo() async {
    final info = NetworkInfo();

    var wifiName = await info.getWifiName();
    var wifiBSSID = await info.getWifiBSSID();
    var wifiIP = await info.getWifiIP();
    var wifiIPv6 = await info.getWifiIPv6();
    var wifiSubmask = await info.getWifiSubmask();
    var wifiBroadcast = await info.getWifiBroadcast();
    var wifiGateway = await info.getWifiGatewayIP();

    return MyNetworkInfo(
        wifiBroadcast: wifiBroadcast,
        wifiBSSID: wifiBSSID,
        wifiGateway: wifiGateway,
        wifiIP: wifiIP,
        wifiIPv6: wifiIPv6,
        wifiName: wifiName,
        wifiSubmask: wifiSubmask);
  }
}

class NetworkInformation extends StatefulWidget {
  const NetworkInformation({Key? key}) : super(key: key);

  @override
  State<NetworkInformation> createState() => _NetworkInformationState();
}

class _NetworkInformationState extends State<NetworkInformation> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyNetworkInfo?>(
      future: MyNetworkInfo.getNetworkIndfo(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Có lỗi xảy ra'),
          );
        }
        if (!snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.only(top: 200),
            child: CircularProgressIndicator(),
          );
        }

        MyNetworkInfo data = snapshot.data!;

        return Expanded(
          child: ListView(
            children: [
              DeviceInfoItem(
                label: 'Wifi name',
                content: data.wifiName ?? "Unknown",
              ),
              DeviceInfoItem(
                label: 'Subnet mask',
                content: data.wifiSubmask ?? "Unknown",
              ),
              DeviceInfoItem(
                label: 'IPv6',
                content: data.wifiIPv6 ?? "Unknown",
              ),
              DeviceInfoItem(
                label: 'IPv4',
                content: data.wifiIP ?? "Unknown",
              ),
              DeviceInfoItem(
                label: 'Default Gateway',
                content: data.wifiGateway ?? "Unknown",
              ),
              DeviceInfoItem(
                label: 'Broadcast',
                content: data.wifiBroadcast ?? "Unknown",
              ),
            ],
          ),
        );
      },
    );
  }
}
