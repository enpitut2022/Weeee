import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/src/home_page.dart';
import 'package:enpit_weee/src/login/foregetpassword.dart';
import 'package:enpit_weee/src/login/login_page.dart';
import 'package:enpit_weee/src/login/sinup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'latoTextTheme',
        primaryColor: Colors.purple,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Colors.cyanAccent.shade400,
        ),
      ),
      home: Login(),
      routes: <String, WidgetBuilder>{  // 2. routesには「/」を含めない。
        '/login': (BuildContext context) => Login(),
        '/sinup': (BuildContext context) => SignUp(),
        '/forgetpassword': (BuildContext context) => ForgotPassword(),
        '/home': (BuildContext context) => HomePage(),
      },
    );
  }
}

