import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class DeviceInfo extends StatefulWidget {
  const DeviceInfo({Key? key}) : super(key: key);

  @override
  State<DeviceInfo> createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
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
          child: ListView(
            children: [
              DeviceInfoItem(
                label: 'Model',
                content: data.model,
              ),
              DeviceInfoItem(
                label: 'Brand',
                content: data.brand,
              ),
              DeviceInfoItem(
                label: 'Board',
                content: data.board,
              ),
              DeviceInfoItem(
                label: 'Hardware',
                content: data.hardware,
              ),
              DeviceInfoItem(
                label: 'Device',
                content: data.device,
              ),
              DeviceInfoItem(
                label: 'Display',
                content: data.display,
              ),
              DeviceInfoItem(
                label: 'Release',
                content: data.version.release,
              ),
              DeviceInfoItem(
                label: 'Code Name',
                content: data.version.codename,
              ),
              DeviceInfoItem(
                label: 'Type',
                content: data.type,
              ),
            ],
          ),
        );
      },
    );
  }
}

class DeviceInfoItem extends StatelessWidget {
  const DeviceInfoItem({
    Key? key,
    this.label,
    this.content,
  }) : super(key: key);
  final String? label;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 100,
                child: Text(
                  label!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Text(
                  content!,
                  style: TextStyle(fontSize: 16, color: Colors.blue[900]),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
