import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PageFCMMessage extends StatelessWidget {
  const PageFCMMessage({Key? key, this.message}) : super(key: key);
  final RemoteMessage? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('You have had a message'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Title:  '),
                Text('${message?.notification?.title}'),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text('From:  '),
                Text('${message?.from}'),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text('Body:  '),
                Text('${message?.notification?.body}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
