// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:caominhtien_61cntt2/my_provider/list_product.dart';

class FunctionPage extends StatefulWidget {
  final String titleAppbar;
  const FunctionPage({
    Key? key,
    required this.titleAppbar,
    required this.function,
    this.product,
  }) : super(key: key);
  final String function;
  final Product? product;

  @override
  State<FunctionPage> createState() => _FunctionPageState();
}

class _FunctionPageState extends State<FunctionPage> {
  final TextEditingController name = TextEditingController();

  final TextEditingController price = TextEditingController();

  final TextEditingController description = TextEditingController();

  String? labelButoon;

  @override
  Widget build(BuildContext context) {
    if (widget.product != null) {
      name.text = widget.product!.name;
      price.text = widget.product!.price.toString();
      description.text = widget.product!.description;
    }
    if (widget.function == 'add') {
      labelButoon = 'Thêm';
    } else if (widget.function == 'update') {
      labelButoon = 'Cập nhật';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titleAppbar),
      ),
      body: Column(children: [
        MyTextField(
            controller: name,
            labelText: 'Tên sản phẩm',
            readOnly: (widget.function == 'see')),
        MyTextField(
            controller: description,
            labelText: 'Mô tả',
            readOnly: (widget.function == 'see')),
        MyTextField(
            controller: price,
            labelText: 'Đơn giá',
            readOnly: (widget.function == 'see')),
        if (widget.function != 'see')
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Product p = Product(
                        name: name.text,
                        description: description.text,
                        price: double.parse(price.text));
                    // Provider.of<ListProduct>(context, listen: false).add(p);
                    if (widget.function == 'add') {
                      context.read<ListProduct>().add(p);
                    } else {
                      context.read<ListProduct>().update(widget.product!, p);
                    }
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: widget.function == 'add'
                              ? const Text('Thêm sản phẩm thành công')
                              : const Text('Cập nhật sản phẩm thành công'),
                        ),
                      );
                    } else {
                      debugPrint("Can't pop this screen");
                    }
                  },
                  child: Text(labelButoon!),
                ),
              ),
            ],
          )
      ]),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.readOnly,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText, border: const OutlineInputBorder()),
      ),
    );
  }
}
