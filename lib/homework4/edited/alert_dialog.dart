import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future<String?> showConfirmDialog(BuildContext context) async {
  // AlertDialog dialog = AlertDialog(
  //   title: Column(
  //     children: const [
  //       Icon(Icons.warning, size: 100, color: Colors.yellow),
  //       Text('Cảnh báo'),
  //     ],
  //   ),
  //   content: const Text('Hành động xóa không thể hoàn tác'),
  //   actions: [
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         ElevatedButton(
  //           onPressed: () =>
  //               Navigator.of(context, rootNavigator: true).pop("cancel"),
  //           child: const Text('Hủy'),
  //         ),
  //         const SizedBox(
  //           width: 30,
  //         ),
  //         ElevatedButton(
  //           onPressed: () =>
  //               Navigator.of(context, rootNavigator: true).pop("ok"),
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     )
  //   ],
  // );
  //
  // String? res = await showDialog(
  //   context: context,
  //   builder: (context) => dialog,
  //   barrierDismissible: false,
  // );
  // return res;

  Alert(
    context: context,
    type: AlertType.warning,
    title: "RFLUTTER ALERT",
    desc: "Flutter is more awesome with RFlutter Alert.",
    buttons: [
      DialogButton(
        child: const Text(
          "COOL",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();

  return "ok";
}
