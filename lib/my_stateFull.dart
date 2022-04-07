import 'package:flutter/material.dart';

class MyStateFullWidget extends StatefulWidget {
  const MyStateFullWidget({Key? key}) : super(key: key);

  @override
  State<MyStateFullWidget> createState() => _MyStateFullWidgetState();
}

class _MyStateFullWidgetState extends State<MyStateFullWidget> {
  String st = "Yes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My StateFull Widget'),
      ),
      backgroundColor: Colors.yellow,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("My State $st"),
            ElevatedButton(
                onPressed: () {
                  // setState(() {
                  //   if (st == "Yes") {
                  //     st = "No";
                  //   } else {
                  //     st = "Yes";
                  //   }
                  // });
                  if (st == "Yes") {
                    st = "No";
                  } else {
                    st = "Yes";
                  }
                  setState(() {});
                },
                child: const Text(
                  "Click here!",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}

class MyCounter extends StatefulWidget {
  const MyCounter({Key? key}) : super(key: key);

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  int count = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Counter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    count += 1;
                  });
                },
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 30),
                    )),
              ),
              Text('$count',
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    count -= 1;
                  });
                },
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: const Text(
                      '-',
                      style: TextStyle(fontSize: 30),
                    )),
              ),
            ],
          ),
        ));
  }
}
