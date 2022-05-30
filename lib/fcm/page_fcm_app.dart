import 'package:caominhtien_61cntt2/fcm/page_home_fcm.dart';
import 'package:caominhtien_61cntt2/fcm/widget_connect_firebase.dart';
import 'package:flutter/material.dart';

class PageAppFCM extends StatefulWidget {
  const PageAppFCM({Key? key}) : super(key: key);

  @override
  State<PageAppFCM> createState() => _PageAppFCMState();
}

class _PageAppFCMState extends State<PageAppFCM> {
  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
      builder: (context) {
        return MaterialApp(
          title: 'FCM Demo',
          debugShowCheckedModeBanner: false,
          home: PageHomeFCM(mainContext: context),
        );
      },
      errorMessage: 'Lỗi kết nối',
      connectingMessage: 'Đang kết nối',
    );
  }
}
