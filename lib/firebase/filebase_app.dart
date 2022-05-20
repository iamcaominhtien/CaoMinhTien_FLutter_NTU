import 'package:caominhtien_61cntt2/firebase/firsebase_homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FireBaseApp extends StatefulWidget {
  const FireBaseApp({Key? key}) : super(key: key);

  @override
  State<FireBaseApp> createState() => _FireBaseAppState();
}

class _FireBaseAppState extends State<FireBaseApp> {
  bool connect = false;
  bool error = false;

  @override
  void initState() {
    super.initState();
    _createFireBase();
  }

  _createFireBase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        connect = true;
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (error) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: Text(
            'Oops! Có lỗi xảy ra',
            textDirection: TextDirection.ltr,
          ),
        ),
      );
    } else if (!connect) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: Text(
            'Đang tải Firebase...',
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      );
    } else {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "My Firebase app",
        home: FireBaseHomePage(),
      );
    }
  }
}
