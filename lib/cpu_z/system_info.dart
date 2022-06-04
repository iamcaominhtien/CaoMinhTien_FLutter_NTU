import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class SystemInfo extends StatefulWidget {
  const SystemInfo({Key? key}) : super(key: key);

  @override
  State<SystemInfo> createState() => _SystemInfoState();
}

class _SystemInfoState extends State<SystemInfo> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AndroidDeviceInfo>(
      future: DeviceInfoPlugin().androidInfo,
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

        AndroidDeviceInfo data = snapshot.data!;
        // for (int i=0;i<data.systemFeatures.length;i++){
        //
        // }
        for (var element in data.supported32BitAbis) {
          debugPrint(element);
        }
        return Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      data.systemFeatures[index] ?? "Unknown",
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const Divider(thickness: 1, height: 1),
                itemCount: data.systemFeatures.length));
      },
    );
  }
}
