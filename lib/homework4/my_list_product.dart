import 'package:caominhtien_61cntt2/homework4/dialog.dart';
import 'package:caominhtien_61cntt2/homework4/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'product_function.dart';

class MyListProduct extends StatelessWidget {
  const MyListProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ManageProducts(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyManagerProductPage(),
      ),
    );
  }
}

class MyManagerProductPage extends StatefulWidget {
  const MyManagerProductPage({Key? key}) : super(key: key);

  @override
  State<MyManagerProductPage> createState() => _MyManagerProductPageState();
}

class _MyManagerProductPageState extends State<MyManagerProductPage> {
  late BuildContext listViewContext;
  dynamic productFunc;
  late BuildContext viewContext;

  List<Widget> createListView(BuildContext context) {
    listViewContext = context;
    var products = context.watch<ManageProducts>().products;
    var re = products
        .map((e) => Slidable(
              key: const ValueKey(0),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) async {
                      var confirm = await showConfirmDialog(listViewContext,
                          'Bạn có chắc muốn xóa sản phẩm ${e.name} không?');
                      // debugPrint(confirm);
                      if (confirm == 'ok') {
                        listViewContext.read<ManageProducts>().del(e);
                        ScaffoldMessenger.of(listViewContext).showSnackBar(
                          SnackBar(
                            content: Text('Xóa sản phẩm ${e.name} thành công'),
                            duration: const Duration(
                              seconds: 3,
                            ),
                          ),
                        );
                      }
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Xóa',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      productFunc = FunctionProduct('update', e);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Scaffold(
                              appBar: AppBar(title: Text(productFunc.title())),
                              body: productFunc.show(context),
                            );
                          },
                        ),
                      );
                    },
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    icon: Icons.update,
                    label: 'Cập nhật',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      productFunc = FunctionProduct('see', e);
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) {
                            return Scaffold(
                              appBar: AppBar(
                                title: Text(productFunc.title()),
                              ),
                              body: productFunc.show(context),
                            );
                          },
                        ),
                      );
                    },
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.remove_red_eye_outlined,
                    label: 'Xem',
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.blue,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.name,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            e.description,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${e.price}',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();
    return re;
  }

  @override
  Widget build(BuildContext context) {
    // listViewContext = context;
    viewContext = context;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách sản phẩm'),
        actions: [
          IconButton(
            onPressed: () {
              productFunc = FunctionProduct('new');
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(productFunc.title()),
                      ),
                      body: productFunc.show(context),
                    );
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.add_circle,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: createListView(context),
        ).toList(),
      ),
    );
  }
}
