import 'package:caominhtien_61cntt2/manage_cast/sanpham.dart';
import 'package:flutter/cupertino.dart';

class GioHang extends ChangeNotifier {
  final List<SanPhamm> _listSP = [
    SanPhamm(tenSP: 'Cafe G7, Trung Nguyen....', gia: 200.000),
    // SanPhamm(tenSP: 'Cafe G8, Trung Nguyen....', gia: 200.000),
  ];
  List<SanPhamm> get listSP => _listSP;

  void addToCart(SanPhamm s) {
    _listSP.add(s);
    notifyListeners();
  }
}
