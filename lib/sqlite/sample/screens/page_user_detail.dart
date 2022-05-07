import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/provider_data.dart';
import '../components/sqlite_data.dart';

class PageSQLiteDetail extends StatefulWidget {
  final bool? see;
  final User? user;
  const PageSQLiteDetail({Key? key, required this.see, this.user})
      : super(key: key);

  @override
  State<PageSQLiteDetail> createState() => _PageSQLiteDetailState();
}

class _PageSQLiteDetailState extends State<PageSQLiteDetail> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  late DatabaseProvider provider;
  late String labelButton;

  @override
  void initState() {
    super.initState();
    // widget.see ?? false;
    if (widget.user == null) {
      labelButton = 'Thêm';
    } else {
      labelButton = 'Cập nhật';
      txtEmail.text = widget.user!.email!;
      txtName.text = widget.user!.name!;
      txtPhone.text = widget.user!.phone!;
    }
    provider = Provider.of<DatabaseProvider>(context, listen: false);
    provider.readUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin user'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              readOnly: widget.see!,
              controller: txtName,
              decoration: const InputDecoration(
                labelText: 'Tên user',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              readOnly: widget.see!,
              controller: txtPhone,
              decoration: const InputDecoration(
                labelText: 'Số điện thoại',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              readOnly: widget.see!,
              controller: txtEmail,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.see != true)
                  ElevatedButton(
                    onPressed: () => addorUpdate(),
                    child: Text(labelButton),
                  ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Đóng'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void addorUpdate() async {
    User newUser =
        User(email: txtEmail.text, name: txtName.text, phone: txtPhone.text);
    if (widget.user == null) {
      int id = -1;
      id = await provider.insertUser(newUser);
      debugPrint(id.toString());
      debugPrint(newUser.id.toString());
      if (id > 0) {
        showSnackBar(context, 'Thêm User ${newUser.name} thành công');
      } else {
        showSnackBar(context, 'Thêm User ${newUser.name} không thành công');
      }
    } else {
      int count = -1;
      count = await provider.updateUser(newUser, widget.user!.id!);
      debugPrint(widget.user!.id!.toString());
      if (count > 0) {
        showSnackBar(context, 'Cập nhật User ${newUser.name} thành công');
      } else {
        showSnackBar(context, 'Cập nhật User ${newUser.name} không thành công');
      }
    }
  }
}

void showSnackBar(BuildContext context, String messenger) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(messenger),
    ),
  );
}
