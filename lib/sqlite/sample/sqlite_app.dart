import 'package:caominhtien_61cntt2/sqlite/sample/provider_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'page_user_detail.dart';
import 'page_home_sqlite.dart';

class SQLiteApp extends StatefulWidget {
  const SQLiteApp({Key? key}) : super(key: key);

  @override
  State<SQLiteApp> createState() => _SQLiteAppState();
}

class _SQLiteAppState extends State<SQLiteApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        var databaseProvider = DatabaseProvider();
        databaseProvider.readUsers();
        debugPrint('Out readUsers');
        return databaseProvider;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SQLite Demo App',
        home: PageListUserSQLite(
          popContext: context,
        ),
      ),
    );
  }
}
