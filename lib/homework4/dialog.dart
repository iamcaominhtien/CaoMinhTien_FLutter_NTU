import 'package:flutter/material.dart';

Future<String?> showConfirmDialog(BuildContext context, String message) async {
  AlertDialog dialog = AlertDialog(
    title: const Text('Xác nhận'),
    content: Text(message),
    actions: [
      ElevatedButton(
        onPressed: () =>
            Navigator.of(context, rootNavigator: true).pop("cancel"),
        child: const Text('Hủy'),
      ),
      ElevatedButton(
        onPressed: () => Navigator.of(context, rootNavigator: true).pop("ok"),
        child: const Text('OK'),
      ),
    ],
  );

  String? res = await showDialog(
    context: context,
    builder: (context) => dialog,
    barrierDismissible: false,
  );
  return res;
}
