// 更新可能なデータ
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserState extends ChangeNotifier {
  User? user;

  void createUser(User user) {
    final uid = user.uid;

    // authだけでなく、firecloudにも追加
    final doc = FirebaseFirestore.instance.collection('users').doc(uid);
    doc.set({
      'uid': uid,
      'email': user.email,
    });
  }

  void setUser(User newUser) {
    user = newUser;
    notifyListeners();
  }
}
