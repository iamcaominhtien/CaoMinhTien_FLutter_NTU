import 'package:caominhtien_61cntt2/homework5/screen/vnexpress_app.dart';
import 'package:caominhtien_61cntt2/json/list_json_photo_app.dart';
import 'package:caominhtien_61cntt2/my_provider/manage_product_app.dart';
import 'package:caominhtien_61cntt2/sqlite/sample/sqlite_app.dart';
import 'homework4/edited/my_list_product_edited.dart';
import 'manage_cast/manage_cast_app.dart';
import 'photoAlbum.dart';
import 'provider/my_app.dart';
import 'package:flutter/material.dart';
import 'form/PageFormGoods.dart';
import 'gridView/grid_view.dart';
import 'my_image.dart';
import 'my_input.dart';
import 'my_stateFull.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This weather is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHome(),
        '/form': (context) => const PageFormGoods(),
        '/grid_view': (context) => const GridViewPage(),
        '/manage_cast_app': (context) => const ManageCastApp(),
        '/my_counter_app': (context) => const MyCounterApp(),
        '/my_img': (context) => const MyImage(),
        '/my_photo_album': (context) => const MyPhotoAlbum(),
        '/my_stateful': (context) => const MyStateFullWidget(),
        '/my_input_page': (context) => const MyInputPage(),
        '/my_list_product': (context) => const MyListProduct_Edited(),
        '/manage_product_app': (context) => const ManageProductApp(),
        '/json_photo': (context) => const MyJsonPhoto(),
        '/vnexpress': (context) => const VNExpressApp(),
        '/sqlite_demo': (context) => const SQLiteApp(),
      },
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello 61.CNTT2'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            ButtonForwarding(
              labelButton: 'SQLite App Demo',
              nameNavigator: '/sqlite_demo',
            ),
            ButtonForwarding(
              labelButton: 'VNExpress App',
              nameNavigator: '/vnexpress',
            ),
            ButtonForwarding(
              labelButton: 'Json Photo',
              nameNavigator: '/json_photo',
            ),
            ButtonForwarding(
              labelButton: 'Form',
              nameNavigator: '/form',
            ),
            ButtonForwarding(
              labelButton: 'Grid View',
              nameNavigator: '/grid_view',
            ),
            ButtonForwarding(
                labelButton: 'Quản lí giỏ hàng',
                nameNavigator: '/manage_cast_app'),
            ButtonForwarding(
                labelButton: 'My Counter App',
                nameNavigator: '/my_counter_app'),
            ButtonForwarding(
              labelButton: 'Album ảnh',
              nameNavigator: '/my_photo_album',
            ),
            ButtonForwarding(
              labelButton: 'Stateful Widget',
              nameNavigator: '/my_stateful',
            ),
            ButtonForwarding(
              labelButton: 'My Input Page',
              nameNavigator: '/my_input_page',
            ),
            ButtonForwarding(
              labelButton: 'My Image',
              nameNavigator: '/my_img',
            ),
            ButtonForwarding(
              labelButton: 'My List Product',
              nameNavigator: '/my_list_product',
            ),
            ButtonForwarding(
              labelButton: 'Manage Product App',
              nameNavigator: '/manage_product_app',
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonForwarding extends StatelessWidget {
  final String labelButton;
  final String nameNavigator;

  const ButtonForwarding(
      {Key? key, required this.labelButton, required this.nameNavigator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ElevatedButton(
          child: Text(labelButton),
          onPressed: () {
            Navigator.pushNamed(context, nameNavigator);
          },
        ),
      ),
    );
  }
}
