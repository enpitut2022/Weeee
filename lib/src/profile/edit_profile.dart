import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/src/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  // 現在のユーザーの取得
  User? user = FirebaseAuth.instance.currentUser;
  UserModals loggedUser = UserModals();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedUser = UserModals.fromMap(value.data());
      setState(() {});
    });
  }

  String? errorMessage;
  final _auth = FirebaseAuth.instance;
  //our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final firstNameEditingController = TextEditingController();
  final oldEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  String? genderDefo = '-';

  static const TextStyle optionStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.normal);


  @override
  Widget build(BuildContext context) {
    //名前入力
    final firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return ("ニックネームは必ず入力してください");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "ニックネーム",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //年齢入力
    final oldField = TextFormField(
        autofocus: false,
        controller: oldEditingController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return ("年齢は必ず入力してください");
          } 
          return null;
        },
        onSaved: (value) {
          oldEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "年齢",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //性別入力
    final genderField = Row(
      children: [
        const Text(
          "性別",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 30,
        ),
        DropdownButton(
          value: genderDefo,
          onChanged: (String? value) {
            setState(() {
              genderDefo = value;
            });
          },
          items: const [
            DropdownMenuItem(
              value: '-',
              child: Text('-'),
            ),
            DropdownMenuItem(
              value: '男性',
              child: Text('男性'),
            ),
            DropdownMenuItem(
              value: '女性',
              child: Text('女性'),
            ),
            DropdownMenuItem(
              value: 'その他',
              child: Text('その他'),
            ),
          ],
        ),
      ],
    );

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        // minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
        },
        child: const Text(
          "編集を確定する",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

  return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('プロフィール編集'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blueAccent),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 180,
                        child: Image.asset(
                          "assets/images/signup.png",
                          fit: BoxFit.contain,
                        )),
                    const SizedBox(height: 45),
                    firstNameField,
                    const SizedBox(height: 20),
                    oldField,
                    const SizedBox(height: 20),
                    genderField,
                    const SizedBox(height: 20),
                    signUpButton,
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
