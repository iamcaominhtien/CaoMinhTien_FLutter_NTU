import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

///Đăng nhập bằng tài khoảng google
Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  debugPrint("${googleAuth?.accessToken}  ==  ${googleAuth?.idToken}");
  var credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  return FirebaseAuth.instance.signInWithCredential(credential);
}

///Đăng kí tài khoản bằng email, password
Future<UserCredential> registerWithEmailAndPassword(
    {required String email, required String password}) {
  try {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    // debugPrint('here');
    return Future.error(e.code);
  }
}

///Đăng nhập bằng email, password
Future<UserCredential> signInWithEmailAndPassword(
    {required String email, required String password}) async {
  try {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    return Future.error(e.code);
  }
}
