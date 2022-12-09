// ログイン画面用Widget
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPass = GlobalKey<FormState>();

  //key for form
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();

    // サインインボタン
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        onPressed: () async {
          await signIn(emailController.text, passController.text);
        },
        child: const Text(
          "ログイン",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: const CircleAvatar(
                foregroundImage: AssetImage('images/weeee_logo.png'),
                radius: 60,
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: const Text(
                'ログイン ',
                style: TextStyle(fontSize: 40),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKeyEmail,
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Eメールアドレス',
                    prefixIcon: const Icon(Icons.account_circle),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Emailアドレスを入力してください";
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return "正しいEmailアドレスを入力してください";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    emailController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKeyPass,
                child: TextFormField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'パスワード',
                    prefixIcon: const Icon(Icons.key),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    RegExp regExp = RegExp(r'^.{6,10}$');
                    if (value!.isEmpty) {
                      return ("パスワードを入力してください");
                    }
                    if (!regExp.hasMatch(value)) {
                      return ("6字から10字で入力してください");
                    }
                    return null;
                  },
                  autofocus: false,
                  onSaved: (value) {
                    passController.text = value!;
                  },
                  textInputAction: TextInputAction.done,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/forgetpassword");
                },
                child: const Text(
                  'パスワードを忘れた方はこちら',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Center(
              child: signUpButton,
            ),
            // Container(
            //   alignment: Alignment.center,
            //   child: GestureDetector(
            //     onTap: () {
            //       setState(() async {
            //         await signIn(emailController.text, passController.text);
            //       });
            //     },
            //     child: const Padding(
            //       padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            //       child: Text(
            //         'Sign In',
            //       ),
            //     ),
            //   ),
            // ),

            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('新しいユーザーですか?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/sinup");
                    },
                    child: const Text(
                      'アカウント作成',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //login function
  Future<void> signIn(String email, String password) async {
    try {
      if (_formKeyEmail.currentState!.validate() &&
          _formKeyPass.currentState!.validate()) {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: 'Login Successful'),
                  Navigator.pushNamed(context, "/home"),
                });
      }
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(msg: 'Failed With Error Code: ${error.code}');
      Fluttertoast.showToast(
          msg: "${email.toString()}  ${password.toString()}");
      Fluttertoast.showToast(msg: error.toString());
      print(error.toString());
    }
  }
}
