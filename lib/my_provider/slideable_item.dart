// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'alert_dialog.dart';
import 'function_page.dart';
import 'list_product.dart';

class SlideableItem extends StatelessWidget {
  const SlideableItem({
    Key? key,
    required this.p,
    required this.currentContext,
  }) : super(key: key);
  final Product p;
  final BuildContext currentContext;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 2,
            onPressed: (context) async {
              String choice = await showMyDialog(context);
              if (choice == 'ok') {
                Provider.of<ListProduct>(currentContext, listen: false)
                    .remove(p);
                ScaffoldMessenger.of(currentContext).showSnackBar(
                    const SnackBar(content: Text('Xóa sản phẩm thành công')));
              }
            },
            backgroundColor: const Color.fromARGB(255, 250, 3, 3),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Xóa',
          ),
          SlidableAction(
            flex: 2,
            onPressed: (context) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FunctionPage(
                  titleAppbar: 'Cập nhật sản phẩm',
                  function: 'update',
                  product: p,
                );
              }));
            },
            backgroundColor: const Color.fromARGB(255, 55, 112, 9),
            foregroundColor: Colors.white,
            icon: Icons.save,
            label: 'Sửa',
          ),
          SlidableAction(
            flex: 2,
            onPressed: (context) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FunctionPage(
                  titleAppbar: 'Chi tiết sản phẩm',
                  function: 'see',
                  product: p,
                );
              }));
            },
            backgroundColor: const Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.remove_red_eye_outlined,
            label: 'Xem',
          ),
        ],
      ),
      child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Row(
            children: [
              const Expanded(
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.red,
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.name),
                    Text(p.description),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  p.price.toInt().toString(),
                ),
              ),
            ],
          )),
    );
  }
}
