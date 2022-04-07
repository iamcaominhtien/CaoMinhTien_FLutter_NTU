import 'package:flutter/cupertino.dart';

class Product {
  String name, description;
  double price;

  Product({required this.name, required this.description, required this.price});
}

class ManageProducts extends ChangeNotifier {
  final List<Product> _products = [
    Product(name: 'Mít', description: 'Mít Thái loại 1', price: 20000.0),
    Product(
        name: 'Xoài cát Hoài Lộc',
        description: 'Xoài các xuất xứ Long Khánh',
        price: 75000.0),
    Product(
        name: 'Táo muối Bàng La',
        description: 'Đặc sản Hải Phòng',
        price: 50000.0),
    Product(
        name: 'Sầu riêng MI6',
        description: 'Sầu riêng xuất xứ Khánh Sơn',
        price: 80000.0),
    Product(
        name: 'Bưởi da xanh',
        description: 'Bưởi xuất xứ Tiền Giang',
        price: 40000.0),
    Product(
        name: 'Cam Sành',
        description: 'Cam Sành Tiền Giang loại 1',
        price: 250000.0),
    Product(
        name: 'Thanh Long',
        description: 'Thanh Long giải cứu Phan Thiết',
        price: 10000.0),
    Product(
        name: 'Mãng cầu',
        description: 'Mãng cầu xuất xứ Khánh Vĩnh',
        price: 35000.0),
    Product(
        name: 'Ổi Thanh Hà - Hải Dương',
        description: 'Đặc sản của vùng đất Thanh Hà, tỉnh Hải Dương',
        price: 12000.0),
    Product(
        name: 'Bưởi năm roi',
        description: 'Bưởi năm roi Vĩnh Long',
        price: 30000.0),
    Product(
        name: 'Đu đủ đâm',
        description: 'Đu đủ đâm, đặc sản Khmer',
        price: 11000.0),
  ];

  List<Product> get products => _products;

  // void del(int index) {
  //   _products.removeAt(index);
  //   notifyListeners();
  // }

  void del(Product s) {
    _products.removeAt(_products.indexOf(s));
    notifyListeners();
    debugPrint('Product ${s.name} has been deleted');
  }

  void add(Product s) {
    _products.add(s);
    notifyListeners();
  }

  void update(Product oldP, Product newP) {
    int oldIndex = _products.indexOf(oldP);
    _products[oldIndex] = newP;
    notifyListeners();
  }
}
