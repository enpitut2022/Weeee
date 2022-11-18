import 'package:enpit_weee/chat/chat_login.dart';
import 'package:enpit_weee/chat/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});
  // ユーザーの情報を管理するデータ。下のコードを書くとmainでエラー。必要性は？
  //final UserState userState = UserState();

  @override
  Widget build(BuildContext context) {
    // プロバイダーのステートを受け取る
    return ChangeNotifierProvider<UserState>(
      create: (context) => UserState(),
      child: MaterialApp(
        // アプリ名
        title: 'ChatApp',
        theme: ThemeData(
          // テーマカラー
          primarySwatch: Colors.blue,
        ),
        // ログイン画面を表示
        home: ChatLoginPage(),
      ),
    );
  }
}
