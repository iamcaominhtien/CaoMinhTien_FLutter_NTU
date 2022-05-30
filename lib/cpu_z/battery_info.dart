import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:flutter/material.dart';

import 'device_info.dart';

class BatteryInfo extends StatefulWidget {
  const BatteryInfo({Key? key}) : super(key: key);

  @override
  State<BatteryInfo> createState() => _BatteryInfoState();
}

class _BatteryInfoState extends State<BatteryInfo> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AndroidBatteryInfo?>(
      future: BatteryInfoPlugin().androidBatteryInfo,
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

        AndroidBatteryInfo data = snapshot.data!;
        // for (int i=0;i<data.systemFeatures.length;i++){
        //
        // }

        return Expanded(
          child: ListView(
            children: [
              DeviceInfoItem(
                label: 'Health',
                content: data.health,
              ),
              DeviceInfoItem(
                label: 'Level',
                content: data.batteryLevel.toString() + ' %',
              ),
              DeviceInfoItem(
                label: 'Status',
                content: data.pluggedStatus,
              ),
              DeviceInfoItem(
                label: 'Technology',
                content: data.technology,
              ),
              DeviceInfoItem(
                label: 'Device',
                content: data.temperature.toString() + '°C',
              ),
              DeviceInfoItem(
                label: 'Voltage',
                content: data.voltage.toString() + ' mV',
              ),
              DeviceInfoItem(
                label: 'Capacity',
                content: data.batteryCapacity.toString() + ' mAh',
              ),
            ],
          ),
        );
      },
    );
  }
}
