import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({Key? key}) : super(key: key);

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  Future<Map<String, dynamic>>? networkInfo;

  @override
  void initState() {
    super.initState();
    networkInfo = getNetworkInfo();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: networkInfo,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("ERROR"),
            );
          } else {
            var data = snapshot.data;

            // debugPrint(data.toString());
            return SingleChildScrollView(
              child: Padding(
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
                                maxLines: 10,
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
              ),
            );
          }
        });
  }

  Future<Map<String, dynamic>> getNetworkInfo() async {
    final info = NetworkInfo();

    return {
      'wifiName': await info.getWifiName(),
      'wifiBSSID': await info.getWifiBSSID(),
      'wifiIP': await info.getWifiIP(),
      'wifiIPv6': await info.getWifiIPv6(),
      'wifiSubmask': await info.getWifiSubmask(),
      'wifiBroadcast': await info.getWifiBroadcast(),
      'wifiGateway': await info.getWifiGatewayIP(),
    };
  }
}
