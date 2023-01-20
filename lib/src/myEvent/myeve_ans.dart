import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/my_widgets.dart';
import 'package:enpit_weee/src/model/event_model.dart';
import 'package:enpit_weee/src/model/user_model.dart';
import 'package:enpit_weee/src/myEvent/myeve_ans_detail.dart';
import 'package:flutter/material.dart';

class AnswerMyEvent extends StatefulWidget {
  AnswerMyEvent({
    required this.event,
    required this.loggedUser,
    super.key,
  });
  Event event;
  UserModels loggedUser;

  @override
  State<AnswerMyEvent> createState() => _AnswerMyEventState();
}

class _AnswerMyEventState extends State<AnswerMyEvent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: myAppBar('質問回答者一覧'),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("event")
            .doc(widget.event.documentID)
            .collection("answers")
            .snapshots(),
        builder: ((context, snapshot) {
          // データが取得できた場合
          if (snapshot.hasData) {
            final List<DocumentSnapshot> answers = snapshot.data!.docs;
            return ListView(
              children: answers.map((doc) {
                return Card(
                  child: ListTile(
                    title: Text(doc['name']),
                    subtitle: Text("${doc['old']}歳　${doc['gender']}"),
                    leading: Icon(Icons.account_circle, color:  myColor("main1"),),
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return AnswerDetail(
                              event: widget.event,
                              loggedUser: widget.loggedUser,
                              ans1: doc['ans1'],
                              ans2: doc['ans2'],
                              ans3: doc['ans3'],
                              old: doc['old'],
                              name: doc['name'],
                              gender: doc['gender'],
                              uid: doc['uid'],
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            );
          }
          // データが読込中の場合
          return const CircularProgressIndicator();
        }),
      ),
    );
  }
}




// import 'package:bubble/bubble.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:enpit_weee/src/event/event_quetion.dart';
// import 'package:enpit_weee/src/model/event_model.dart';
// import 'package:enpit_weee/src/model/user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// class AnswerMyEvent extends StatefulWidget {
//   AnswerMyEvent({required this.event, super.key});
//   Event event;

//   @override
//   State<AnswerMyEvent> createState() => _AnswerMyEventState();
// }

// class _AnswerMyEventState extends State<AnswerMyEvent> {
//   UserModels loggedUser = UserModels();

//   @override
//   void initState() {
//     super.initState();
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get()
//         .then((value) {
//       loggedUser = UserModels.fromMap(value.data());
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('質問回答者'),
//       ),
//       body: Container(
//         height: myHeight(context) * 0.99,
//         color: const Color.fromARGB(255, 214, 214, 214),
//         margin: const EdgeInsets.all(10),
//         padding: const EdgeInsets.all(10),
//         child: ListView(
//           children: [
//             Container(
//               alignment: const Alignment(0.0, 0),
//               height: 80,
//               width: 500,
//               margin: const EdgeInsets.all(5),
//               decoration: const BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(
//                     color: Colors.black,
//                     width: 5,
//                   ),
//                 ),
//               ),
//               child: Text(
//                 widget.event.name,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 50,
//                 ),
//               ),
//             ),
//             //Text(widget.event.),
//             StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection("event")
//                   .doc(widget.event.documentID)
//                   .collection("answers")
//                   .snapshots(),
//               builder: ((context, snapshot) {
//                 // データが取得できた場合
//                 if (snapshot.hasData) {
//                   final List<DocumentSnapshot> answers = snapshot.data!.docs;
//                   return ListView(
//                     children: answers.map((doc) {
//                       return Card(
//                         child: ListTile(
//                           title: Text(doc['name']),
//                         ),
//                       );
//                     }).toList(),
//                   );
//                 }
//                 // データが読込中の場合
//                 return const Center(
//                   child: Text('読込中……'),
//                 );
//               }),
//             ),   
//           ],
//         ),
//       ),
//     );
//   }
// }
