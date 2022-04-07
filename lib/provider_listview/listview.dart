import 'package:flutter/foundation.dart';

class SanPham {}

class QLSanPham extends ChangeNotifier {
  late List<SanPham> _list;

  List<SanPham> get list => _list;

  void xoaSP(int index) {
    _list.removeAt(index);
    notifyListeners();
  }

  void capnhatSP(SanPham moi, SanPham spCu) {
    //Cap nhat cac thuoc tinh moi vao cu
    notifyListeners();
  }

  void themMoi(SanPham sp) {
    _list.add(sp);
    notifyListeners();
  }
}
