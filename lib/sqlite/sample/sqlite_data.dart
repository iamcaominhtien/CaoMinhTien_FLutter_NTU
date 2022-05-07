import 'package:sqflite/sqflite.dart';
import 'constants.dart';

class User {
  int? id;
  String? name, phone, email;

  User({this.id, this.name, this.phone, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
      };
}

class DataBaseHelper {
  Database? database;
  String? _path; //Path to database folder

  Future<String?> _getDatabasePath(String databaseName) async {
    String p = await getDatabasesPath();
    String _path = "$p/$databaseName";
    this._path = _path;
    return _path;
  }

  //Open a database, if it hasn't exited, onCreate will be called to create a new one
  Future<Database?> open() async {
    String? _path = await _getDatabasePath('demo.db');
    database = await openDatabase(
      _path!,
      version: 1,
      onCreate: (db, version) async {
        db.execute(
            'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, name TEXT, phone TEXT, email TEXT)');
      },
      //onUpgrade: version: 2
    );
    return database;
  }

  Future<int> insert(User user) async {
    //id: id of the last record of database
    int id = await database!.transaction((txn) async {
      int id = await txn.rawInsert(
          'INSERT INTO $tableName(name, phone, email) VALUES(?,?,?)',
          [user.name, user.phone, user.email]);
      return id;
    });
    return id;
  }

  Future<int> update(User user, int id) async {
    int count = await database!.transaction((txn) async {
      int count = await txn.rawUpdate(
          'UPDATE $tableName SET name = ?, phone = ?, email = ? WHERE id = ?',
          [user.name, user.phone, user.email, id]);
      return count;
    });
    return count;
  }

  Future<int> delete(int id) async {
    int count = await database!.transaction((txn) async {
      int count =
          await txn.rawDelete('DELETE FROM $tableName WHERE id = ?', [id]);
      return count;
    });
    return count;
  }

  Future<List<User>> getUsers() async {
    // var list = await database!.rawQuery('SELECT * FROM $tableName')
    //     as List<Map<String, User>>;
    List<Map> list = await database!.rawQuery('SELECT * FROM $tableName');
    return list
        .map((userJson) => User.fromJson(userJson as Map<String, dynamic>))
        .toList();
  }

  void closeDatabase() async {
    await database!.close();
  }

  void deleteDB() {
    deleteDatabase(_path!);
  }
}
