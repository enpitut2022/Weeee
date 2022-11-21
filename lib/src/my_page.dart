import 'package:enpit_weee/src/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Mypage extends StatefulWidget {
  const Mypage({super.key});
  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  @override
  Widget build(BuildContext context) {
    // ユーザー情報を受け取る
    final UserState userState = Provider.of<UserState>(context);
    final User user = userState.user!;
    return Scaffold(
        appBar: AppBar(
          title: const Text('マイページ'),
        ),
        body: Center(child: Text("ログイン情報 ${user.email}")));
  }
}
