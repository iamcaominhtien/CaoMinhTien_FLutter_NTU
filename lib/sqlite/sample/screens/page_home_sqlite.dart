// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'package:caominhtien_61cntt2/sqlite/sample/components/alert_dialog.dart';

import 'page_user_detail.dart';
import '../components/provider_data.dart';

class PageListUserSQLite extends StatefulWidget {
  const PageListUserSQLite({
    Key? key,
    required this.popContext,
  }) : super(key: key);
  final BuildContext popContext;

  @override
  State<PageListUserSQLite> createState() => _PageListUserSQLiteState();
}

class _PageListUserSQLiteState extends State<PageListUserSQLite> {
  BuildContext? _currentContext;
  @override
  Widget build(BuildContext context) {
    _currentContext = context;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(widget.popContext);
          },
        ),
        title: const Text('SQLite Demo'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PageSQLiteDetail(
                            see: false,
                          )));
            },
            icon: const Icon(
              Icons.add_circle_outline,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, dbProvider, child) {
          if (dbProvider.users == null || dbProvider.users!.isEmpty) {
            // debugPrint('NULL, ${dbProvider.users!.length}');
            return Center(
              child: Container(
                color: Colors.yellow,
                child: const Text('Chưa có dữ liệu'),
              ),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                var user = dbProvider.users![index];
                return Slidable(
                  key: const ValueKey(0),
                  child: ListTile(
                    leading: Text(
                      user.id.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    title: Text(user.name!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(user.phone!),
                        Text(user.email!),
                      ],
                    ),
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PageSQLiteDetail(
                                        see: true,
                                        user: user,
                                      )));
                        },
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        icon: Icons.remove_red_eye_outlined,
                        label: 'Xem',
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          // Navigator.pushNamed(context, 'update');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PageSQLiteDetail(
                                        see: false,
                                        user: user,
                                      )));
                        },
                        backgroundColor: Colors.yellow,
                        foregroundColor: Colors.white,
                        icon: Icons.save,
                        label: 'Sửa',
                      ),
                      SlidableAction(
                        onPressed: (context) async {
                          String chose = await showAlertDL(context);
                          debugPrint(chose);
                          debugPrint(user.id.toString());
                          if (chose == 'ok') {
                            int count = -1;
                            DatabaseProvider provider =
                                _currentContext!.read<DatabaseProvider>();
                            count = await provider.deleteUser(user.id!);
                            if (count > 0) {
                              showSnackBar(_currentContext!,
                                  'Xóa User ${user.name} thành công');
                            } else {
                              showSnackBar(_currentContext!,
                                  'Xóa User ${user.name} không thành công');
                            }
                          }
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.dangerous,
                        label: 'Xóa',
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                thickness: 2,
              ),
              itemCount: dbProvider.users!.length,
            );
          }
        },
      ),
    );
  }
}
