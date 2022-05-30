import 'package:badges/badges.dart';
import 'package:caominhtien_61cntt2/fcm/page_list_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'message_helper.dart';
import 'page_message_fcm.dart';

String authorizationKey =
    'AAAAJ_l3hTY:APA91bHvxqgz4LRf79DkZLokcuAcZvfgxMPqiphB6m0IBSoLDDgfZxlPzKfX6Z-6_Lol9ikjYjcc7QgFVdiaJ43J0pXd5Tz12bBk3yHtzb136p0EKPuRDUiYJC5KtliN8s1lU0fMpE9D';
String topic = 'my_fcm_test';

class PageHomeFCM extends StatefulWidget {
  const PageHomeFCM({Key? key, this.mainContext}) : super(key: key);
  final BuildContext? mainContext;

  @override
  State<PageHomeFCM> createState() => _PageHomeFCMState();
}

class _PageHomeFCMState extends State<PageHomeFCM> {
  int count = 10; //Dùng để hiển thị số lượng tin nhắn
  int index = 0; //Dùng cho BottomNavigationBar
  String? token;
  String topicStatus = 'fcm_test';
  String incomingMessage = "No message";
  TextEditingController textContent = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Lấy ra token: đã có khi cài đặt ứng dụng
    FirebaseMessaging.instance.getToken().then((value) {
      debugPrint('Token message: $value');
      setState(() {
        token = value;
      });
    });

    //Đăng kí topic
    FirebaseMessaging.instance.subscribeToTopic(topic).whenComplete(() {
      setState(() {
        topicStatus = topic;
      });
    });

    //Lấy số lượng tin nhắn và cập nhật lên badget widget
    MessageHelper.getCountMessages().then((value) {
      setState(() {
        count = value;
      });
    });

    //Xử lí sự kiện tại chế độ nền, khi có tin nhắn đến, người dùng bấm vào xem trên thanh trạng thái
    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      MessageHelper.fcmOpenMessageHandler(
        context: context,
        message: remoteMessage,
        messageHandler: (context, message) {
          // setState(() {
          //   incomingMessage = message.notification?.body ?? "Không có nội dung";
          // });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PageFCMMessage(message: message),
            ),
          );
        },
      );
    });

    //Xử lí sự kiện khi ứng dụng bị tắt, khi có tin nhắn đến, người dùng bấm vào xem trên thanh trạng thái
    FirebaseMessaging.instance.getInitialMessage().then((remoteMessage) {
      if (remoteMessage != null) {
        MessageHelper.fcmOpenMessageHandler(
          context: context,
          message: remoteMessage,
          messageHandler: (context, message) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageFCMMessage(message: message),
              ),
            );
          },
        );
      }
    });

    //Sự kiện nhận tin nhắn ở chế độ foreground
    FirebaseMessaging.onMessage.listen((remoteMessage) {
      MessageHelper.fcmForegroundHandler(
        context: context,
        message: remoteMessage,
        messageHandler: (context, message) {
          setState(() {
            incomingMessage = message.notification?.body ?? "Không có nội dung";
          });

          MessageHelper.getCountMessages().then((value) {
            setState(() {
              count = value;
            });
          });
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(widget.mainContext!);
          },
        ),
        title: const Text('FCM Demo'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          if (value == 1 && count > 0) {
            setState(() {
              count = 0;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PageListMessage(),
              ),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.blue[800],
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              badgeColor: Colors.red,
              showBadge: count > 0,
              position: BadgePosition.topEnd(top: -12, end: -18),
              badgeContent: Text(
                count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              child: Icon(
                Icons.message,
                color: Colors.blue[800],
              ),
            ),
            label: 'Message',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('FCM token'),
              Text(authorizationKey),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text('Topic: '),
                  Text(topicStatus),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text('Message: '),
                  Text(incomingMessage),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseMessaging.instance
                        .subscribeToTopic(topic)
                        .whenComplete(() {
                      setState(() {
                        topicStatus = topic;
                      });
                    });
                  },
                  child: const Text('Subscribe to topic'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseMessaging.instance
                        .unsubscribeFromTopic(topic)
                        .whenComplete(() {
                      setState(() {
                        topicStatus = 'None';
                      });
                    });
                  },
                  child: const Text('Unsubscribe to topic'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: textContent,
                decoration: const InputDecoration(
                  labelText: 'Nội dung tin nhắn',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint(textContent.text);
                    String messageToSend = MessageHelper.constructFCMPayLoad(
                        content: textContent.text, to: topic, topic: true);
                    MessageHelper.sendPushMessageHttpPost(
                      messageToSend,
                      token,
                      authorizationKey,
                    );
                  },
                  child: const Text('Send message to topic'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    String messageToSend = MessageHelper.constructFCMPayLoad(
                        content: textContent.text, to: token!, topic: false);
                    MessageHelper.sendPushMessageHttpPost(
                        messageToSend, token, authorizationKey);
                  },
                  child: const Text('Send message to myself'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
