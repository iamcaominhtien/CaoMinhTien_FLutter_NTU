import 'package:caominhtien_61cntt2/firebase/dialog.dart';
import 'package:caominhtien_61cntt2/login_page/firebasee_app/data.dart';
import 'package:caominhtien_61cntt2/login_page/firebasee_app/sv_detailed.dart';
import 'package:caominhtien_61cntt2/login_page/login_fcm_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PageSinhVien extends StatefulWidget {
  const PageSinhVien({Key? key}) : super(key: key);

  @override
  State<PageSinhVien> createState() => _PageSinhVienState();
}

class _PageSinhVienState extends State<PageSinhVien> {
  late BuildContext dialogContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              const Text('My Firebase App'),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xFF2196F3),
                    ),
                  ),
                  onPressed: () {
                    showSnackbar(context, 'Signing out...', 600);
                    FirebaseAuth.instance.signOut().whenComplete(() {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LoginPageFCM(),
                          ),
                          (route) => false);
                      showSnackbar(context, 'Please sign in', 3);
                    }).catchError((e) {
                      showSnackbar(context, 'Signing out not successfully', 3);
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      Text(
                        ' Sign out',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('My FirebaseApp'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SinhVienDetailed(
                  xem: false,
                ),
              ),
            ),
            icon: const Icon(Icons.add_circle),
          ),
        ],
      ),
      body: StreamBuilder<List<SinhVienSnapShot>>(
        stream: SinhVienSnapShot.listAllSinhVien(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Có lỗi xảy ra'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          List<SinhVienSnapShot> data = snapshot.data!;
          debugPrint("has data: ${data.length}");
          return ListView.separated(
              itemBuilder: (context, index) {
                dialogContext = context;
                return Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SinhVienDetailed(
                              xem: true,
                              svSnapShot: data[index],
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
                            builder: (context) => SinhVienDetailed(
                              xem: false,
                              svSnapShot: data[index],
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
                          _del(dialogContext, data[index]);
                        },
                        // onPressed: null,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete_forever,
                        label: 'Xóa',
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data[index].sv?.id ?? "?",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    title: Text(data[index].sv?.ten ?? "Unknown"),
                    subtitle: Text(data[index].sv?.lop ?? "Unknown"),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, thickness: 1),
              itemCount: data.length);
        },
      ),
    );
  }

  Future<void> _del(BuildContext context, SinhVienSnapShot svs) async {
    String? confirm = await showConfirmDialog(
        context, 'Bạn có chắc muốn xóa ${svs.sv!.ten} không?');
    if (confirm == 'ok') {
      FirebaseStorage storage = FirebaseStorage.instance;
      if (svs.sv!.anh != null) {
        Reference ref =
            storage.ref().child('images').child('anh_${svs.sv!.id}.jpg');
        await ref.delete();
      }

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
}
