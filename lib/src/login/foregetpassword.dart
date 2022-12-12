import 'package:enpit_weee/src/login/auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  final AuthService auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget buildForm() => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Eメールアドレス',
                prefixIcon: const Icon(Icons.mail),
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              autofocus: false,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Eメールアドレスを入力してください";
                }
                if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                    .hasMatch(value)) {
                  return "正しいEメールアドレスを入力してください";
                }
                return null;
              },
              onSaved: (value) {
                emailController.text = value!;
              },
            ),
          ),
        );

    final forgotPasswordbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        onPressed: () async {
            await auth.sendPasswordResetEmail(emailController.text);
            if (!mounted) return;
            Navigator.pop(context);
        },
        child: const Text(
          "メール送信",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blueAccent),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              child: Image.asset('images/forget.png'),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'パスワードを変更する',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            buildForm(),
            Center(child: forgotPasswordbutton),
          ],
        ),
      ),
    );
  }
}
