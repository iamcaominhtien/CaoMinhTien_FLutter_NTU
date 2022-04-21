import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'change_notifier.dart';

class MyCounterPage extends StatefulWidget {
  const MyCounterPage({Key? key}) : super(key: key);

  @override
  State<MyCounterPage> createState() => _MyCounterPageState();
}

class _MyCounterPageState extends State<MyCounterPage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Counter>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider demo'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          debugPrint('"Add Icon" was pressed');
          // context.read<Counter>().increment();
          provider.increment();
        },
      ),
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.blue,
      //   child: Container(
      //     height: 50,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Số lần bạn bấm vào button:'),
            FutureBuilder<int>(
              future: provider.value,
              initialData: 0,
              builder: (context, snapshot) {
                // CircularProgressIndicator
                return Text('${snapshot.data}');
              },
            ),
            // Text('${context.watch<Counter>().value}'),
            // Consumer<Counter>(builder: (context, counter, child) {
            //   return Text(
            //     "${counter.value}",
            //     style: const TextStyle(fontSize: 40),
            //   );
            // }),
            // const Text('0',
            //     style: TextStyle(
            //       fontSize: 40,
            //     )),
          ],
        ),
      ),
    );
  }
}
