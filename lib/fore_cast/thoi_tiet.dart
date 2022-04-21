import 'package:flutter/cupertino.dart';

class ThoiTiet {
  late int nhietdo, gio, doam, mua;
  late String
      date; //chỗ này nên dùng DateTime, nhưng cho nhanh thì tui dùng String nhé

  ThoiTiet(
      {required this.date,
      required this.doam,
      required this.gio,
      required this.nhietdo,
      required this.mua});
}
