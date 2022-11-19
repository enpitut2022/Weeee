import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/src/chat/chat_provider.dart';
import 'package:enpit_weee/src/chat/chat_room.dart';
import 'package:flutter/material.dart';

class ChatIndex extends StatelessWidget {
  // 引数からユーザー情報を受け取れるようにする
  const ChatIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('チャット'),
      ),
      body: Column(
        children: [
          Expanded(
              // Stream 非同期処理の結果を元にWidgetを作る
              child: StreamBuilder<QuerySnapshot>(
            // 投稿メッセージ一覧の取得
            stream: FirebaseFirestore.instance
                .collection('chat_room')
                .orderBy('createdAt')
                .snapshots(),
            builder: (context, snapshot) {
              // データが取得できた場合
              if (snapshot.hasData) {
                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                return ListView(
                  children: documents.map((document) {
                    return Card(
                      child: ListTile(
                        title: Text(document['name']),
                        trailing: IconButton(
                          icon: const Icon(Icons.input),
                          onPressed: () async {
                            // チャットページへ画面遷移
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChatRoom(document['name']);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
              // データが読込中の場合
              return const Center(
                child: Text('読込中……'),
              );
            },
          )),
        ],
      ),
    );
  }
}
