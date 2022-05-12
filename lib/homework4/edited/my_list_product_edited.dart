import 'navigator_page.dart';
import 'product_edited.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'alert_dialog.dart';

// ignore: camel_case_types
class MyListProduct_Edited extends StatelessWidget {
  const MyListProduct_Edited({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ManageProducts(),
      child: const MyManagerProductPage(),
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

  @override
  Widget build(BuildContext context) {
    listViewContext = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách sản phẩm"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute<void>(builder: (context) {
                return NavigatorPage(
                  type: "new",
                  viewcontext: context,
                );
              }));
            },
            icon: const Icon(Icons.add_circle, color: Colors.white),
          )
        ],
      ),
      body: Consumer<ManageProducts>(builder: (context, listproduct, child) {
        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return Slidable(
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Icon(Icons.shopping_cart, color: Colors.blue),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(listproduct.products[index].name),
                            Text(listproduct.products[index].description),
                          ],
                        ),
                      ),
                      Text(listproduct.products[index].price.toString()),
                    ],
                  ),
                ),
              ),
              key: const ValueKey(0),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) async {
                      var confirm = await showConfirmDialog(listViewContext);
                      // debugPrint(confirm);
                      if (confirm == 'ok') {
                        String nameProduct = listproduct.products[index].name;
                        listViewContext
                            .read<ManageProducts>()
                            .del(listproduct.products[index]);
                        ScaffoldMessenger.of(listViewContext).showSnackBar(
                          SnackBar(
                            content:
                                Text('Xóa sản phẩm $nameProduct thành công'),
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
                    onPressed: (context) => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return NavigatorPage(
                          type: 'update',
                          viewcontext: context,
                          product: listproduct.products[index]);
                    })),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    icon: Icons.update,
                    label: 'Cập nhật',
                  ),
                  SlidableAction(
                    onPressed: (context) => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return NavigatorPage(
                          type: 'see',
                          viewcontext: context,
                          product: listproduct.products[index]);
                    })),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.remove_red_eye_outlined,
                    label: 'Xem',
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            thickness: 1,
            height: 1,
          ),
          itemCount: listproduct.products.length,
        );
      }),
    );
  }
}
