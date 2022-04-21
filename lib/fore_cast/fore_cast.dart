import 'package:caominhtien_61cntt2/fore_cast/change_notifier_forecast.dart';
import 'package:caominhtien_61cntt2/fore_cast/thoi_tiet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ForeCast extends StatefulWidget {
  const ForeCast({Key? key}) : super(key: key);

  @override
  State<ForeCast> createState() => _ForeCastState();
}

class _ForeCastState extends State<ForeCast> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QLThoiTiet(),
      child: const MaterialApp(
        home: MyForeCastPage(),
      ),
    );
  }
}

class MyForeCastPage extends StatefulWidget {
  const MyForeCastPage({Key? key}) : super(key: key);

  @override
  State<MyForeCastPage> createState() => _MyForeCastPageState();
}

class _MyForeCastPageState extends State<MyForeCastPage> {
  TextEditingController nhietdo = TextEditingController();
  TextEditingController gio = TextEditingController();
  TextEditingController doam = TextEditingController();
  TextEditingController mua = TextEditingController();
  TextEditingController ngay = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<QLThoiTiet>(
      builder: (context, myforecast, child) {
        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Cái này tui nghĩ là dùng Image, nhưng lười tìm quá nên xài tạm Icon
              const Icon(
                Icons.wb_sunny,
                size: 140.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  '${myforecast.qlthoitiet.nhietdo}',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Clear',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Text('${myforecast.qlthoitiet.date}'),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Icon(Icons.wb_sunny),
                          Text('${myforecast.qlthoitiet.gio}km/h'),
                          const Text('Wind'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Icon(Icons.wb_sunny),
                          Text('${myforecast.qlthoitiet.doam}%'),
                          const Text('Humidity'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Icon(Icons.wb_sunny),
                          Text('${myforecast.qlthoitiet.mua}%'),
                          const Text('Rain'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Scaffold(
                            appBar: AppBar(
                              title: Text("Thêm thông tin thời tiết"),
                            ),
                            body: Column(
                              children: [
                                TextField(
                                  controller: nhietdo,
                                  decoration:
                                      InputDecoration(labelText: "Nhiệt độ"),
                                ),
                                TextField(
                                  controller: gio,
                                  decoration:
                                      InputDecoration(labelText: "Tốc độ gió"),
                                ),
                                TextField(
                                  controller: doam,
                                  decoration:
                                      InputDecoration(labelText: "Độ ẩm"),
                                ),
                                TextField(
                                  controller: mua,
                                  decoration: InputDecoration(
                                      labelText: "Khả năng mưa"),
                                ),
                                TextField(
                                  controller: ngay,
                                  decoration:
                                      InputDecoration(labelText: "Ngày"),
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          ThoiTiet new_forecast = ThoiTiet(
                                            date: ngay.text,
                                            gio: int.parse(gio.text),
                                            doam: int.parse(doam.text),
                                            nhietdo: int.parse(nhietdo.text),
                                            mua: int.parse(mua.text),
                                          );
                                          Provider.of<QLThoiTiet>(context,
                                                  listen: false)
                                              .addThoiTiet(new_forecast);
                                          Navigator.pop(context);
                                        },
                                        child: Text("Thêm")),
                                  ],
                                )
                              ],
                            ),
                          );
                        }));
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    ));
  }
}
