import 'package:flutter/material.dart';

List<String> typeGoods = ['Điện thoại', 'Máy tính bảng', 'Laptop', 'PC'];
var listMenuItems = typeGoods
    .map(
      (e) => DropdownMenuItem<String>(
        child: Text(
          e.toString(),
        ),
        value: e,
      ),
    )
    .toList();

class Goods {
  String? name, type;
  int? count;

  Goods({this.name, this.type, this.count});
}
