// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'function_page.dart';
import 'list_product.dart';
import 'slideable_item.dart';

late BuildContext currentContext;

class ManageProductApp extends StatelessWidget {
  const ManageProductApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return ChangeNotifierProvider(
      create: (context) => ListProduct(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ManageProductAppPage(),
      ),
    );
  }
}

class ManageProductAppPage extends StatefulWidget {
  const ManageProductAppPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ManageProductAppPage> createState() => _ManageProductAppPageState();
}

class _ManageProductAppPageState extends State<ManageProductAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (Navigator.canPop(currentContext)) {
                Navigator.pop(currentContext);
              } else {
                debugPrint(Navigator.canPop(currentContext).toString());
              }
            },
          ),
          title: const Text('Danh sách sản phẩm'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FunctionPage(
                        titleAppbar: 'Thêm sản phẩm mới',
                        function: 'add',
                      ),
                    ));
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Consumer<ListProduct>(
          builder: (context, listProduct, child) {
            return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return SlideableItem(
                    p: listProduct.list[index],
                    currentContext: context,
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                      thickness: 1,
                      height: 1,
                    ),
                itemCount: listProduct.list.length);
          },
        ));
  }
}
