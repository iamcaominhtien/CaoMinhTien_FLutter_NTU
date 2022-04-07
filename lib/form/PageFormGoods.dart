import 'package:caominhtien_61cntt2/form/listmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageFormGoods extends StatefulWidget {
  const PageFormGoods({Key? key}) : super(key: key);

  @override
  State<PageFormGoods> createState() => _PageFormGoodsState();
}

class _PageFormGoodsState extends State<PageFormGoods> {
  final GlobalKey<FormState> _formstate = GlobalKey<FormState>();

  TextEditingController txtName = TextEditingController();

  TextEditingController txtCount = TextEditingController();

  String? dropdownchose;

  Goods m = Goods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Form Demo"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formstate,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: txtName,
                  validator: (value) => validateString(value),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tên mặt hàng',
                    hintText: 'Hãy nhập tên mặt hàng',
                  ),
                  onSaved: (newValue) {
                    setState(() {
                      m.name = newValue;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  items: listMenuItems,
                  value: dropdownchose,
                  decoration: const InputDecoration(
                    labelText: "Loại mặt hàng",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      dropdownchose = value;
                    });
                    debugPrint(dropdownchose);
                  },
                  onSaved: (newValue) {
                    setState(() {
                      m.type = newValue;
                    });
                  },
                  validator: (value) => validateString(value),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: txtCount,
                  validator: (value) => validateInt(value),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Số lượng',
                    hintText: 'Hãy nhập số lượng',
                  ),
                  onSaved: (newValue) {
                    setState(() {
                      // m.count = newValue as int?;
                      m.count = int.parse(newValue!);
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => save(context),
                      child: const Text("OK"),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  validateString(String? value) {
    if (value == null || value.isEmpty) {
      return "Bạn chưa nhập dữ liệu";
    }
    return null;
  }

  validateInt(String? value) {
    if (value == null || value.isEmpty) {
      return "Bạn chưa nhập dữ liệu";
    }
    if (int.parse(value) < 0) {
      return "Số lượng không được âm";
    }
    return null;
  }

  save(BuildContext context) {
    debugPrint("Save");
    debugPrint("${_formstate.currentState!.validate()}");
    if (_formstate.currentState!.validate()) {
      _formstate.currentState!.save();
      debugPrint("${m.name} - ${m.type} - ${m.count} ");
      popUpDialog(context);
    }
  }

  void popUpDialog(BuildContext context) {
    var dialog = AlertDialog(
      title: const Text('Thông báo'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Bạn đã nhập mặt hàng: '),
          Row(
            children: [
              const Text(
                'Tên mặt hàng: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${m.name}'),
            ],
          ),
          Row(
            children: [
              const Text(
                'Loại mặt hàng: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${m.type}'),
            ],
          ),
          Row(
            children: [
              const Text(
                'Số lượng: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${m.count}'),
            ],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("OK"),
        ),
      ],
    );
    showDialog(context: context, builder: (context) => dialog);
  }
}
