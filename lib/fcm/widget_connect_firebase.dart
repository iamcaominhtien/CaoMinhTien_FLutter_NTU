import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

///Khởi tạo firebase

class MyFirebaseConnect extends StatefulWidget {
  const MyFirebaseConnect(
      {Key? key,
      required this.builder,
      required this.errorMessage,
      required this.connectingMessage})
      : super(key: key);
  final Widget Function(BuildContext context) builder;
  final String? errorMessage;
  final String? connectingMessage;

  @override
  State<MyFirebaseConnect> createState() => _MyFirebaseConnectState();
}

class _MyFirebaseConnectState extends State<MyFirebaseConnect> {
  bool connect = false;
  bool error = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createFirebase();
  }

  @override
  Widget build(BuildContext context) {
    if (error) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(
            widget.errorMessage!,
            textDirection: TextDirection.ltr,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      );
    }
    if (!connect) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(
            widget.connectingMessage!,
            textDirection: TextDirection.ltr,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      );
    }
    return widget.builder(context);
  }

  _createFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        connect = true;
      });
    } catch (e) {
      setState(() {
        error = true;
      });
    }
  }
}
