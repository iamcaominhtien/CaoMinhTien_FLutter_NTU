import 'package:flutter/material.dart';

void showMyDialog(BuildContext context, String message) async {
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.warning,
                color: Colors.yellow,
                size: 80,
              ),
              Text('Thông báo'),
            ],
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK')),
              ],
            )
          ],
        );
      });
}
