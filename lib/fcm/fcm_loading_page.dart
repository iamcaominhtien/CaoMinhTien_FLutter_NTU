import 'package:caominhtien_61cntt2/fcm/message_helper.dart';
import 'package:caominhtien_61cntt2/fcm/page_fcm_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FCMLoadingPage extends StatefulWidget {
  const FCMLoadingPage({Key? key}) : super(key: key);

  @override
  State<FCMLoadingPage> createState() => _FCMLoadingPageState();
}

class _FCMLoadingPageState extends State<FCMLoadingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading();
  }

  _loading() async {
    WidgetsFlutterBinding.ensureInitialized();

    //Đăng kí sự kiện nhận tin nhắn ở chế độ background, terminated
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(MessageHelper.fcmBackgroundHandler);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    //Yêu cầu quyền nhận tin nhắn trên thiết bị
    NotificationSettings notificationSettings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );

    debugPrint(
        'User granted permission: ${notificationSettings.authorizationStatus}');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const PageAppFCM(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
