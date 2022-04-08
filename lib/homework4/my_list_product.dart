import 'package:caominhtien_61cntt2/homework4/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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

class MyManagerProductPage extends StatelessWidget {
  const MyManagerProductPage({Key? key}) : super(key: key);

  List<Slidable> createListView(BuildContext context) {
    var products = context.watch<ManageProducts>().products;
    var re = products
        .map((e) => Slidable(
              key: const ValueKey(0),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      context.read<ManageProducts>().del(e);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Xóa sản phẩm ${e.name} thành công'),
                          duration: const Duration(
                            seconds: 3,
                          ),
                        ),
                      );
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Xóa',
                  ),
                  const SlidableAction(
                    onPressed: null,
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    icon: Icons.update,
                    label: 'Cập nhật',
                  ),
                  const SlidableAction(
                    onPressed: null,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách sản phẩm'),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
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
