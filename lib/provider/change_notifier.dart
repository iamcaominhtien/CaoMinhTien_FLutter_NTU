import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Counter extends ChangeNotifier {
  int _value = 0;
  // int get value => _value;
  Future<int> get value async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _value = preferences.getInt('counter') ?? 0;
    return _value;
  }

  void increment() async {
    // _value++;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences
        .setInt('counter', ++_value)
        .whenComplete(() => notifyListeners());
    // notifyListeners();
    debugPrint('Increment');
  }
}
