import 'package:caominhtien_61cntt2/fore_cast/thoi_tiet.dart';
import 'package:flutter/cupertino.dart';

import 'thoi_tiet.dart';

class QLThoiTiet extends ChangeNotifier {
  late var qlthoitiet = ThoiTiet(
    nhietdo: 26,
    gio: 3,
    doam: 50,
    mua: 0,
    date: "Sunday, 02 April",
  );
  // get dynamic qlthoitiet=>_qlthoitiet;
  void addThoiTiet(ThoiTiet new_forecast) {
    qlthoitiet = new_forecast;
    notifyListeners();
  }
}
