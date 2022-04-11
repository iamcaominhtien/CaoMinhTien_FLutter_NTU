import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_edited.dart';

class NavigatorPage extends StatelessWidget {
  late final String title;
  late final String type;
  late final BuildContext viewcontext;
  late String titleOfButton;
  Product? product;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();

  // NavigatorPage({Key? key, required this.title}) : super(key: key);
  NavigatorPage(
      {Key? key, required this.type, required this.viewcontext, this.product})
      : super(key: key) {
    if (type == 'new') {
      title = 'Thêm sản phẩm mới';
      titleOfButton = 'Thêm';
    } else {
      price.text = product!.price.toString();
      description.text = product!.description;
      name.text = product!.name;
      if (type == 'see') {
        title = 'Chi tiết sản phẩm';
      } else if (type == 'update') {
        title = 'Cập nhật sản phẩm';
        titleOfButton = 'Cập nhật';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: TextField(
              readOnly: (type == "see"),
              controller: name,
              decoration: const InputDecoration(
                labelText: 'Tên sản phẩm',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: TextField(
              readOnly: (type == "see"),
              controller: description,
              decoration: const InputDecoration(
                labelText: 'Mô tả',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: TextField(
              readOnly: (type == "see"),
              controller: price,
              decoration: const InputDecoration(
                labelText: 'Giá sản phẩm',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          if (type != 'see')
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      if (type == 'update') {
                        Provider.of<ManageProducts>(context, listen: false)
                            .update(
                                product!,
                                Product(
                                    name: name.text,
                                    description: description.text,
                                    price: double.parse(price.text)));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Cập nhật sản phẩm ${name.text} thành công'),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      } else if (type == 'new') {
                        Provider.of<ManageProducts>(context, listen: false).add(
                            Product(
                                name: name.text,
                                description: description.text,
                                price: double.parse(price.text)));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Thêm sản phẩm ${name.text} thành công'),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: Text(titleOfButton),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
