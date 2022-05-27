

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'UserModel.dart';

late List<UserM> users;

void getAllUsers() {
  users = [];

  FirebaseFirestore.instance.collection('users').get().then((value) {

    value.docs.forEach((element) {
        users.add(UserM.fromMap(element.data()));
    });

    print("=====================>>>>>>>>>>>>${users.length}");
    print("=====================>>>>>>>>>>>>${users[0].email}");

  }).catchError((error) {
    print('=======================>>>>>>> Error $error');

  });
}

Future<void> deleteUser(String uId)
async {
  /// DELETE USER FROM AUTH
  FirebaseAuth.instance.currentUser!.delete();
   await FirebaseFirestore.instance.collection("users").doc(uId).delete().then((value){
    // to get updated users list after delete any user
    getAllUsers();
  });
}

