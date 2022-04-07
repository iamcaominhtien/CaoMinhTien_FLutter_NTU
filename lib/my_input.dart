import 'package:flutter/material.dart';

class MyInputPage extends StatefulWidget {
  const MyInputPage({Key? key}) : super(key: key);

  @override
  State<MyInputPage> createState() => _MyInputPageState();
}

class _MyInputPageState extends State<MyInputPage> {
  TextEditingController txtNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Input page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: txtNameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Hello ${txtNameController.text}'),
                          duration: const Duration(
                            seconds: 3,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Click me!',
                    )),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyTextField extends StatefulWidget {
  const MyTextField({Key? key}) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  var username = '';
  var passwd = '';
  var address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Field'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: TextEditingController(text: username),
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                border: OutlineInputBorder(),
                counterText: '0 character',
                helperText: 'Helper text',
                labelText: 'User Name',
                hintText: 'Enter your user name',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: TextEditingController(text: passwd),
              decoration: const InputDecoration(
                helperText: 'Password must have least 6 characters',
                border: OutlineInputBorder(),
                icon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: TextEditingController(text: address),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.home),
                // icon: Icon(Icons.home),
                // errorText: 'Enter your address',
                border: OutlineInputBorder(),
                // hintText: 'Enter your address',
              ),
            ),
            // DropdownButtonFormField(
            //   items: items,
            //   onChanged: onChanged,
            // )
          ],
        ),
      ),
    );
  }
}
