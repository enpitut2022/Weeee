import 'package:enpit_weee/src/home_page.dart';
import 'package:enpit_weee/src/login/foregetpassword.dart';
import 'package:enpit_weee/src/login/login.dart';
import 'package:enpit_weee/src/login/sinup.dart';
import 'package:enpit_weee/src/profile/prof_edit.dart';
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
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(color: Colors.white),
        //fontFamily: 'latoTextTheme',
        primaryColor: Colors.white,
        // colorScheme: ColorScheme.fromSwatch(
        //   primarySwatch: Colors.blue,
        // ).copyWith(
        //   secondary: Colors.cyanAccent.shade400,
        // ),
      ),
      home: const Login(),
      routes: <String, WidgetBuilder>{  // 2. routesには「/」を含めない。
        '/login': (BuildContext context) => const Login(),
        '/sinup': (BuildContext context) => const SignUp(),
        '/forgetpassword': (BuildContext context) => const ForgotPassword(),
        '/home': (BuildContext context) => const HomePage(),
        '/editProfile': (BuildContext context) => const EditProfile(),
        //'/question' :(BuildContext context) =>  EventDetailQuestion(), できなかった12/14
      },
    );
  }
}

