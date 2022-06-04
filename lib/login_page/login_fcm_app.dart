import 'package:caominhtien_61cntt2/login_page/firebasee_app/page_sv.dart';
import 'package:caominhtien_61cntt2/login_page/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:caominhtien_61cntt2/firebase/dialog.dart';

import 'login_helper.dart';

class LoginPageFCM extends StatefulWidget {
  const LoginPageFCM({Key? key}) : super(key: key);

  @override
  State<LoginPageFCM> createState() => _LoginPageFCMState();
}

class _LoginPageFCMState extends State<LoginPageFCM> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createFireBase();
  }

  _createFireBase() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Không được bỏ trống";
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Không được bỏ trống";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xFF20639B),
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    ),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      error = '';
                      showSnackbar(context, 'Signing in....', 600);
                      signInWithEmailAndPassword(
                              email: txtEmail.text, password: txtPass.text)
                          .then((value) {
                        // ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PageSinhVien(),
                          ),
                        ).catchError((e) {
                          setState(() {
                            error = e;
                          });
                        });
                        // Navigator.of(context).pushAndRemoveUntil(
                        //     MaterialPageRoute(
                        //       builder: (context) => const PageSinhVien(),
                        //     ),
                        //     (route) => false);
                        showSnackbar(
                            context,
                            'Hello ${FirebaseAuth.instance.currentUser?.email ?? "user"}',
                            3);
                      }).catchError((e) {
                        setState(() {
                          error = e.toString();
                        });
                        showSnackbar(context, 'Sign in not successfully', 3);
                      });
                    }
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/login_page/email.png',
                        width: 25.0,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text('Sign in with Email'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    " Don't have an account",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xFFBBDEFB),
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    ),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    showSnackbar(context, 'Signing in.....', 600);
                    try {
                      await signInWithGoogle();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PageSinhVien(),
                        ),
                      );
                      showSnackbar(
                          context,
                          'Hello ${FirebaseAuth.instance.currentUser?.email ?? "user"}',
                          3);
                    } catch (e) {
                      setState(() {
                        error = e.toString();
                        showSnackbar(
                            context, 'Signing in not successfully...', 3);
                      });
                    }
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/login_page/google.png',
                        width: 25.0,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Sign in with Google',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                error,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
