import 'package:caominhtien_61cntt2/firebase/dialog.dart';
import 'package:caominhtien_61cntt2/firebase/fb_sv_detailed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'fb_data.dart';

class FireBaseHomePage extends StatefulWidget {
  const FireBaseHomePage({Key? key}) : super(key: key);

  @override
  State<FireBaseHomePage> createState() => _FireBaseHomePageState();
}

class _FireBaseHomePageState extends State<FireBaseHomePage> {
  BuildContext? dialogContext;

  void _del(BuildContext context, SinhVienSnapShot svs) async {
    String? confirm = await showConfirmDialog(
        context, 'Bạn có chắc muốn xóa ${svs.sv!.ten} không?');
    if (confirm == 'ok') {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('images').child('${svs.sv!.id}.jpg');
      ref.delete();
      svs
          .del()
          .whenComplete(
              () => showSnackbar(context, 'Xóa dữ liệu thành công', 3))
          .onError((error, stackTrace) {
        showSnackbar(context, 'Xóa dữ liệu không thành công', 3);
        return Future.error('Xóa dữ liệu không thành công');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SVDetail(
                  xem: false,
                ),
              ),
            ),
            icon: const Icon(Icons.add_circle),
          ),
        ],
        title: const Text('Firebase App'),
      ),
      body: StreamBuilder<List<SinhVienSnapShot>>(
          stream: SinhVienSnapShot.listAllSinhVien(),
          builder: (context, snapshot) {
            dialogContext = context;
            if (snapshot.hasError) {
              return const Center(
                child: Text('Lấy dữ liệu bị lỗi'),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text('Loading...'),
              );
            }
            return ListView.separated(
                itemBuilder: (context, index) {
                  return Slidable(
                    child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${snapshot.data![index].sv!.id}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      title: Text('${snapshot.data![index].sv!.ten}'),
                      subtitle: Text('${snapshot.data![index].sv!.lop}'),
                    ),
                    key: const ValueKey(0),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SVDetail(
                                xem: true,
                                svSnapShot: snapshot.data![index],
                              ),
                            ),
                          ),
                          backgroundColor: const Color(0xFF7BC043),
                          foregroundColor: Colors.white,
                          icon: Icons.remove_red_eye,
                          label: 'Xem',
                        ),
                        SlidableAction(
                          onPressed: (context) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SVDetail(
                                xem: false,
                                svSnapShot: snapshot.data![index],
                              ),
                            ),
                          ),
                          backgroundColor: const Color(0xFF0392CF),
                          foregroundColor: Colors.white,
                          icon: Icons.save,
                          label: 'Sửa',
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            // await snapshot.data![index].del();
                            _del(dialogContext!, snapshot.data![index]);
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete_forever,
                          label: 'Xóa',
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                      height: 1,
                    ),
                itemCount: snapshot.data!.length);
          }),
    );
  }
}
