import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hello!'),
                Text('Please login with your account'),
              ],
            ),
          ),
          TextField(
            controller: name,
            decoration: InputDecoration(
              labelText: 'Name',
            ),
          ),
          TextField(
            controller: pass,
            decoration: InputDecoration(
              labelText: 'Pass',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => goHomePage(context, name.text, pass.text),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.login),
                  Text('Login'),
                ],
              ),
            ),
          ),
          Text('or login with'),
          Row(
            children: [
              ElevatedButton(
                onPressed: null,
                child: Row(
                  children: [
                    Icon(Icons.facebook),
                    Text('FaceBook'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: null,
                child: Row(
                  children: [
                    Icon(Icons.facebook),
                    Text('Google'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

goHomePage(BuildContext context, String name, String pass) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return MyHomePage(
      user: name,
      pass: pass,
    );
  }));
}

class MyHomePage extends StatelessWidget {
  // const MyHomePage({Key? key}) : super(key: key);
  late String user, pass;
  MyHomePage({required this.user, required this.pass});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(user),
          Text(pass),
        ],
      ),
    );
  }
}
