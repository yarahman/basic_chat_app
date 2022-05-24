import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final auth = FirebaseAuth.instance;
  void _submitAuthForm(String email, String passWord, String userName,
      bool isLogIn, BuildContext ctx) async {
    UserCredential authResult;
    try {
      if (isLogIn) {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: passWord);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: passWord);
        FirebaseFirestore.instance.collection('user').doc(authResult.user!.uid).set({
          'userName' : userName,
          'email' : email,
        });
      }
    } on PlatformException catch (err) {
      var message = 'an error occured! please check your credensial';

      if (err.message != null) {
        message = err.message!;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
      ),
    );
  }
}
