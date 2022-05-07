import 'package:flutter/material.dart';

Future<String> showAlertDL(BuildContext context) async {
  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: const Text('Bạn có chắc muốn xóa người dùng này không?'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop('ok');
                },
                child: const Text('OK')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop('cancel');
                },
                child: const Text('cancel')),
          ],
        );
      });
}
