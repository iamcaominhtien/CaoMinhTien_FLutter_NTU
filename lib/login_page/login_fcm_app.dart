import 'package:flutter/material.dart';

class LoginPageFCM extends StatefulWidget {
  const LoginPageFCM({Key? key}) : super(key: key);

  @override
  State<LoginPageFCM> createState() => _LoginPageFCMState();
}

class _LoginPageFCMState extends State<LoginPageFCM> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: txtEmail,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextFormField(
              controller: txtPass,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.email),
                      Text('Sign in with Email'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: const [
                  Icon(Icons.email),
                  Text("Don't have an account  "),
                  Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
