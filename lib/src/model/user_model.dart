class UserModals {
  String? name;
  String? email;
  String? uid;
  int? old;
  String? gender;

  UserModals({
    this.name,
    this.uid,
    this.email,
    this.old,
    this.gender,
  });

  //firestoreから
  factory UserModals.fromMap(map) {
    return UserModals(
      name: map['name'],
      uid: map['uid'],
      email: map['email'],
      old: map['old'],
      gender: map['gender'],
    );
  }

  //firestoreへ
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'email': email,
      'old': old,
      'gender': gender,
    };
  }
}
