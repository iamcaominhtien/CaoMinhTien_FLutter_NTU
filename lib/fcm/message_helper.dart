import 'dart:convert';
import 'package:caominhtien_61cntt2/fcm/message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MessageHelper {
  static String keyMessageList = 'fcm_messages';
  static String keyCountMessage = 'count_messages';

  ///Lấy ra số lượng tin nhắn đã ghi
  static Future<int> getCountMessages() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(keyCountMessage) ?? 0;
  }

  ///Ghi lại tin nhắn đã nhận được khi ở chế độ nền
  static Future<bool> writeMessage(
      MyNotificationMessage myNotificationMessage) async {
    //Để write gọi phương thức sharedPreferences.setStringList, nhưng nếu trong trường hợp đã có sẵn mess list
    //rồi, thì cần gọi list này ra, thêm tin nhắn mới vào, cập nhật lại thông báo trên icon cài đặt ứng dụng

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? listMess = sharedPreferences.getStringList(keyMessageList);
    int countMess = (sharedPreferences.getInt(keyCountMessage) ?? 0) + 1;
    FlutterAppBadger.updateBadgeCount(countMess);
    await sharedPreferences.setInt(keyCountMessage, countMess);

    if (listMess == null) {
      return await sharedPreferences
          .setStringList(keyMessageList, [jsonEncode(myNotificationMessage)]);
    } else {
      listMess.add(jsonEncode(myNotificationMessage));
      return await sharedPreferences.setStringList(keyMessageList, listMess);
    }
  }

  ///Phương thức dùng để đọc thông báo đã lưu
  static Future<List<MyNotificationMessage>?> readMessage() async {
    //Muốn đọc thông báo thì dùng sharedPreferences.getStringList, đọc xong thì xóa mấy cái key đi
    //đồng thời xóa luôn cả số lượng tin nhắn hiển thị trên icon cài đặt ứng dụng

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? listMess = sharedPreferences.getStringList(keyMessageList);
    FlutterAppBadger.removeBadge();
    sharedPreferences.remove(keyCountMessage);
    sharedPreferences.remove(keyMessageList);

    return listMess
        ?.map((e) => MyNotificationMessage.fromJson(
            jsonDecode(e) as Map<String, dynamic>))
        .toList();
  }

  ///Phương thức xử lí chạy nền
  static Future<void> fcmBackgroundHandler(RemoteMessage message) async {
    //Theo mặc định, tin nhắn được nhận ở thanh trạng thái của thiết bị nếu nhận ở chế độ nền
    //Code xử lí tin nhắn.....
    debugPrint('Handling a background message ${message.messageId}');
  }

  ///Phương thức nhận tin nhắn ở chế độ foreground
  static void fcmForegroundHandler(
      {required RemoteMessage message,
      required BuildContext context,
      void Function(BuildContext context, RemoteMessage message)?
          messageHandler}) {
    //Message được gửi từ FCM xuống, truyền qua biến message. Nhận được thông báo rồi thì lưu lại

    writeMessage(MyNotificationMessage(
            time: message.sentTime.toString(),
            from: message.from,
            body: message.notification!.body,
            title: message.notification!.title))
        .whenComplete(() {
      if (messageHandler != null) {
        //???????????
        messageHandler(context, message);
      }
    });

    debugPrint('Message write in foreground');
  }

  ///Phương thức mở tin nhắn
  static void fcmOpenMessageHandler(
      {required BuildContext context,
      required RemoteMessage message,
      Function(BuildContext context, RemoteMessage message)? messageHandler}) {
    debugPrint('Open FCM Message');

    if (messageHandler != null) {
      //???????????
      messageHandler(context, message);
    }
  }

  ///Phương thức mở tất cả tin nhắn
  static void fcmOpenAllMessageHandler(
      {required BuildContext context,
      Function(BuildContext context, List<MyNotificationMessage>)?
          messageHandler}) async {
    var listMess = await readMessage();
    if (messageHandler != null) {
      messageHandler(context, listMess!);
    }
  }

  ///Xây dựng một tin nhắn
  static String constructFCMPayLoad(
      {required String content, required String to, required bool topic}) {
    String address = (topic == true) ? '/topics/$to' : to;

    return jsonEncode({
      // 'token':token,
      'to': address,
      'priority': 'high',
      'data': <String, dynamic>{
        'via': 'FlutterFire Cloud Messaging!!!',
      },
      'notification': <String, dynamic>{
        'title': 'Hello FlutterFire',
        'body': content,
        'sound': true,
      },
    });
  }

  ///Phương thức hỗ trợ gửi tin nhắn bằng Http Post
  ///token: token của ứng dụng đang gửi thông báo
  static Future<http.Response> sendPushMessageHttpPost(
      String? message, String? token, String? authorizationKey) async {
    if (token == null) {
      debugPrint('No token, so we can not send your message');
      return Future.error('Chưa có token');
    }

    try {
      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${authorizationKey!}'
        },
        body: message,
      );
      debugPrint('FCM request for device sent $message');
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
  }
}
