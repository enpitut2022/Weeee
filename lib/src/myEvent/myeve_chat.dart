import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/my_widgets.dart';
import 'package:enpit_weee/src/model/user_model.dart';
import 'package:flutter/material.dart';

// flutter_chat_uiを使うためのパッケージをインポート
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom(this.roomName, this.loggedUser, {Key? key}) : super(key: key);
  final String roomName;
  final UserModels loggedUser;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  void initState() {
    _getMessages();
    super.initState();
  }

  // メッセージを取得するリスト
  List<types.Message> _messages = [];

  // snapshot()を使った方法
  void _getMessages() async {
    final getData = await FirebaseFirestore.instance
        .collection('chat_room')
        .doc(widget.roomName)
        .collection('contents')
        .orderBy("createdAt", descending: true)
        .snapshots();

    getData.listen(
      (event) {
        final message = event.docs.map((DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          return types.TextMessage(
            author: types.User(
              id: data['uid'],
              firstName: data['name'],
            ),
            createdAt: data['createdAt'],
            id: data['id'],
            text: data['text'],
          );
        }).toList();

        setState(() {
          _messages = [...message];
        });
      },
    );
  }

  // メッセージ内容をfirestoreにセット
  void _addMessage(types.TextMessage message) async {
    setState(() {
      _messages.insert(0, message);
    });
    await FirebaseFirestore.instance
        .collection('chat_room')
        .doc(widget.roomName)
        .collection('contents')
        .add({
      'uid': message.author.id,
      'name': message.author.firstName,
      'createdAt': message.createdAt,
      'id': message.id,
      'text': message.text,
    });
  }


  // メッセージ送信時の処理
  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: types.User(
        id: "${widget.loggedUser.uid}",
        firstName: "${widget.loggedUser.name}",
      ),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('チャット'),
      body: Chat(
        theme: const DefaultChatTheme(
          inputBackgroundColor: Colors.lightBlue,
          sendButtonIcon: Icon(Icons.send),
          sendingIcon: Icon(Icons.update_outlined),
        ),
        // ユーザーの名前を表示するかどうか
        showUserNames: true,
        // メッセージの配列
        messages: _messages,
        onSendPressed: _handleSendPressed,
        showUserAvatars: true,
        user: types.User(
          id: "${widget.loggedUser.uid}",
          firstName: "${widget.loggedUser.name}",
        ),
      ),
    );
  }
}
