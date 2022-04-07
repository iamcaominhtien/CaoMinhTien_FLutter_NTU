import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'change_notifier.dart';

class MyCounterPage extends StatelessWidget {
  const MyCounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider demo'),
      ),
      // floatingActionButton: IconButton(
      //   icon: const Icon(Icons.add, size: 50),
      //   onPressed: () {
      //     debugPrint('"Add Icon" was pressed');
      //     context.read<Counter>().increment();
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          debugPrint('"Add Icon" was pressed');
          context.read<Counter>().increment();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Container(
          height: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Số lần bạn bấm vào button:'),
            Text('${context.watch<Counter>().value}'),
            Consumer<Counter>(builder: (context, counter, child) {
              return Text(
                "${counter.value}",
                style: const TextStyle(fontSize: 40),
              );
            }),
            const Text('0',
                style: TextStyle(
                  fontSize: 40,
                )),
          ],
        ),
      ),
    );
  }
}
