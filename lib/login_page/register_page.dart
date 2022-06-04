import 'package:caominhtien_61cntt2/firebase/dialog.dart';
import 'package:caominhtien_61cntt2/login_page/login_helper.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController txtEMail = TextEditingController();

  TextEditingController txtPassword = TextEditingController();

  TextEditingController txtRePassword = TextEditingController();
  bool hidePassword = true;
  final _formKey = GlobalKey<FormState>();
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Không được bỏ trống";
                  }
                  return null;
                },
                controller: txtEMail,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Không được bỏ trống";
                  }
                  return null;
                },
                controller: txtPassword,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  labelText: 'Your Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: const Icon(Icons.remove_red_eye),
                  ),
                ),
              ),
              hidePassword
                  ? TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Không được bỏ trống";
                        }
                        return null;
                      },
                      obscureText: true,
                      controller: txtRePassword,
                      decoration: const InputDecoration(
                          labelText: 'Retype Your Password'),
                    )
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xFF2196F3),
                    ),
                    shape:
                        MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    ))),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    error = '';
                    showSnackbar(context, 'Registering....', 600);
                    registerWithEmailAndPassword(
                            email: txtEMail.text, password: txtPassword.text)
                        .then((value) {
                      setState(() {
                        error = 'Đăng ký thành công';
                      });
                      showSnackbar(context, 'Registered successfully', 3);
                    }).catchError((e) {
                      setState(() {
                        error = e.toString();
                      });
                      showSnackbar(context, 'Registered not successfully', 3);
                    });
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.key,
                      color: Colors.white,
                    ),
                    Text(
                      '  Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Text(
                error ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
