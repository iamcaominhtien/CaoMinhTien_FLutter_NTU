import 'package:caominhtien_61cntt2/homework4/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FunctionProduct {
  late String _type;
  late Product _s;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();

  FunctionProduct(String type, [Product? s]) {
    _type = type;
    if (s != null) {
      _s = s;
    }
  }

  String title() {
    if (_type == 'new') {
      return 'Thêm mới sản phẩm';
    }
    // _s = p!;
    if (_type == 'update') {
      return "Cập nhật sản phẩm";
    }
    return "Chi tiết sản phẩm";
  }

  void runFunction(BuildContext context) {
    if (_type == 'new') {
      debugPrint('${name.text} ${description.text} ${price.text}');
      context.read<ManageProducts>().add(Product(
            name: name.text,
            description: description.text,
            price: double.parse(price.text),
          ));
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Thêm sản phẩm ${name.text} thành công'),
          duration: const Duration(
            seconds: 3,
          ),
        ),
      );
    } else if (_type == 'update') {
      debugPrint('${name.text} ${description.text} ${price.text}');
      context.read<ManageProducts>().update(
          _s,
          Product(
            name: name.text,
            description: description.text,
            price: double.parse(price.text),
          ));
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cập nhật sản phẩm ${name.text} thành công'),
          duration: const Duration(
            seconds: 3,
          ),
        ),
      );
    }
  }

  Widget show(BuildContext context) {
    if (_type != 'new') {
      name.text = _s.name;
      price.text = _s.price.toString();
      description.text = _s.description;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 10,
      ),
      child: Column(
        children: [
          TextField(
            readOnly: (_type == "see"),
            controller: name,
            decoration: const InputDecoration(
                labelText: "Tên mặt hàng", border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            readOnly: (_type == "see"),
            controller: description,
            decoration: const InputDecoration(
                labelText: "Mô tả", border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            readOnly: (_type == "see"),
            controller: price,
            decoration: const InputDecoration(
                labelText: "Đơn giá", border: OutlineInputBorder()),
          ),
          if (_type != "see")
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () => runFunction(context),
                  child: Text((_type == 'new') ? "Thêm" : "Cập nhật"),
                ),
              ],
            )
        ],
      ),
    );
  }
}
