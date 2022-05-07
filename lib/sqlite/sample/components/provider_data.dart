import 'package:caominhtien_61cntt2/sqlite/sample/components/sqlite_data.dart';
import 'package:flutter/foundation.dart';

///Quan li trang thai database
class DatabaseProvider extends ChangeNotifier {
  DataBaseHelper? dataBaseHelper;
  List<User>? _users;

  DatabaseProvider() {
    dataBaseHelper = DataBaseHelper();
  }

  List<User>? get users => _users;

  ///get all users
  void readUsers() {
    debugPrint('Reading');
    if (users == null) {
      dataBaseHelper!.open().whenComplete(() async {
        _users = await dataBaseHelper!
            .getUsers()
            .whenComplete(() => notifyListeners());
      });
    }
    debugPrint('Finish Reading');
  }

  Future<int> updateUser(User user, int id) async {
    int count = await dataBaseHelper!.update(user, id).whenComplete(() async {
      _users = await dataBaseHelper!
          .getUsers()
          .whenComplete(() => notifyListeners());
    });
    return count;
  }

  Future<int> insertUser(User user) async {
    int? id = await dataBaseHelper!.insert(user).whenComplete(() async {
      _users = await dataBaseHelper!
          .getUsers()
          .whenComplete(() => notifyListeners());
    });
    return id;
  }

  Future<int> deleteUser(int id) async {
    int count = await dataBaseHelper!.delete(id).whenComplete(() async {
      _users = await dataBaseHelper!
          .getUsers()
          .whenComplete(() => notifyListeners());
    });
    return count;
  }

  void closeDb() {
    dataBaseHelper!.closeDatabase();
  }
}
