import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyContext extends StatelessWidget {
  const MyContext({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text("Click me"),
                onPressed: () {
                  Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "LEFT",
                    desc: "Flutter is more awesome with RFlutter Alert.",
                    buttons: [
                      DialogButton(
                        child: const Text(
                          "FLAT",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Alert(
                          context: context,
                          type: AlertType.warning,
                          title: "22",
                          desc: "Flutter is more awesome with RFlutter Alert.",
                          buttons: [
                            DialogButton(
                              child: const Text(
                                "22",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              color: Color.fromRGBO(0, 179, 134, 1.0),
                            ),
                          ],
                        ).show(),
                        color: const Color.fromRGBO(0, 179, 134, 1.0),
                      ),
                    ],
                  ).show();
                },
              ),
              ElevatedButton(
                child: const Text("Click me"),
                onPressed: () {
                  Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "RFLUTTER ALERT",
                    desc: "Flutter is more awesome with RFlutter Alert.",
                    buttons: [
                      DialogButton(
                        child: const Text(
                          "FLAT",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        color: Color.fromRGBO(0, 179, 134, 1.0),
                      ),
                    ],
                  ).show();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
