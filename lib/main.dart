import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notes',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.white,
      ),
      home: LoginPage(),
    );
  }
}
