import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Future<Map<String, dynamic>>? androidDeviceInfo;

  @override
  void initState() {
    super.initState();
    androidDeviceInfo = getAndroidDeviceInfor();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: androidDeviceInfo,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("ERROR"),
            );
          } else {
            var data = snapshot.data;

            // debugPrint(data.toString());
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: data.keys.map<Widget>(
                  (String property) {
                    return Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            property,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                          child: Expanded(
                            child: Text(
                              '${data[property]}',
                              maxLines: 50,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )),
                        // const Divider(height: 8,),
                      ],
                    );
                  },
                ).toList(),
              ),
            );
          }
        });
  }

  Future<Map<String, dynamic>> getAndroidDeviceInfor() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidBatteryInfo? androidBatteryInfo =
        await BatteryInfoPlugin().androidBatteryInfo;
    AndroidDeviceInfo deviceInfoData = await deviceInfo.androidInfo;
    return {
      "manufacturer": deviceInfoData.manufacturer,
      'display': deviceInfoData.display,
      'hardware': deviceInfoData.hardware,
      'android.version': deviceInfoData.version,
      'system.features': deviceInfoData.systemFeatures,
      'battery.capacity':
          androidBatteryInfo?.batteryCapacity?.toString() ?? "No info",
      'battery.health': androidBatteryInfo?.health ?? "No info",
      'battery.temperature':
          androidBatteryInfo?.temperature?.toString() ?? "No info"
    };
  }
}
