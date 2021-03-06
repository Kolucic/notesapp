import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/pages/homepage.dart';
import 'package:noteapp/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notes',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.white,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? LoginPage()
          : HomePage(user: FirebaseAuth.instance.currentUser),
    );
  }
}