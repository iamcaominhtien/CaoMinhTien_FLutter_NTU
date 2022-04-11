import 'package:flutter/material.dart';

Future<String?> showConfirmDialog(BuildContext context) async {
  AlertDialog dialog = AlertDialog(
    title: Column(
      children: const [
        Icon(Icons.warning, size: 100, color: Colors.yellow),
        Text('Cảnh báo'),
      ],
    ),
    content: const Text('Hành động xóa không thể hoàn tác'),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop("cancel"),
            child: const Text('Hủy'),
          ),
          const SizedBox(
            width: 30,
          ),
          ElevatedButton(
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop("ok"),
            child: const Text('OK'),
          ),
        ],
      )
    ],
  );

  String? res = await showDialog(
    context: context,
    builder: (context) => dialog,
    barrierDismissible: false,
  );
  return res;
}
