import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/src/login/login.dart';
import 'package:enpit_weee/src/model/user_model.dart';
import 'package:enpit_weee/src/profile/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  UserModals loggedUser = UserModals();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      loggedUser = UserModals.fromMap(value.data());
      setState(() {});
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.normal);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 19, 4, 4),
        title: const Text('マイページ'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                logout(context);
                //Navigator.pushNamed(context, "/login");
              });
            },
            child: const Text(
              'ログアウト',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            buildPro(),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Column(
                children: [
                  showData(Icons.account_circle, "${loggedUser.name}"),
                  showData(
                      Icons.format_list_numbered_sharp, "${loggedUser.old}"),
                  showData(Icons.people, "${loggedUser.gender}"),
                ],
              ),
            ),
            TextButton.icon(
              onPressed: (() {
                // ↓これではうまくいかなかった。なぜ？
                //Navigator.pushNamed(context, '/editProfile');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EditProfile(),
                  ),
                );
              }),
              label: const Text("編集"),
              icon: const Icon(Icons.edit),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPro() => Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueGrey,
        ),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: const [
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/weeee_logo.png'),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );

  Widget showData(IconData ico, String s) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(
              ico,
              color: const Color(0xff1976d2),
            ),
            const SizedBox(
              width: 50,
            ),
            Text(
              s,
              style: optionStyle,
            ),
          ],
        ),
      );

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()));
  }
}
