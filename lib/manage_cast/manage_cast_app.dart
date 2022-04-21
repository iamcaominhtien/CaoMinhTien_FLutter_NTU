import 'package:caominhtien_61cntt2/manage_cast/gio_hang.dart';
import 'package:caominhtien_61cntt2/manage_cast/sanpham.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageCastApp extends StatefulWidget {
  const ManageCastApp({Key? key}) : super(key: key);

  @override
  State<ManageCastApp> createState() => _ManageCastAppState();
}

class _ManageCastAppState extends State<ManageCastApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GioHang(),
      child: const MaterialApp(
        home: MyCartPage(),
      ),
    );
  }
}

class MyCartPage extends StatefulWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  TextEditingController tenSP = TextEditingController();
  TextEditingController gia = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GioHang>(
        builder: (context, listSP, child) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Icon(Icons.wb_sunny_outlined, size: 140),
                ), //Tui lười kiếm ảnh nên xài Icon tạm nhé
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(listSP.listSP[index].tenSP),
                          const SizedBox(
                            height: 30,
                          ),
                          Text('Giá: ${listSP.listSP[index].gia}đ/0.5kg'),
                          const Text('Free ship nếu mua 2kg'),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.star, color: Colors.yellow),
                                  Icon(Icons.star, color: Colors.yellow),
                                  Icon(Icons.star, color: Colors.yellow),
                                  Icon(Icons.star, color: Colors.yellow),
                                  Icon(Icons.star),
                                  Text('4.5'),
                                ],
                              ),
                              const Text('155 đánh giá'),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: listSP.listSP.length,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Scaffold(
                            appBar: AppBar(
                              title: const Text('Thêm sản phẩm mới'),
                            ),
                            body: Column(
                              children: [
                                TextField(
                                  controller: tenSP,
                                  decoration: const InputDecoration(
                                    labelText: 'Tên Sản phẩm',
                                  ),
                                ),
                                TextField(
                                  controller: gia,
                                  decoration: const InputDecoration(
                                    labelText: 'Đơn giá',
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    var SPmoi = SanPhamm(
                                        tenSP: tenSP.text,
                                        gia: double.parse(gia.text));
                                    Provider.of<GioHang>(context, listen: false)
                                        .addToCart(SPmoi);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Thêm'),
                                )
                              ],
                            ),
                          );
                        }));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.shopping_cart),
                          Text('Add to Cart'),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
